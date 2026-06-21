package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.LogUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBConnection;
import util.AESUtil;
import util.SteganographyUtil;

@WebServlet("/DecodeServlet")

public class DecodeServlet
extends HttpServlet {

    private static final long
    serialVersionUID = 1L;

    protected void doPost(

            HttpServletRequest request,

            HttpServletResponse response)

            throws ServletException,
            IOException {

        response.setContentType(
                "text/html");

        try {

            int reportId = Integer.parseInt(

                    request.getParameter(
                            "reportId"));

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(

                    "select * from reports where id=?");

            ps.setInt(1, reportId);

            ResultSet rs =
                    ps.executeQuery();

            String stegoText = "";

            String fileName = "";

            if(rs.next()) {

                stegoText =
                        rs.getString(4);

                fileName =
                        rs.getString(5);
            }

            // Extract hidden encrypted text

            String encryptedText =

                    SteganographyUtil
                    .extractText(stegoText);

            // AES decrypt

            String originalMessage =

                    AESUtil.decrypt(
                            encryptedText);
            String doctor =

            		(String)request.getSession()
            		.getAttribute("username");

            		LogUtil.addLog(

            		doctor,

            		"Decrypted Patient Report");
            response.getWriter().println(

            "<html>" +

            "<head>" +

            "<title>Decrypted Report</title>" +

            "<style>" +

            "body{" +

            "font-family:Arial;" +

            "background:#f2f2f2;" +

            "text-align:center;" +

            "padding-top:80px;" +

            "}" +

            ".box{" +

            "background:white;" +

            "width:550px;" +

            "margin:auto;" +

            "padding:40px;" +

            "border-radius:10px;" +

            "box-shadow:0px 0px 10px rgba(0,0,0,0.2);" +

            "}" +

            ".data{" +

            "background:#eee;" +

            "padding:20px;" +

            "border-radius:5px;" +

            "font-size:18px;" +

            "margin-top:20px;" +

            "}" +

            "a{" +

            "display:inline-block;" +

            "margin-top:20px;" +

            "padding:12px 20px;" +

            "background:#007bff;" +

            "color:white;" +

            "text-decoration:none;" +

            "border-radius:5px;" +

            "}" +

            "</style>" +

            "</head>" +

            "<body>" +

            "<div class='box'>" +

            "<h2 style='color:green;'>"

            +

            "Decrypted Medical Report"

            +

            "</h2>" +

            "<div class='data'>"

            +

            originalMessage

            +

            "</div>" +

            "<br><br>" +

            "<a href='uploads/"

            +

            fileName

            +

            "' target='_blank'>"

            +

            "View Uploaded Report"

            +

            "</a>"

            +

            "<br><br>" +

            "<a href='viewReports.jsp'>"

            +

            "Back to Dashboard"

            +

            "</a>" +

            "</div>" +

            "</body></html>");

            con.close();

        } catch(Exception e) {

            response.getWriter().println(

                    "<h2>Error : "

                    + e.getMessage()

                    + "</h2>");

            e.printStackTrace();
        }
    }
}