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
    <link rel="stylesheet" href="bid_details.css" />
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
      <div class="top">
        <div class="search">
          <input type="text" placeholder="Search Product" />
          <i class="fa fa-search"></i>
        </div>
        
      </div>
		<br>
		<%String idd = (String)request.getParameter("id"); 
	  		String uid= (String)request.getParameter("id2"); 
	  		Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
			Statement st = connection.createStatement();
			
			ResultSet rs = st.executeQuery("select * from products where id="+idd); 
			rs.next();
			int price = rs.getInt("bid_price");%>
	  <h1>Current bid - <%=price %>$</h1> <br>
      <h2>Enter bid</h2> <br>
	  <form id="form1" class="productadd" method="post" action="bidding">
	  
	  <table>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Bid Amount</td>
	  	<td style="padding-bottom: 15px;"><input type="text" id="new_bid" class="inp" name="price"></td>
	  </tr>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Upper Limit</td>
	  	<td style="padding-bottom: 15px;"><input type="text" id="upper_lim" class="inp" name="u_price"></td>
	  </tr>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Bid Increment</td>
	  	<td style="padding-bottom: 15px;"><input type="text" class="inp" name="increment"></td>
	  </tr>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Bid Anonymously</td>
	  	<td style="padding-bottom: 15px;"><input type="checkbox" name="anon_flag"></td>
	  </tr>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Enable Autobid</td>
	  	<td style="padding-bottom: 15px;"><input type="checkbox" name="auto_flag"></td>
	  	<input type="hidden" id="curr_bid" value="<%=price%>">
	  	<input type="hidden" name="id" value="<%=idd%>">
	  	<input type="hidden" name="uid" value="<%=uid%>">
	  </tr>
	  </table>
	  	<button class="submit">Submit</button>   
	  </form>  
		
      <script>
      document.getElementById("new_bid").addEventListener("change", currBidFlag);

      function currBidFlag() {
    	  	var curr_bid = document.getElementById('curr_bid').value;
  	  		var new_bid = document.getElementById('new_bid').value;
        	if(new_bid < curr_bid)
        		alert("Bid should be greater than the current bid");
      }
      
      document.getElementById("upper_lim").addEventListener("change", upperLimFlag);

      function upperLimFlag() {
    	  	var upper_lim = document.getElementById('upper_lim').value;
  	  		var new_bid = document.getElementById('new_bid').value;
	  	  	if(parseInt(new_bid) > parseInt(upper_lim))
		  		alert("Upper limit should be greater than bid");
      }
      
      
      </script>
		</div>
       
      </div>
    </div>
  </body>
</html>