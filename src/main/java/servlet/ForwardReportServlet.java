package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBConnection;
import util.LogUtil;

@WebServlet("/ForwardReportServlet")

public class ForwardReportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(

            HttpServletRequest request,

            HttpServletResponse response)

            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out =
                response.getWriter();

        String reportId =
                request.getParameter("reportId");

        String doctorName =
                request.getParameter("doctorName");

        try{

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(

"update reports set doctor_name=? where id=?");

            ps.setString(1, doctorName);

            ps.setInt(2,
                    Integer.parseInt(reportId));

            int result =
                    ps.executeUpdate();

            if(result > 0){

                LogUtil.addLog(

                        doctorName,

                        "Report Forwarded");

                out.println(

"<html>"

+

"<head>"

+

"<title>Report Shared</title>"

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

"padding-top:100px;"

+

"}"

+

".box{"

+

"background:white;"

+

"width:500px;"

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

"a{"

+

"display:inline-block;"

+

"margin-top:20px;"

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

"<h1 style='color:green;'>"

+

"Report Shared Successfully"

+

"</h1>"

+

"<p>"

+

"Secure medical report forwarded to Dr. "

+

doctorName

+

"</p>"

+

"<a href='viewReports.jsp'>"

+

"Back"

+

"</a>"

+

"</div>"

+

"</body>"

+

"</html>");
            }

            else{

                out.println(
                        "Forward Failed");
            }

            con.close();

        }catch(Exception e){

            e.printStackTrace();
        }
    }
}