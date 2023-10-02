package main.java.com.BiddingJava;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.*;




public class Signup extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try { 
		PrintWriter out = resp.getWriter();
		
        Connection con = null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
        Statement stmt = con.createStatement();  
            
        String firstname = req.getParameter("firstName");
        firstname = firstname.substring(0, 1).toUpperCase() + firstname.substring(1);
        
        String lastname = req.getParameter("lastName");
        lastname = lastname.substring(0, 1).toUpperCase() + lastname.substring(1);
        
        String phoneno = req.getParameter("phoneNo");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String gender = req.getParameter("Gender");
        String usertype = req.getParameter("User");
        String match =  checkUserAlreadyExists(phoneno, email, con);

        if(!match.equals("None")) {
        	String msg = match + " already exists";
//			CustomLogger.log(msg);

			out.println("<script type=\"text/javascript\">");
			out.println("alert('"+msg+"');");
			out.println("location='signup.jsp';");
			out.println("</script>");
        }
        else {
        	String username = generateUserName(firstname, lastname, con);
        	
        	PreparedStatement ps= con.prepareStatement("insert into user_details(username,firstname,lastname,phoneno,email,gender,usertype) values(?,?,?,?,?,?,?)");
        		
			ps.setString(1,username);
			ps.setString(2,firstname);
			ps.setString(3,lastname);
			ps.setString(4,phoneno);
			ps.setString(5,email);
			ps.setString(6,gender);
			ps.setString(7,usertype);
			
			PreparedStatement ps1 = con.prepareStatement("insert into users(username,password) values(?,?)");
			
			ps1.setString(1,username);
			ps1.setString(2,password);
			ps1.executeUpdate();

			int x = ps.executeUpdate();
			
			if(x > 0){
				String msg="Account Registered. Your username is " + username;
//				CustomLogger.log(msg);
				System.out.println("Reached");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('"+msg+"');");
				out.println("location='login.jsp';");
				out.println("</script>");
				
			}
        }
        }
	catch(Exception e) {
		System.out.println(e);
	}
	}
	public String checkUserAlreadyExists(String phone, String email, Connection conn) {
		try {
			PreparedStatement ps = conn.prepareStatement("Select count(1) as count from user_details where phoneno = ?");
			ps.setString(1, phone);
			ResultSet rs = ps.executeQuery();

			if(rs.next()) {
				String count = rs.getString("count");
				if(Integer.valueOf(count) == 1) {
					return "Phone number";
				}
			}
			
			ps = conn.prepareStatement("Select count(1) as count from user_details where email = ?");
			ps.setString(1, email);
			rs = ps.executeQuery();

			if(rs.next()) {
				String count = rs.getString("count");
				if(Integer.valueOf(count) == 1) {
					return "Email ID";
				}
			}

		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return "None";
	}
	public String generateUserName(String firstname, String lastname, Connection conn) {
        Random rand = new Random();
        int rand_int1 = rand.nextInt(9999 - 1001 + 1) + 1001;
        String username = Character.toString(firstname.charAt(0)).toLowerCase() + Character.toString(lastname.charAt(0)).toLowerCase() + Integer.toString(rand_int1);  
        while(true) {
        	try {
	        	PreparedStatement ps = conn.prepareStatement("Select count(1) as count from users where username = ?");
				ps.setString(1, username);
				ResultSet rs = ps.executeQuery();

				if(rs.next()) {
					String count = rs.getString("count");
					if(Integer.valueOf(count) == 0)
						break;
					}
        	}
			catch(Exception e) {
				System.out.print("Error in generating username");
				break;
				}
			
        	rand_int1 = rand.nextInt(9999 - 1001 + 1) + 1001;
            username = Character.toString(firstname.charAt(0)) + Character.toString(lastname.charAt(0)) + Integer.toString(rand_int1);  
            	
       }
		return username;
	}
}
 