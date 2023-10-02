package main.java.com.Product;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;  
import java.io.InputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Random;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;



@MultipartConfig(maxFileSize = 16177215) 
public class SetAlert extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try { 
		System.out.print("Gotcha");
		PrintWriter out = resp.getWriter();
		
        Connection con = null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
        Statement stmt = con.createStatement();  
        
        String name = req.getParameter("user_name");
        
        String ram = req.getParameter("ram");
        String storage = req.getParameter("storage");
        String color = req.getParameter("colour");
        String size = req.getParameter("size");
        String price = req.getParameter("price");
        
        							
    	PreparedStatement ps= con.prepareStatement("insert into alert_product values(?,?,?,?,?,?,?)");
    	Random rand = new Random();
    	int rand_int1 = rand.nextInt(9999 - 1001 + 1) + 1001;
		ps.setInt(1, rand_int1);
		ps.setString(2,name);
		
		ps.setString(3,ram);
		ps.setString(4,storage);
		ps.setString(5,color);
		ps.setString(6,size);
		ps.setInt(7,Integer.parseInt(price));
		
		int x = ps.executeUpdate();
		
		if(x > 0){
			String msg="Question Added";
//			CustomLogger.log(msg);
			System.out.println("Reached");
			out.println("<script type=\"text/javascript\">");
			out.println("alert('"+msg+"');");
			out.println("location='../portal/dashboard_seller.jsp';");
			out.println("</script>");
			
		}

        
        }
	catch(Exception e) {
		System.out.println(e);
	}
	}
	
	
}
