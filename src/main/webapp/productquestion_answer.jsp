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
        <ul>
        
         
          <li><a href = "login.jsp"><i class="fa fa-sign-out-alt"></i> Sign Out</a></li>
        </ul>
      </div>
    </div>

    <label for="mobile-menu" id="mmenu">
      <i class="fa fa-bars"></i>
      <i class="fa fa-times"></i>
    </label>
	<% String pid = (String)request.getParameter("id");
    		
	%>
    <div class="content">

       
		<br>
		<form class="productquestion_answer" method="post" action="productquestion_answer">
      <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
		<%
		try{ 
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbds", "root", "mysql");
			Statement st = connection.createStatement();
			ResultSet rs = null;
			
			rs = st.executeQuery("select qid,question,answer from questions where pid="+Integer.parseInt(pid));
			
			int c = 0;
			String qname = "Answer " + c;
			String qid = "Question " + c;
			while(rs.next()){
				
				
				String question = rs.getString("question");
				String answer = rs.getString("answer");
				%>
				Q. <%=question %> <br/>
				<input type="text" class="inp" id="name" name="<%=qname %>" placeholder="<%=answer %>"><br/>
				<input type="hidden" class="inp" id="<%=qid %>" name="<%=qid %>" value="<%=rs.getString("qid")%>"><br/>
				<%
				c++;
				qname = "Answer " + c;
				qid = "Question " + c;
			}
		}
		catch(Exception e){
			System.out.print(e);
		}
				
		%>
		<br/> 
		
      <input type="hidden" class="inp" name="pid" value="<%=pid%>">
      <button class="submit">Submit</button>
		</form>
	</div>
		

        
      </div>
    </div>
  </body>
</html>