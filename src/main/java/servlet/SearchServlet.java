package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBConnection;

@WebServlet("/SearchServlet")

public class SearchServlet
extends HttpServlet {

    private static final long
    serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,

            HttpServletResponse response)

            throws ServletException,
            IOException {

        String patient =
                request.getParameter(
                        "patient");

        response.setContentType(
                "text/html");

        PrintWriter out =
                response.getWriter();

        try{

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(

                    "select * from reports where patient_name=?");

            ps.setString(1, patient);

            ResultSet rs =
                    ps.executeQuery();

            out.println(
                    "<h1>Search Results</h1>");

            while(rs.next()){

                out.println(
                "<h3>Patient : "
                + rs.getString(2)
                + "</h3>");

                out.println(
                "<h3>Encrypted Data : "
                + rs.getString(4)
                + "</h3>");

                out.println(
                "<h3>File Name : "
                + rs.getString(5)
                + "</h3>");

                out.println("<hr>");
            }

            con.close();

        }catch(Exception e){

            e.printStackTrace();
        }
    }
}