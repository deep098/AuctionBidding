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
        
      </div>
    </div>

    <label for="mobile-menu" id="mmenu">
      <i class="fa fa-bars"></i>
      <i class="fa fa-times"></i>
    </label>

    <div class="content">
		<br>
      <h1>Delete users</h1> <br>
      <form action="deleteuser" method="post">
      <table class="styled-table">
	    <thead>
	        <tr>
	        	<th></th>
	        	<th>First Name</th>
	            <th>Last Name</th>
	            <th>Email</th>
	            <th>Phone Number</th>
	        </tr>
	    </thead>
	    <tbody>
	  <%

		try{ 
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
			Statement st = connection.createStatement();

			ResultSet rs = st.executeQuery("select * from user_details"); 
			int c = 0;
			while(rs.next()){
	  		
%>
	        <tr>
	        	<td style="padding-bottom: 15px;"><input type="checkbox" name="delete_flag" value=<%=rs.getString("username") %>></td>
	        	<td><%=rs.getString("firstname") %> </td>
	            <td><%=rs.getString("lastname") %> </td>
	            <td><%=rs.getString("email") %></td>
	            <td><%=rs.getString("phoneno") %></td>
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
	<button class="submit">Submit</button>  
	</form>
	</div>
		
        
      </div>
    </div>
  </body>
</html>