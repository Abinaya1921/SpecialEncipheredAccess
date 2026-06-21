package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBConnection;
import util.HashUtil;

@WebServlet("/ForgotPasswordServlet")

public class ForgotPasswordServlet
extends HttpServlet {

    protected void doPost(

            HttpServletRequest request,

            HttpServletResponse response)

            throws ServletException,
            IOException {

        response.setContentType(
                "text/html");

        try{

            String username =
                    request.getParameter(
                            "username");

            String newPassword =
                    request.getParameter(
                            "newPassword");

            String hashedPassword =
                    HashUtil.hashPassword(
                            newPassword);

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(

"update users set password=? where username=?");

            ps.setString(1,
                    hashedPassword);

            ps.setString(2,
                    username);

            int result =
                    ps.executeUpdate();

            if(result > 0){

                response.getWriter().println(

"<html><body style='font-family:Arial;text-align:center;padding-top:100px;'>"

+

"<h2 style='color:green;'>"

+

"Password Reset Successful"

+

"</h2>"

+

"<a href='login.jsp'>"

+

"Login Now"

+

"</a>"

+

"</body></html>");

            }else{

                response.getWriter().println(

"<h2>User Not Found</h2>");
            }

            con.close();

        }catch(Exception e){

            e.printStackTrace();
        }
    }
}