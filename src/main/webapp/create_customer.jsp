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
      <div class="top">
        <div class="search">
          <input type="text" placeholder="Search Product" />
          <i class="fa fa-search"></i>
        </div>
        
      </div>
		<br>
      <h1>Enter details</h1> <br>
	  <form class="customerrep_add" method="post" action="customerrep_add">
	  <table>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Username</td>
	  	<td style="padding-bottom: 15px;"><input type="text" class="inp" id="name" name="name" value="deep"></td>
	  </tr>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Password</td>
	  	<td style="padding-bottom: 15px;"><input type="password" class="inp" name="password"></td>
	  </tr>
	  
	  
	  </table>
	  <button class="submit">Submit</button>   
	  </form>  

      
	</div>

		
        
      </div>
    </div>
  </body>
</html>