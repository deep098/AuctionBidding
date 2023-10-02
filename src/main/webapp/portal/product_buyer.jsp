<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="java.util.*"%>
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
    <link rel="stylesheet" href="product_buyer.css" />
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
          <li><a href = "dashboard.jsp"><i class="fa fa-home"></i> Home</a></li>
          <li><a href = "../product/product_added.jsp"><i class="fa fa-shopping-basket"></i> Add Product</a></li>
          <li><i class="fa fa-wallet"></i> Wallet</li>
          <li><i class="fa fa-shopping-cart"></i> Cart</li>
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

		  <%
		  
			try{ 
				String uid = (String)request.getParameter("id2");
				String id = (String)request.getParameter("id");
				
				Class.forName("com.mysql.jdbc.Driver");
				Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
				Statement st = connection.createStatement();
				ResultSet rs = st.executeQuery("select * from products where id= "+id);
				if(rs.next()){
					Blob image = rs.getBlob("photo");//getting image from database
			       
	                byte[] imgData = image.getBytes(1,(int)image.length()); //extra info about image
					String encodedImage = Base64.getEncoder().encodeToString(imgData);
	                String pic = "data:image/jpg;base64," + encodedImage;
		            %>
		            
			<div class="float-container">	
		  	<div class="float-child" style="width:40%; height:200px">
		    <div class="green"><img src="<%=pic%>"  height=250 width=200 alt="" /></div>
		    </div>

		  <div class="float-child" style="height:300px; margin-top:40px">
		  	<table>
			  <tr>
			    <td>Brand</td>
			    <td><%=rs.getString("brand")%></td>
			  </tr>
			  <tr>
			    <td>Model</td>
			    <td><%=rs.getString("pname")%></td>
			  </tr>
			  <tr>
			    <td>RAM</td>
			    <td><%=rs.getString("ram")%> GB</td>
			  </tr>
			  <tr>
			    <td>Storage</td>
			    <td><%=rs.getString("storage")%></td>
			  </tr>
			  <tr>
			    <td>Colour</td>
			    <td><%=rs.getString("color")%></td>
			  </tr>
			  
			   <tr>
			    <td>Size</td>
			    <td><%=rs.getString("size")%> inches</td>
			  </tr>
			  <tr>
			    <td>Listed Price</td>
			    <td><%=rs.getString("price")%>$</td>
			  </tr>
			</table>
			<br/>
			<a href="../bidding/bid_details.jsp?id=<%=rs.getString("id") %>&id2=<%=uid%>">
			
		    <button class="submit">Bid</button>
		    </a>  
		    <a href="../bidding/bid_history.jsp?id=<%=rs.getString("id") %>">
			
		    <button class="submit">Bid History</button>
		    </a>  
		    <br/><br/>
		    <a href="../bidding/seller_history.jsp?id=<%=rs.getString("id") %>">
			
		    <button class="submit">Seller History</button>
		    </a>  
		    <a href="faq.jsp?id=<%=rs.getString("id") %>&keyword=none">
			
		    <button class="submit">FAQ</button>
		    </a>  
		  </div>
		  
		</div>
		<%-- <div class="float-container">
		<div class="float-child" style="width:40%">
        <table>
		  <tr>
		    <td>Starting Price</td>
		    <td><%=rs.getString("price")%></td>
		
		  </tr>
		  <tr>
		    <td>Current  Price</td>
		    <td>700</td>
		   
		  </tr>
		  <tr>
		    <td>Start Time</td>
		    <td><%=rs.getString("st_date")%></td>
		  </tr>
		  <tr>
		    <td>End Time</td>
		    <td>26 April 13:03 GMT</td>
		  </tr>
		   
		  
		</table>
  		</div> --%>
  		<%
				}
  			}
			catch(Exception e){
				System.out.println(e);
				}
				%>
    	
		</div>

      
    </div>
  </body>
</html>