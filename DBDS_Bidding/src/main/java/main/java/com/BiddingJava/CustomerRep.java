package main.java.com.BiddingJava;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.*;


public class CustomerRep extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try { 
		PrintWriter out = resp.getWriter();
		
        Connection con = null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
        Statement stmt=con.createStatement();  
        ResultSet rs=stmt.executeQuery("select * from customer_rep"); 
        
        String entered_password = req.getParameter("password");
        String entered_username = req.getParameter("username");
        
        boolean user_flag = false;
        
        while(rs.next())  {
        	String username = rs.getString(1);
        	String password = rs.getString(2);
        	if(username.equals(entered_username)){
        		user_flag = true;
        		if (password.equals(entered_password)) 
        			resp.sendRedirect("customer_rep.jsp");
        		else		
        			out.print("Incorrect Credentials");}
        	
        }
        rs.close();
        con.close();
    }
    catch(Exception e){ 
    	System.out.println(e);
    	}
	}
}