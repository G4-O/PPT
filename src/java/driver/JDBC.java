/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package driver;
import java.sql.*;
/**
 *
 * @author umarzein
 */
public class JDBC {
    Connection con;
    Statement stmt;
    public boolean isConnected;
    public String message;
    public JDBC(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/perpustakaan_db","root","");
            stmt = con.createStatement();
            isConnected = true;
            message = "DB connected";
        } catch(Exception e) {
            
            isConnected = false;
            message = "error:"+e.getMessage();
        }
    }
    public void disconnect() {
        try {
            stmt.close();
            con.close();
            message = "DB disconnected";
        } catch(Exception e) {
            message = e.getMessage();
        }
    }
    
    // CREATE TABLE ..(...)..
}
