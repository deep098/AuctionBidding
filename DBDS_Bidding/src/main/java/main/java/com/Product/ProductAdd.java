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
public class ProductAdd extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try { 
		System.out.print("Gotcha");
		PrintWriter out = resp.getWriter();
		
        Connection con = null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
        Statement stmt = con.createStatement();  
        
        String name = req.getParameter("name");
        
        String brand = req.getParameter("brand");
        brand = brand.substring(0, 1).toUpperCase() + brand.substring(1);
        
        String ram = req.getParameter("ram");
        String storage = req.getParameter("storage");
        String color = req.getParameter("color");
        color = color.substring(0, 1).toUpperCase() + color.substring(1);
        String size = req.getParameter("size");
        String price = req.getParameter("price");
        String lastdate = req.getParameter("ldate");
        String min_price = req.getParameter("min_price");
        String seller_name = req.getParameter("seller_name");
        System.out.print(lastdate);
        Date date = new Date();
		/* java.sql.Date sqlDate = new java.sql.Date(date.getTime()); */
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
        LocalDateTime now = LocalDateTime.now();  
        String sdate = dtf.format(now);
        InputStream in = null;
        Part filePart = req.getPart("photo");
       
        in = filePart.getInputStream();     
        							
    	PreparedStatement ps= con.prepareStatement("insert into products values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
    	Random rand = new Random();
    	int rand_int1 = rand.nextInt(9999 - 1001 + 1) + 1001;
		ps.setInt(1, rand_int1);
		ps.setString(2,name);
		ps.setString(3,brand);
		ps.setString(4,ram);
		ps.setString(5,storage);
		ps.setString(6,color);
		ps.setString(7,size);
		ps.setString(8,price);
		ps.setBlob(9,in);
		ps.setString(10, sdate);
		/* ps.setTimestamp(10, new java.sql.Timestamp(System.currentTimeMillis())); */
		ps.setString(11, lastdate);
		ps.setString(12, min_price);
		ps.setInt(13, Integer.parseInt(price));
		ps.setString(14, "Unknown");
		ps.setString(15, sdate);
		ps.setString(16, seller_name);
//		PreparedStatement ps1 = con.prepareStatement("insert into users(username,password) values(?,?)");
//		
//		ps1.setString(1,username);
//		ps1.setString(2,password);
//		ps1.executeUpdate();

		int x = ps.executeUpdate();
		execute_alert(ram, storage, color, size, price, rand_int1);
		if(x > 0){
			String msg="Product Added";
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
	void execute_alert(String ram, String storage, String color, String size, String price, int id) {
		try {
			Connection con = null;
	        Class.forName("com.mysql.jdbc.Driver");
	        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
	        Statement stmt = con.createStatement();  
	        ResultSet rs = stmt.executeQuery("select * from alert_product"); 
	        boolean flag = false;
	        while(rs.next()) {
	        	flag = false;
	        	int curr_ram = Integer.parseInt(rs.getString("ram"));
	        	int curr_hdd = Integer.parseInt(rs.getString("hdd"));
	        	String curr_userid = rs.getString("user_id");
	        	String curr_colour = rs.getString("colour");
	        	String curr_size = rs.getString("int");
	        	int curr_price = rs.getInt("price");
	        	if(curr_ram == Integer.parseInt(ram))
	        		flag = true;
	        	else if(curr_hdd == Integer.parseInt(storage))
	        		flag = true;
	        	else if(curr_colour.equals(color))
	        		flag = true;
	        	else if(curr_size.equals(size))
	        		flag = true;
	        	else if(curr_price == Integer.parseInt(price))
	        		flag = true;
	        	
	        
	        if(flag) {
	        	PreparedStatement stmt1 = con.prepareStatement("select firstname from user_details where username=?");  
	            stmt1.setString(1, curr_userid);
	            ResultSet rs1 = stmt1.executeQuery();
	            String user_name="";
	            if(rs1.next()) {
	            	user_name = rs1.getString(1);
	            }
	            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
	            LocalDateTime now = LocalDateTime.now();  
	            String sdate = dtf.format(now);
	            
	        	PreparedStatement ps= con.prepareStatement("insert into alerts values(?,?,?,?,?)");
	        	Random rand = new Random();
	        	int rand_int1 = rand.nextInt(9999 - 1001 + 1) + 1001;
	    		ps.setInt(1, rand_int1);
	    		ps.setInt(2, id);
	    		ps.setString(3, user_name);
	    		ps.setString(4, "A new product related to your specifications have been added");
	    		ps.setString(5, sdate);
	        }
	        }
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
	
}
