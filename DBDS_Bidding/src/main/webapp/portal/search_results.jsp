<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="java.util.*"%>
<%@page import="java.time.*"%>
<%@page import="java.time.format.*"%>
<%@page import="java.text.*"%>
<%-- <%@page import="org.apache.commons.fileupload.*"%> --%>
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
    <link rel="stylesheet" href="style.css" />
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
        	<%String uid = (String)request.getParameter("id"); %>
          <li><a href = "dashboard.jsp"><i class="fa fa-home"></i> Home</a></li>
          <li><a href = "search.jsp?id2=<%=uid%>"><i class="fa fa-search"></i> Search</li>
          <li><a href = "alert.jsp?id2=<%=uid%>"><i class="fa fa-shopping-basket"></i> Alerts</a></li>
          
          
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
      

      

      <div class="all-products">
        <div class="title">
          <h2>All Products</h2>
        </div>
        
        
		
		<%

		try{ 
			float size = Float.parseFloat(request.getParameter("size"));
			int ram = Integer.parseInt(request.getParameter("ram"));
			int storage = Integer.parseInt(request.getParameter("storage"));
			String colour = request.getParameter("colour");
			System.out.print(size + " " + ram + " " + storage + " " + colour);
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
			Statement st = connection.createStatement();
			ResultSet rs = st.executeQuery("select * from products"); 
			
			int c = 0;
			System.out.println("Pass");
			while(rs.next()){
				boolean flag = false;
				float curr_size = Float.parseFloat(rs.getString("size"));
				int curr_ram = Integer.parseInt(rs.getString("ram"));
				int curr_storage = Integer.parseInt(rs.getString("storage"));
				String curr_colour = rs.getString("color"); 
				
				if(curr_size >= size)
					flag = true;
				else if(curr_ram == ram)
					flag =  true;
				else if(curr_storage == storage)
					flag =  true;
				else if(curr_colour.equals(colour))
					flag =  true;
				
				if(!flag)
					continue;
				if(c == 0){
					 %> <div class="products"> <%
				}
				else if(c % 3 == 0){	
					 %> </div>
					 <div class="products"> <%
				}
			
				%>
				<div class="product">
	            <i class="fa fa-shopping-cart"></i>
	            <%
	            
	            Blob image = rs.getBlob("photo");//getting image from database
		        String id = rs.getString("id");
                byte[] imgData = image.getBytes(1,(int)image.length()); //extra info about image
				String encodedImage = Base64.getEncoder().encodeToString(imgData);
                String pic = "data:image/jpg;base64," + encodedImage;
	            %>
	            <img src="<%=pic%>" width="130px" height="90px">
	            <a href="product_buyer.jsp?id=<%=rs.getString("id") %>&id2=<%=uid%>">
				<div class="addbutton">
	              <button name="view" value=<%=id %>>VIEW</button>
	            </div>
	            </a>
	            <div class="subtitle">
	            <% session.setAttribute("id",rs.getString("id")); %>
	              <div class="name">
	                <h5><%=rs.getString("pname") %></h5>
	              </div>
	              <div class="price"><h1><%=rs.getString("bid_price") %> $</h1></div>
	            </div>
	          </div>
	         
	          <%
	          c++;
			}
			    
		}
		catch(Exception e){
			System.out.print(e);
		}	
		%>
		</div>
		
        
      </div>
    </div>
  </body>
</html>