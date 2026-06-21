package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import db.DBConnection;
import util.AESUtil;
import util.EmailUtil;
import util.LogUtil;
import util.SteganographyUtil;

@WebServlet("/EncodeServlet")

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)

public class EncodeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(

            HttpServletRequest request,

            HttpServletResponse response)

            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out =
                response.getWriter();

        String patient =

                (String) request
                .getSession()
                .getAttribute("username");

        // SELECTED DOCTOR

        String doctorName =
                request.getParameter("doctor");

        String message =
                request.getParameter("message");

        try {

            // SESSION CHECK

            if(patient == null){

                response.sendRedirect("login.jsp");

                return;
            }

            // AES ENCRYPTION

            String encryptedText =
                    AESUtil.encrypt(message);

            // COVER TEXT

            String coverText =
                    "Patient report generated successfully.";

            // TEXT STEGANOGRAPHY

            String stegoText =

                    SteganographyUtil.hideText(
                            coverText,
                            encryptedText);

            // FILE UPLOAD

            Part filePart =
                    request.getPart("reportFile");

            String fileName =
                    filePart.getSubmittedFileName();

            // EMPTY FILE CHECK

            if(fileName == null || fileName.equals("")){

                out.println(

"<html><body style='font-family:Arial;background:#f2f2f2;text-align:center;padding-top:100px;'>"

+

"<div style='background:white;width:500px;margin:auto;padding:40px;border-radius:10px;'>"

+

"<h2 style='color:red;'>No File Selected!</h2>"

+

"<a href='patient_dashboard.jsp' style='padding:12px 20px;background:#007bff;color:white;text-decoration:none;border-radius:5px;'>Back</a>"

+

"</div></body></html>");

                return;
            }

            // DOCTOR VALIDATION

            if(doctorName == null || doctorName.equals("")){

                out.println(

"<html><body style='font-family:Arial;background:#f2f2f2;text-align:center;padding-top:100px;'>"

+

"<div style='background:white;width:500px;margin:auto;padding:40px;border-radius:10px;'>"

+

"<h2 style='color:red;'>Please Select Doctor!</h2>"

+

"<a href='encode.jsp' style='padding:12px 20px;background:#007bff;color:white;text-decoration:none;border-radius:5px;'>Back</a>"

+

"</div></body></html>");

                return;
            }

            // FILE TYPE VALIDATION

            String lowerFileName =
                    fileName.toLowerCase();

            if (!(lowerFileName.endsWith(".pdf")

                    || lowerFileName.endsWith(".jpg")

                    || lowerFileName.endsWith(".jpeg")

                    || lowerFileName.endsWith(".png"))) {

                out.println(

"<html><body style='font-family:Arial;text-align:center;padding-top:100px;background:#f2f2f2;'>"

+

"<div style='background:white;width:500px;margin:auto;padding:40px;border-radius:10px;'>"

+

"<h2 style='color:red;'>Invalid File Type!</h2>"

+

"<p>Only PDF, JPG, JPEG, PNG files are allowed.</p>"

+

"<a href='patient_dashboard.jsp' style='padding:12px 20px;background:#007bff;color:white;text-decoration:none;border-radius:5px;'>"

+

"Back"

+

"</a>"

+

"</div></body></html>");

                return;
            }

            // FILE SIZE VALIDATION

            long fileSize =
                    filePart.getSize();

            if (fileSize > 5 * 1024 * 1024) {

                out.println(

"<html><body style='font-family:Arial;text-align:center;padding-top:100px;background:#f2f2f2;'>"

+

"<div style='background:white;width:500px;margin:auto;padding:40px;border-radius:10px;'>"

+

"<h2 style='color:red;'>File Too Large!</h2>"

+

"<p>Maximum allowed file size is 5MB.</p>"

+

"<a href='patient_dashboard.jsp' style='padding:12px 20px;background:#007bff;color:white;text-decoration:none;border-radius:5px;'>"

+

"Back"

+

"</a>"

+

"</div></body></html>");

                return;
            }

            // PROJECT UPLOAD PATH

            String uploadPath =

                    getServletContext().getRealPath("")
                    + File.separator
                    + "uploads";

            File uploadDir =
                    new File(uploadPath);

            if (!uploadDir.exists()) {

                uploadDir.mkdirs();
            }

            // UNIQUE FILE NAME

            String uniqueFileName =

                    System.currentTimeMillis()
                    + "_"
                    + fileName;

            String fullPath =

                    uploadPath
                    + File.separator
                    + uniqueFileName;

            // SAVE FILE

            filePart.write(fullPath);

            // DATABASE INSERT

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =

                    con.prepareStatement(

"insert into reports(patient_name,doctor_name,secret_data,stego_text,file_name) values(?,?,?,?,?)");

            ps.setString(1, patient);

            ps.setString(2, doctorName);

            ps.setString(3, encryptedText);

            ps.setString(4, stegoText);

            ps.setString(5, uniqueFileName);

            int result =
                    ps.executeUpdate();

            if (result > 0) {

                // SEND EMAIL TO SELECTED DOCTOR

                PreparedStatement doctorPs =

                        con.prepareStatement(

"select email from users where username=? and role='doctor'");

                doctorPs.setString(1, doctorName);

                ResultSet doctorRs =

                        doctorPs.executeQuery();

                if (doctorRs.next()) {

                    String doctorEmail =

                            doctorRs.getString("email");

                    try {

                        EmailUtil.sendEmail(

                                doctorEmail,

                                "New Secure Medical Report",

                                "Patient "
                                + patient
                                + " uploaded a secure medical report for you.");

                    } catch(Exception mailException){

                        mailException.printStackTrace();
                    }
                }

                // ACTIVITY LOG

                LogUtil.addLog(

                        patient,

                        "Uploaded Medical Report For Doctor: "
                        + doctorName);

                // SUCCESS PAGE

                out.println(

"<html>"

+

"<head>"

+

"<title>Upload Success</title>"

+

"<style>"

+

"body{"

+

"font-family:Arial;"

+

"background:#f2f2f2;"

+

"text-align:center;"

+

"padding-top:80px;"

+

"}"

+

".box{"

+

"background:white;"

+

"width:650px;"

+

"margin:auto;"

+

"padding:40px;"

+

"border-radius:10px;"

+

"box-shadow:0px 0px 10px rgba(0,0,0,0.2);"

+

"}"

+

".data{"

+

"background:#eee;"

+

"padding:20px;"

+

"border-radius:5px;"

+

"word-wrap:break-word;"

+

"font-size:14px;"

+

"margin-top:15px;"

+

"}"

+

"a{"

+

"padding:12px 20px;"

+

"background:#007bff;"

+

"color:white;"

+

"text-decoration:none;"

+

"border-radius:5px;"

+

"}"

+

"</style>"

+

"</head>"

+

"<body>"

+

"<div class='box'>"

+

"<h2 style='color:green;'>Medical Report Uploaded Successfully</h2>"

+

"<h3>Assigned Doctor</h3>"

+

"<div class='data'>"

+

doctorName

+

"</div>"

+

"<br>"

+

"<h3>Encrypted Data</h3>"

+

"<div class='data'>"

+

encryptedText

+

"</div>"

+

"<br>"

+

"<h3>Steganography Status</h3>"

+

"<div style='background:#d4edda;padding:15px;border-radius:5px;color:green;font-weight:bold;'>"

+

"Stego Data Hidden Successfully"

+

"</div>"

+

"<br><br>"

+

"<a href='patient_dashboard.jsp'>"

+

"Back to Dashboard"

+

"</a>"

+

"</div>"

+

"</body>"

+

"</html>");
            }

            else {

                out.println(

"<h2>Upload Failed</h2>");
            }

            con.close();

        }

        catch (Exception e) {

            out.println(

"<html><body style='font-family:Arial;background:#f2f2f2;text-align:center;padding-top:100px;'>"

+

"<div style='background:white;width:600px;margin:auto;padding:40px;border-radius:10px;'>"

+

"<h2 style='color:red;'>Error Occurred</h2>"

+

"<p>"

+ e.getMessage()

+ "</p>"

+

"<br>"

+

"<a href='patient_dashboard.jsp' style='padding:12px 20px;background:#007bff;color:white;text-decoration:none;border-radius:5px;'>Back</a>"

+

"</div></body></html>");

            e.printStackTrace();
        }
    }
}