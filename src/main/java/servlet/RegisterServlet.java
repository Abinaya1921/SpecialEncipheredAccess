package servlet;

import util.HashUtil;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")

public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public RegisterServlet() {

        super();
    }

    protected void doPost(

            HttpServletRequest request,

            HttpServletResponse response)

            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out =
                response.getWriter();

        String username =
                request.getParameter("username");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        String hashedPassword =
                HashUtil.hashPassword(password);

        String role =
                request.getParameter("role");

        try {

            Connection con =
                    DBConnection.getConnection();

            String query =

"INSERT INTO users(username,email,password,role) VALUES(?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setString(1, username);

            ps.setString(2, email);

            ps.setString(3, hashedPassword);

            ps.setString(4, role);

            int result =
                    ps.executeUpdate();

            if (result > 0) {

                out.println(

"<html>"

+

"<head>"

+

"<title>Registration Success</title>"

+

"<style>"

+

"*{"

+

"margin:0;"

+

"padding:0;"

+

"box-sizing:border-box;"

+

"font-family:Arial;"

+

"}"

+

"body{"

+

"height:100vh;"

+

"display:flex;"

+

"justify-content:center;"

+

"align-items:center;"

+

"background:linear-gradient(to right,#4facfe,#00f2fe);"

+

"}"

+

".box{"

+

"width:450px;"

+

"background:white;"

+

"padding:50px;"

+

"border-radius:15px;"

+

"text-align:center;"

+

"box-shadow:0px 0px 15px rgba(0,0,0,0.3);"

+

"}"

+

"h1{"

+

"color:#28a745;"

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

"display:inline-block;"

+

"padding:12px 25px;"

+

"background:#007bff;"

+

"color:white;"

+

"text-decoration:none;"

+

"border-radius:8px;"

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

"<h1>Registration Successful</h1>"

+

"<p>Your account has been created successfully.</p>"

+

"<a href='login.jsp'>"

+

"Login Now"

+

"</a>"

+

"</div>"

+

"</body>"

+

"</html>"

                );

            } else {

                out.println(

"<html>"

+

"<body>"

+

"<h2>Registration Failed</h2>"

+

"</body>"

+

"</html>"
                );
            }

            con.close();

        } catch (Exception e) {

            out.println(

"<html>"

+

"<body style='font-family:Arial;text-align:center;padding-top:100px;'>"

+

"<h2 style='color:red;'>Error :</h2>"

+

"<p>"

+

e.getMessage()

+

"</p>"

+

"</body>"

+

"</html>"
            );

            e.printStackTrace();
        }
    }
}