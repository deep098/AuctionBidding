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
	<% String pid = (String)request.getParameter("id");
    		String keyword = (String)request.getParameter("keyword");
    		boolean key_flag = false;
    		System.out.println(keyword);
    		if(keyword == null || keyword.equals("none"))
    			key_flag = true;
    		String url = "faq.jsp?id="+pid+"&keyword="+keyword;
	%>
    <div class="content">
      <div class="top">
        <div class="search">
        
        	
          <input type="text" placeholder="Search Question" name="question" id="question">
          <a href="javascript:url(<%=pid%>);">
          <i class="fa fa-search"></i>
          </a>
		
        </div>
        <script>
		function url(pid){
			var keyword = document.getElementById("question").value;
			window.location = "faq.jsp?id="+pid+"&keyword="+keyword;
		}
	</script>
      </div>
		<br>
      <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
		<%
		try{ 
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
			Statement st = connection.createStatement();
			ResultSet rs = null;
			if(key_flag)
				rs = st.executeQuery("select question,answer from questions where pid="+Integer.parseInt(pid));
			else
				rs = st.executeQuery("select question,answer from questions where pid="+Integer.parseInt(pid)+" and question like '%"+keyword+"%'");
			
			int c = 0;
			while(rs.next()){
				
				
				String question = rs.getString("question");
				String answer = rs.getString("answer");
				%>
				Q. <%=question %> <br/>
				A. <%=answer %> <br/> 
				<%
			}
		}
		catch(Exception e){
			System.out.print(e);
		}
				
		%>
		<br/> 
		<form class="questionadd" method="post" action="questionadd">
      <input type="hidden" class="inp" name="pid" value="<%=request.getParameter("id")%>">
      <input type="text" class="inp" id="name" name="question" placeholder="Ask a question"> <button class="submit">Submit</button>
		</form>
	</div>
		

        
      </div>
    </div>
  </body>
</html>