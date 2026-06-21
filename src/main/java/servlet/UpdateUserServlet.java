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

@WebServlet("/UpdateUserServlet")

public class UpdateUserServlet
extends HttpServlet {

    protected void doPost(

            HttpServletRequest request,

            HttpServletResponse response)

            throws ServletException,
            IOException {

        try {

            int id = Integer.parseInt(
                    request.getParameter("id"));

            String username =
                    request.getParameter(
                            "username");

            String password =
                    request.getParameter(
                            "password");

            String role =
                    request.getParameter(
                            "role");

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(

                    "update users set username=?,password=?,role=? where id=?");

            ps.setString(1, username);

            ps.setString(2, password);

            ps.setString(3, role);

            ps.setInt(4, id);

            ps.executeUpdate();

            response.sendRedirect(
                    "manageUsers.jsp");

        } catch(Exception e){

            e.printStackTrace();
        }
    }
}