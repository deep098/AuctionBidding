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
    <link rel="stylesheet" href="product_added.css" />
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
      <div class="top">
        <div class="search">
          <input type="text" placeholder="Search Product" />
          <i class="fa fa-search"></i>
        </div>
        
      </div>
		<br>
		<%String uid = (String)request.getParameter("id2"); %>
      <h1>Enter details</h1> <br>
	  <form class="productadd" method="post" action="productadded" enctype="multipart/form-data">
	  <table>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Name</td>
	  	<td style="padding-bottom: 15px;"><input type="text" class="inp" name="name"></td>
	  </tr>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Price</td>
	  	<td style="padding-bottom: 15px;"><input type="text" class="inp" name="price"></td>
	  </tr>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Brand</td>
	  	<td style="padding-bottom: 15px;"><input type="text" class="inp" name="brand"></td>
	  </tr>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">RAM</td>
	  	<td style="padding-bottom: 15px;"><input type="text" class="inp" name="ram"></td>
	  </tr>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Storage</td>
	  	<td style="padding-bottom: 15px;"><input type="text" class="inp" name="storage"></td>
	  </tr>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Color</td>
	  	<td style="padding-bottom: 15px;"><input type="text" class="inp" name="color"></td>
	  </tr>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Minimum price</td>
	  	<td style="padding-bottom: 15px;"><input type="text" class="inp" name="min_price"></td>
	  </tr>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Screen size</td>
	  	<td style="padding-bottom: 15px;"><input type="text" class="inp" name="size"></td>
	  </tr>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Last date</td>
	  	<td style="padding-bottom: 15px;"><input type="datetime-local" class="inp" name="ldate"></td>
	  </tr>
	  <tr>	
	  	<td style="width:150px; padding-bottom: 15px;">Enter image</td>
	  	<td style="padding-bottom: 15px;"><input type="file" name="photo" size="50"/></td>
	  </tr>
	  
	  </table>
	  <input type="hidden" class="inp" name="seller_name" value="<%=uid%>">
	  <button class="submit">Submit</button>   
	  </form>  

      
	</div>

        
      </div>
    </div>
  </body>
</html>