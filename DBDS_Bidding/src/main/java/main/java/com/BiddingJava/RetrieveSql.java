package main.java.com.BiddingJava;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.*;


public class RetrieveSql extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try { 
		PrintWriter out = resp.getWriter();
		
        Connection con = null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
        Statement stmt=con.createStatement();  
        ResultSet rs=stmt.executeQuery("select * from users"); 
        
        String entered_password = req.getParameter("password");
        String entered_username = req.getParameter("username");
        String entered_userp = req.getParameter("user_type");
        boolean user_flag = false;
        
        while(rs.next())  {
        	String username = rs.getString(1);
        	String password = rs.getString(2);
        	if(username.equals(entered_username)){
        		user_flag = true;
        		if (password.equals(entered_password)) {
        			if (entered_userp.equals("Seller"))
        				resp.sendRedirect("portal/dashboard_seller.jsp?id2="+username);
        			else
        				resp.sendRedirect("portal/dashboard.jsp?id="+username);}
        		else		
        			out.print("Incorrect Credentials");}
        	
        }
        if(user_flag==false)
        	System.out.print("Incorrect Credentials");
        
        con.close();
    }
    catch(Exception e){ 
    	System.out.println(e);
    	}
	}
}