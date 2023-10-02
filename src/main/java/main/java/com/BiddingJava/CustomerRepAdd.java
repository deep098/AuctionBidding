package main.java.com.BiddingJava;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.*;


public class CustomerRepAdd extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try { 
		PrintWriter out = resp.getWriter();
		
        Connection con = null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
        Statement stmt = con.createStatement();  
        Enumeration e = req.getParameterNames();
        
        String name =  req.getParameter("name");
        String password = req.getParameter("password");
        
        boolean match =  checkUserAlreadyExists(name, con);

        if(!match) {
        	String msg = match + " already exists";
			out.println("<script type=\"text/javascript\">");
			out.println("alert('"+msg+"');");
			out.println("location='create_customer.jsp';");
			out.println("</script>");
        }
        else {
        	
        	
        	PreparedStatement ps= con.prepareStatement("insert into customer_rep values(?,?)");
        		
			ps.setString(1,name);
			ps.setString(2,password);
			
			int x = ps.executeUpdate();
			
			if(x > 0){
				String msg="Account Registered";
				System.out.println("Reached");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('"+msg+"');");
				out.println("location='admin.jsp';");
				out.println("</script>");
				
			}
        }
        }
	catch(Exception e) {
		System.out.println(e);
	}
	}
	public boolean checkUserAlreadyExists(String name, Connection conn) {
		try {
			PreparedStatement ps = conn.prepareStatement("Select count(1) as count from customer_rep where username = ?");
			ps.setString(1, name);
			ResultSet rs = ps.executeQuery();

			if(rs.next()) {
				String count = rs.getString("count");
				if(Integer.valueOf(count) == 1) {
					return false;
				}
			}
					}
		catch(Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	
}
 