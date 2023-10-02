<!DOCTYPE html>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>



<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Ecommerce Dashboard</title>
    <!-- Font Awesome -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
    />
    <!-- CSS -->
    <link rel="stylesheet" href="customer_rep.css" />
  </head>
  <body>
    <input type="checkbox" id="mobile-menu" />

    <div class="sidebar">
      <div class="logo">
        <i class="fa fa-shopping-bag"></i>
        <h2>Bidding</h2>
      </div>
      <div class="menu">
        <ul>
          
          
          <li><a href = "login.jsp"><i class="fa fa-sign-out-alt"></i> Sign Out</a></li>
        </ul>
      </div>
    </div>

    <label for="mobile-menu" id="mmenu">
      <i class="fa fa-bars"></i>
      <i class="fa fa-times"></i>
    </label>

    <div class="content">
		<br>
      <%

		try{ 
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
			Statement st = connection.createStatement();
			ResultSet rs = st.executeQuery("select sum(bid_price) from sold_products;"); 
			int sum_price = 0;
			if(rs.next())
				sum_price = rs.getInt(1);
			%>
			Total earnings: <%= sum_price%>$ <br/> <br/>
			Earnings per item
			<table class="styled-table">
	    <thead>
	        <tr>

	        	
	            <th>Name</th>

	            <th>User ID</th>
	            <th>Earnings</th>
	        </tr>
	    </thead>
	    <tbody>
	  <%

	  		Statement st1 = connection.createStatement();
			ResultSet rs1 = st1.executeQuery("select * from sold_products;"); 
			int c = 0;
			while(rs1.next()){
	  		if(rs1.getString("user_id").equals("Unknown"))
	  			continue;
%>
	        <tr>
	        	
	        	<td><%=rs1.getString("pname") %> </td>
	            
	            <td><%=rs1.getString("user_id") %></td>
	            <td><%=rs1.getString("bid_price") %></td>

	        </tr>
</tbody>
	</table><%} %>
			<br/>
			Earnings per brand
			<table class="styled-table">
	    <thead>
	        <tr>

	        	
	            <th>Name</th>

	            <th>Price</th>

	        </tr>
	    </thead>
	    <tbody>
	  <%
			
	  		Statement st2 = connection.createStatement();
			ResultSet rs2 = st2.executeQuery("select brand,sum(bid_price) as sum from sold_products GROUP BY brand"); 

			while(rs2.next()){
	  		
%>
	        <tr>
	        	
	        	<td><%=rs2.getString("brand") %> </td>
	            <td><%=rs2.getInt("sum") %> </td>
	  
	            

	        </tr>
	        <%} %>
</tbody>
	</table>

<br/>
			Earnings per user
			<table class="styled-table">
	    <thead>
	        <tr>

	        	
	            <th>Name</th>

	            <th>Price</th>

	        </tr>
	    </thead>
	    <tbody>
	  <%
			
	  		Statement st4 = connection.createStatement();
			ResultSet rs4 = st2.executeQuery("select seller_id,sum(bid_price) as price from sold_products GROUP BY seller_id"); 

			while(rs4.next()){
	  		
%>
	        <tr>
	        	
	        	<td><%=rs4.getString("seller_id") %> </td>
	            <td><%=rs4.getInt("price") %> </td>
	  
	            

	        </tr>
	        <%} %>
</tbody>
	</table>
	
	<br/>
			Best selling items
			<table class="styled-table">
	    <thead>
	        <tr>

	        	
	            <th>Name</th>

	            <th>Price</th>

	        </tr>
	    </thead>
	    <tbody>
	  <%
			
	  		Statement st5 = connection.createStatement();
			ResultSet rs5 = st2.executeQuery("select pname, price from sold_products order by price;"); 

			while(rs5.next()){
	  		
%>
	        <tr>
	        	
	        	<td><%=rs5.getString("pname") %> </td>
	            <td><%=rs5.getInt("price") %> </td>
	  
	            

	        </tr>
	        <%} %>
</tbody>
	</table>
	
	<br/>
			Best buyers
			<table class="styled-table">
	    <thead>
	        <tr>

	        	
	            <th>Name</th>

	            <th>Price</th>

	        </tr>
	    </thead>
	    <tbody>
	  <%
			
	  		Statement st6 = connection.createStatement();
			ResultSet rs6 = st2.executeQuery("select user_id, price from products order by price;"); 

			while(rs6.next()){
				if(rs6.getString("user_id").equals("Unknown"))
		  			continue;
%>
	        <tr>
	        	
	        	<td><%=rs6.getString("user_id") %> </td>
	            <td><%=rs6.getInt("price") %> </td>
	  
	            

	        </tr>
	        <%} %>
</tbody>
	</table>
			<%
		
		}
      catch(Exception e){
      	System.out.println(e);}
      %>
      
    
	</div>
		
        
      </div>
    </div>
  </body>
</html>