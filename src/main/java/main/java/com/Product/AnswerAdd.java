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


public class AnswerAdd extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try { 
		PrintWriter out = resp.getWriter();
		
        Connection con = null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
        Statement stmt = con.createStatement();  
        
        String pid =  req.getParameter("pid");
        String question = req.getParameter("question");
        String answer = "";
        String qid = "";
        String sql = "";
        int x = 0;
        boolean aflag=false, qflag=false;
        Enumeration<String> params = req.getParameterNames();
        PreparedStatement p = null;
        while(params.hasMoreElements()){
        	 String paramName = params.nextElement();
        	 
        	 if(paramName.startsWith("Answer")) {
        		 aflag = true;
        		 answer = req.getParameter(paramName);
        	 }
        	 else if(paramName.startsWith("Question")) {
        		 qflag = true;
        		 qid = req.getParameter(paramName);
        	 }
        	 if(aflag && qflag) {
        		 sql = "update questions set answer='"+answer+"' where qid="+qid;
        		 p = con.prepareStatement(sql);
                 p.execute();
                 aflag = false;
                 qflag = false;
        		 }
        	 System.out.println("Parameter Name - "+paramName+", Value - "+req.getParameter(paramName));
        	}
        
        	
    	
			
				
				String msg="Answers Added";
//				CustomLogger.log(msg);
				System.out.println("Reached");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('"+msg+"');");
				out.println("location='customer_rep.jsp';");
				out.println("</script>");
				
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
 