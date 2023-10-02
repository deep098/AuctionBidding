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
    <link rel="stylesheet" href="alert.css" />
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
        <%String uid = (String)request.getParameter("id2"); %>
          <li><a href = "dashboard.jsp?id2=<%=uid%>"><i class="fa fa-home"></i> Home</a></li>
          
          <li><i class="fa fa-search"></i> Search</li>
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
      <div class="top">
        <div class="search">
          <input type="text" placeholder="Search Product" />
          <i class="fa fa-search"></i>
        </div>
        
      </div>
		<br>
      <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
		<%
		try{ 
			String u_id = (String)request.getParameter("id2");
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
			Statement st = connection.createStatement();

			ResultSet rss = st.executeQuery("select firstname from user_details where username= '"+u_id+"'");
	        
	        String firstname = "";
	        if(rss.next()) {
	        	firstname = rss.getString("firstname");
	        }
	        
	        ResultSet rs = st.executeQuery("select * from alerts where username='"+firstname+"'"); 
		%>		
			<table class="table" style="width:70%; margin-top:50px">
				<tbody>
				<% while(rs.next()){
				%>
					<tr>
						
						<td class="action"><i class="fa fa-star-o"></i></td>
						
						
						<td class="subject"><%=rs.getString("message") %></a></td>
						<td class="time"><%=rs.getString("bid_time") %></td>
					</tr>
				
				</tbody>
			</table>
		<%
		}}
		catch(Exception e){
			System.out.print(e);
		}
		%>
	<!-- END INBOX -->

      
	</div>
		
        <!-- <div class="products">
          <div class="product">
            <i class="fa fa-shopping-cart"></i>
            <img src="img/bag.webp" alt="" />
            <div class="addbutton">
              <button onclick="window.location.href = 'product.jsp';">VIEW</button>
            </div>
            <div class="subtitle">
              <div class="name">
                <h5>Laptop Bags</h5>
              </div>
              <div class="price"><h1>24.3 $</h1></div>
            </div>
          </div>

          <div class="product">
            <i class="fa fa-shopping-cart"></i>
            <img src="img/t-shirt.webp" alt="" />
            <div class="addbutton">
              <button class="addtocart">ADD TO CART</button>
            </div>
            <div class="subtitle">
              <div class="name">
                <h5>T-Shirt</h5>
              </div>
              <div class="price"><h1>34.3 $</h1></div>
            </div>
          </div>

          <div class="product">
            <i class="fa fa-shopping-cart"></i>
            <img src="img/shorts.webp" alt="" />
            <div class="addbutton">
              <button class="addtocart">ADD TO CART</button>
            </div>
            <div class="subtitle">
              <div class="name">
                <h5>Shorts</h5>
              </div>
              <div class="price"><h1>33.4 $</h1></div>
            </div>
          </div>
        </div>

        <div class="products">
          <div class="product">
            <i class="fa fa-shopping-cart"></i>
            <img src="img/nike.webp" alt="" />
            <div class="addbutton">
              <button class="addtocart">ADD TO CART</button>
            </div>
            <div class="subtitle">
              <div class="name">
                <h5>Nike Shoes</h5>
              </div>
              <div class="price"><h1>53.4 $</h1></div>
            </div>
          </div>

          <div class="product">
            <i class="fa fa-shopping-cart"></i>
            <img src="img/sweatshirt.webp" alt="" />
            <div class="addbutton">
              <button class="addtocart">ADD TO CART</button>
            </div>
            <div class="subtitle">
              <div class="name">
                <h5>SweatShirts</h5>
              </div>
              <div class="price"><h1>16.4 $</h1></div>
            </div>
          </div>

          <div class="product">
            <i class="fa fa-shopping-cart"></i>
            <img src="img/watch.webp" alt="" />
            <div class="addbutton">
              <button class="addtocart">ADD TO CART</button>
            </div>
            <div class="subtitle">
              <div class="name">
                <h5>Watches</h5>
              </div>
              <div class="price"><h1>84.4 $</h1></div>
            </div>
          </div> -->
        
      </div>
    </div>
  </body>
</html>