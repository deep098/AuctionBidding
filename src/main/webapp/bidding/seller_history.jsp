<!DOCTYPE html>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>



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
    <link rel="stylesheet" href="bid_history.css" />
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
          <li><a href = "../portal/dashboard.jsp"><i class="fa fa-home"></i> Home</a></li>
          <li><a href = "product_add.jsp"><i class="fa fa-shopping-basket"></i> Add Product</a></li>
          <li><i class="fa fa-wallet"></i> Wallet</li>
          <li><i class="fa fa-shopping-cart"></i> Carted</li>
          <li><i class="fa fa-user"></i> Profile </li>
          
          <li><i class="fa fa-cog"></i> Settings</li>
          <li><a href = "../login.jsp"><i class="fa fa-sign-out-alt"></i> Sign Out</a></li>
        </ul>
      </div>
    </div>

    <label for="mobile-menu" id="mmenu">
      <i class="fa fa-bars"></i>
      <i class="fa fa-times"></i>
    </label>

    <div class="content">
		<br>
      <h1>Enter bid</h1> <br>
      <table class="styled-table">
	    <thead>
	        <tr>
	        	<th>Bid ID</th>
	            <th>Name</th>
	            <th>Bid Price</th>
	            <th>Bid Time</th>
	        </tr>
	    </thead>
	    <tbody>
	  <%

		try{ 
			String u_id = (String)request.getParameter("id");
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
			Statement st = connection.createStatement();

			ResultSet rs = st.executeQuery("select * from bids where id="+Integer.parseInt(u_id)+" order by bprice desc"); 
			int c = 0;
			PreparedStatement stmtt = connection.prepareStatement("select pname from products where id=?");  
	        stmtt.setInt(1, Integer.parseInt(u_id));
	        ResultSet rs3 = stmtt.executeQuery();
	        String p_name="";
	        if(rs3.next()) {
	        	p_name = rs3.getString(1);
	        }
	        
			while(rs.next()){
%>
	        <tr>
	        	<td><%=rs.getString("bid_id") %> </td>
	            <td><%=p_name%></td>
	            <td><%=rs.getString("bprice") %></td>
	            <td><%=rs.getString("bid_time") %></td>
	        </tr>
	        
	    
	  <%

			}
			    
		}
		catch(Exception e){
			System.out.print(e);
		}	
		%>
      </tbody>
	</table>
	</div>
		
        
      </div>
    </div>
  </body>
</html>