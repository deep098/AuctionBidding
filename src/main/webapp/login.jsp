

<html>

<head>
  <link rel="stylesheet" href="login.css">
  <link href="https://fonts.googleapis.com/css?family=Ubuntu" rel="stylesheet">
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
  <title>Sign in</title>
</head>

<body>
  <div class="main">
    <p class="sign" align="center">Sign in</p>
    <form class="retrieve_sql" method="post" action="retrievesql">
      <input class="un " type="text" align="center" id="username" name="username" placeholder="Username">
      <input class="pass" type="password" align="center" id="password" name="password" placeholder="Password">
      <br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp; &nbsp; &nbsp; 
      <input type="radio" name="user_type" value="Buyer" required> Buyer &nbsp; &nbsp; &nbsp; &nbsp;
      <input type="radio" name="user_type" value="Seller" required> Seller
      <br/><br/><button class="submit">Sign in</button>     
      </form>
      <p class="forgot" align="center"><a href="signup.jsp">Create Account</p>
      <p class="forgot" align="center"><a href="customerrep_login.jsp">Customer Representative</p>
      <p class="forgot" align="center"><a href="admin_login.jsp">Admin</p>
            
                
    </div>
     
</body>

</html>