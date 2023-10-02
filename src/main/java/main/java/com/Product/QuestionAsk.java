package main.java.com.Product;

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


public class QuestionAsk extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try { 
		PrintWriter out = resp.getWriter();
		
        Connection con = null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
        Statement stmt = con.createStatement();  
        
        String pid =  req.getParameter("pid");
        String question = req.getParameter("question");
        
       
        
        	
    	PreparedStatement ps= con.prepareStatement("insert into questions values(?,?,?,?)");
    	Random rand = new Random();
    	int rand_int1 = rand.nextInt(9999 - 1001 + 1) + 1001;

    	ps.setInt(1,rand_int1);

    	ps.setInt(2,Integer.parseInt(pid));

		ps.setString(3,question);

		ps.setString(4, "None");
		int x = ps.executeUpdate();
			
			if(x > 0){
				
				String msg="Question Added";
//				CustomLogger.log(msg);
				System.out.println("Reached");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('"+msg+"');");
				out.println("location='../portal/faq.jsp?id=" + pid + "';");
				out.println("</script>");
				
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
 