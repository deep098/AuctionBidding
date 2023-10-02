package main.java.com.Bidding;
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
public class BiddingAdd extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try { 

		PrintWriter out = resp.getWriter();
		String uname = req.getParameter("uid");

        Connection con = null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
        PreparedStatement stmt = con.prepareStatement("select firstname from user_details where username=?");  
        stmt.setString(1, uname);
        ResultSet rs = stmt.executeQuery();
        String user_name="";
        if(rs.next()) {
        	user_name = rs.getString(1);
        }
        int id = Integer.parseInt(req.getParameter("id"));
        PreparedStatement stmtt = con.prepareStatement("select seller_id from products where id=?");  
        stmtt.setInt(1, id);
        ResultSet rs3 = stmt.executeQuery();
        String seller_name="";
        if(rs3.next()) {
        	seller_name = rs3.getString(1);
        }
        
        
        int price = Integer.parseInt(req.getParameter("price"));
        int u_price = Integer.parseInt(req.getParameter("u_price"));
        String increment = req.getParameter("increment");
        boolean flag_anon = req.getParameter("anon_flag") != null;
        boolean flag_auto = req.getParameter("auto_flag") != null;

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
        LocalDateTime now = LocalDateTime.now();  
        String sdate = dtf.format(now);
        
        
    	PreparedStatement ps= con.prepareStatement("insert into bids values(?,?,?,?,?,?,?,?,?,?)");
    	Random rand = new Random();
    	int rand_int1 = rand.nextInt(9999 - 1001 + 1) + 1001;
    	ps.setInt(1, rand_int1);
    	ps.setInt(2, id);
    	ps.setString(3, user_name);
		ps.setInt(4, price);
		ps.setInt(5,u_price);
		ps.setString(6,increment);
		ps.setBoolean(7,flag_auto);
		ps.setBoolean(8,flag_anon);
		ps.setString(9,sdate);
		ps.setString(10,seller_name);
		int x = ps.executeUpdate();
		String username = set_price(uname, id);
		send_alert(username, id);
		String redirect = "location='../portal/dashboard.jsp?id="+uname+"';";
		if(x > 0){
			String msg="Bid Added";

			out.println("<script type=\"text/javascript\">");
			out.println("alert('"+msg+"');");
			out.println(redirect);
			out.println("</script>");
			
		}

        
        }
	catch(Exception e) {
		System.out.println(e);
		}
	}
	
	public String set_price(String uname, int pid) {
		String user_n = "";
		try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
        Statement st = con.createStatement();
        
        ResultSet rs = st.executeQuery("select * from bids where auto_bid = 1 and id = "+pid+" order by uprice desc limit 2"); 

		int price = 0;
		rs.next();
		int id = rs.getInt("id");
		user_n = rs.getString("username");
		int first_price = rs.getInt("bprice");
		int first_inc = rs.getInt("increment");
		int second_price = 0;
		if(rs.next())
			second_price = rs.getInt("uprice");
		
		while(first_price <= second_price) 
			first_price += first_inc;
		rs = st.executeQuery("select * from bids where auto_bid = 0 and id = "+pid+" order by uprice desc"); 
		price = first_price;
		if(rs.next()) {
			if(price < rs.getInt("bprice"))
				price = rs.getInt("bprice");
		}

		st.executeUpdate("update products set bid_price="+first_price+",user_id='"+uname+"' where id="+id);
//		st.executeUpdate("update products set user_id="+uname+" where id="+id);
		}
		catch(Exception e){
			System.out.print(e);
		}
		return user_n;

	}
	public void send_alert(String user_name, int pid) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
	        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
	        Statement st = con.createStatement();

			ResultSet rs = st.executeQuery("select * from bids where id="+pid+" and username != '"+user_name+"'");
			
			PreparedStatement  stmt = con.prepareStatement("select pname from products where id=?");  
	        stmt.setInt(1, pid);
	        ResultSet rss = stmt.executeQuery();
	        
	        String product_name = "";
	        if(rss.next()) {
	        	product_name = rss.getString(1);
	        }
	        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
	        LocalDateTime now = LocalDateTime.now();  
	        String sdate = dtf.format(now);
			while(rs.next()) {
				String cur_name = rs.getString("username");
				PreparedStatement ps= con.prepareStatement("insert into alerts values(?,?,?,?,?)");
				String message = "A higher bid has been placed for the product " + product_name;
		    	Random rand = new Random();
		    	int rand_int1 = rand.nextInt(9999 - 1001 + 1) + 1001;
				ps.setInt(1, rand_int1);
				ps.setInt(2,pid);
				ps.setString(3,cur_name);
				ps.setString(4, message);
				ps.setString(5, sdate);
				ps.executeUpdate();
			
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
	
	
}

