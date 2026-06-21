package servlet;

import java.io.IOException;
import util.HashUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.LogUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.DBConnection;

@WebServlet("/LoginServlet")

public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(

            HttpServletRequest request,

            HttpServletResponse response)

            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        String hashedPassword =
                HashUtil.hashPassword(password);

        try {

            Connection con =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM users WHERE username=? AND password=?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setString(1, username);

            ps.setString(2, hashedPassword);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                String role =
                        rs.getString("role");

                HttpSession session =
                        request.getSession();

                // SESSION VARIABLES

                session.setAttribute(
                        "username",
                        username);

                session.setAttribute(
                        "role",
                        role);

                // SESSION TIMEOUT
                // 300 seconds = 5 minutes

                session.setMaxInactiveInterval(300);

                // ACTIVITY LOG

                LogUtil.addLog(
                        username,
                        "User Logged In");

                // ROLE REDIRECT

                if(role.equalsIgnoreCase("admin")) {

                    response.sendRedirect(
                            "admin_dashboard.jsp");

                }

                else if(role.equalsIgnoreCase("doctor")) {

                    response.sendRedirect(
                            "doctor_dashboard.jsp");

                }

                else if(role.equalsIgnoreCase("patient")) {

                    response.sendRedirect(
                            "patient_dashboard.jsp");

                }

                else {

                    response.getWriter().println(
                            "Invalid Role");
                }

            }

            else {

                response.setContentType(
                        "text/html");

                response.getWriter().println(

"<html>"

+

"<head>"

+

"<title>Login Failed</title>"

+

"<style>"

+

"body{"

+

"margin:0;"

+

"padding:0;"

+

"font-family:Arial;"

+

"background:linear-gradient(to right,#4facfe,#00f2fe);"

+

"display:flex;"

+

"justify-content:center;"

+

"align-items:center;"

+

"height:100vh;"

+

"}"

+

".box{"

+

"background:white;"

+

"padding:50px;"

+

"width:400px;"

+

"text-align:center;"

+

"border-radius:10px;"

+

"box-shadow:0px 0px 15px rgba(0,0,0,0.2);"

+

"}"

+

"h1{"

+

"color:#007bff;"

+

"margin-bottom:20px;"

+

"}"

+

"p{"

+

"font-size:18px;"

+

"color:#555;"

+

"margin-bottom:30px;"

+

"}"

+

"a{"

+

"text-decoration:none;"

+

"padding:12px 20px;"

+

"background:#007bff;"

+

"color:white;"

+

"border-radius:5px;"

+

"font-size:16px;"

+

"}"

+

"a:hover{"

+

"background:#0056b3;"

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

"<h1>Login Failed</h1>"

+

"<p>Invalid Username or Password</p>"

+

"<a href='login.jsp'>"

+

"Back to Login"

+

"</a>"

+

"</div>"

+

"</body>"

+

"</html>");
            }

            con.close();

        }

        catch(Exception e) {

            e.printStackTrace();
        }
    }
}