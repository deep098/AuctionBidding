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
    <link rel="stylesheet" href="search.css" />
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
        	<%String uid = (String)request.getParameter("id2"); 
        	session.setAttribute("userId", uid );%>
          <li><a href = "dashboard.jsp?id2=<%=uid%>"><i class="fa fa-home"></i> Home</a></li>
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
      	<h1>Search</h1> <br>
	 <form action="search_results.jsp?id=<%=uid %>"  method="post">
	  <table>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">RAM</td>
	  	<td style="padding-bottom: 15px;"><select class="form-control" id="ram"
						name="ram" required>
						<option value="" selected>Select RAM</option>
						<option value="4">4</option>
						<option value="8">8</option>
						<option value="16">16</option>
						<option value="32">32</option>
					</select></td>
	  </tr>
	  <tr>
	  	<td style="width:150px; padding-bottom: 15px;">Storage</td>
	  	<td style="padding-bottom: 15px;"><select class="form-control" id="ram"
						name="storage" required>
						<option value="" selected>Select HDD</option>
						<option value="64">64</option>
						<option value="128">128</option>
						<option value="256">256</option>
						
					</select></td>
	  </tr>
	  <tr>
	  <td style="width:150px; padding-bottom: 15px;">Colour</td>
	  	<td style="padding-bottom: 15px;"><select class="form-control" id="ram"
						name="colour" required>
						<option value="" selected>Select Colour</option>
						<option value="Black">Black</option>
						<option value="White">White</option>
						<option value="Purple">Purple</option>
						<option value="Blue">Blue</option>
					</select></td>
					</tr>
		<tr>
		
	  	<td style="width:150px; padding-bottom: 15px;">Screen size</td>
	  	<td style="padding-bottom: 15px;"><input type="text" class="inp" name="size" id="size" placeholder="Size greater than" required></td>
	  </tr>
	  
	  </table>
	  
	  <button class="submit">Submit</button>   

		</form>

      

      

		
      </div>
    </div>
  </body>
</html>