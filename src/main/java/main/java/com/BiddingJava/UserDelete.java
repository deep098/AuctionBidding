package main.java.com.BiddingJava;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserDelete extends HttpServlet{
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try { 
			PrintWriter out = resp.getWriter();
	String[] checkedValues = req.getParameterValues("delete_flag");
	Class.forName("com.mysql.jdbc.Driver");
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
	Statement stmt1 = connection.createStatement();
	
	for(String s: checkedValues) {
		
		String sql = "delete from user_details where username='"+s+"'";
		
		stmt1.executeUpdate(sql);

		
		sql = "delete from users where username='"+s+"'";
		
		stmt1.executeUpdate(sql);
		

	}
	String msg="User Deleted";
	
	out.println("<script type=\"text/javascript\">");
	out.println("alert('"+msg+"');");
	out.println("location='customerrep_login.jsp';");
	out.println("</script>");
	}
	catch(Exception e) {
		System.out.println(e);}
	}
}
