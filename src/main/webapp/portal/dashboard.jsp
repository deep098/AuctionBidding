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
          <li><a href = "dashboard.jsp?id2=<%=uid%>"><i class="fa fa-home"></i> Home</a></li>
          <li><a href = "search.jsp?id2=<%=uid%>"><i class="fa fa-search"></i> Search</li>
          <li><a href = "alert.jsp?id2=<%=uid%>"><i class="fa fa-shopping-basket"></i> Alerts</a></li>
          <li><a href = "set_alert.jsp?id2=<%=uid%>"><i class="fa fa-shopping-basket"></i> Set alerts</a></li>
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
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
			Statement st = connection.createStatement();
			ResultSet rs = st.executeQuery("select * from products"); 
			
			int c = 0;
			while(rs.next()){
				
				int secret_minprice = Integer.parseInt(rs.getString("min_price"));
				int bid_price = Integer.parseInt(rs.getString("bid_price"));
				String pname = rs.getString("pname");
				String pid = rs.getString("id");
				String time = rs.getString("lst_date");
				String u_id = rs.getString("user_id");
				if(c == 0){
					 %> <div class="products"> <%
				}
				else if(c % 3 == 0){	
					 %> </div>
					 <div class="products"> <%
				}
				System.out.println("Hello");

				LocalDateTime ldt = LocalDateTime.ofInstant(Instant.parse(time + ":00.0Z"), ZoneOffset.UTC);

				Timestamp first_date = Timestamp.valueOf(ldt);
				
				Instant nowInst = Instant.now();
				
				Timestamp now = Timestamp.from(nowInst);
				System.out.println(now);
				System.out.println(first_date);
				System.out.println("Hello");
				int value = first_date.compareTo(now);
				
				System.out.println(now);
				System.out.println(value);
				if(value <= 0){
					if(!u_id.equals("Unknown") && bid_price > secret_minprice)
							{
						PreparedStatement stmt = connection.prepareStatement("select firstname from user_details where username=?");  
				        stmt.setString(1, u_id);
				        ResultSet rss = stmt.executeQuery();
				        String alert_user_name="";
				        if(rss.next()) {
				        	alert_user_name = rss.getString(1);
				        }
				        
				        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
				        LocalDateTime noww = LocalDateTime.now();  
				        String sdate = dtf.format(noww);
				        String message = "Congratulations! You have won the bid for the product " + pname;
						PreparedStatement ps= connection.prepareStatement("insert into alerts values(?,?,?,?,?)");
						Random rand = new Random();
				    	int rand_int1 = rand.nextInt(9999 - 1001 + 1) + 1001;
						ps.setInt(1, rand_int1);
						ps.setInt(2, Integer.parseInt(pid));
						ps.setString(3, alert_user_name);
						ps.setString(4, message);
						ps.setString(5, sdate);
						ps.executeUpdate();
					} 
					PreparedStatement pstmt = connection.prepareStatement("select * from bids where id=?");  
					pstmt.setString(1, pid);
			        ResultSet rs2 = pstmt.executeQuery();
			        Statement stmt1 = connection.createStatement();
			        while(rs2.next()) {	
						String sql = "Delete from bids where id="+pid;
						stmt1.executeUpdate(sql);
			        }
			        String sql1 = "insert into sold_products select * from products where id="+pid;
			        PreparedStatement ps3= connection.prepareStatement(sql1);
			        ps3.executeUpdate();
					Statement stmmt = connection.createStatement();
					String sql = "Delete from products where id="+pid;
					System.out.println(sql);
					stmmt.executeUpdate(sql);
					
					continue;
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