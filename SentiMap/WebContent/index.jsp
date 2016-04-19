<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>

</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tweet Map Home</title>
</head>
<body background="twitter1.jpg">
<center>
<h1><font color = #800000></font>Search for Tweets</font></h1>
<br>
<br>
<form method="post" action="<%=request.getContextPath() %>/TweetControl">
<input type= "text" name = "look" ></input>
<input type="submit" value="Search"></input>
<input type="hidden" name = "action" value="search">
</form>
</center>
</body>
</html>