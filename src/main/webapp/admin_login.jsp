

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
  <p class="sign" align="center">Administrator
  <br/><br/>
    Sign in</p>  <form action="admin.jsp" name="form1">
      <input class="un " type="text" align="center" id="username" name="username" placeholder="Username">
      <input class="pass" type="password" align="center" id="password" name="password" placeholder="Password">
      <br/>
      
      <button class="submit">Sign in</button>     
      </form>
            
                
    </div>
     <script>
     var username = document.getElementById('username').value;
     var pass = document.getElementById('password').value;
     if(username == "admin" && pass == "admin"){
    	 document.getelementbyid("form1").submit()
     }
    	
     </script>
</body>

</html>