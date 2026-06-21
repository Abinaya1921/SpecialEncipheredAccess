package util;

import java.sql.Connection;
import java.sql.PreparedStatement;

import db.DBConnection;

public class LogUtil {

    public static void addLog(

            String username,

            String activity){

        try{

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(

"insert into logs(username,activity) values(?,?)");

            ps.setString(1, username);

            ps.setString(2, activity);

            ps.executeUpdate();

            con.close();

        }catch(Exception e){

            e.printStackTrace();
        }
    }
}