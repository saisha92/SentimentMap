<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <script type="text/javascript" src="https://www.google.com/jsapi"></script>
 <%@page import="java.sql.*"%>
<%@page import="db.DBConnection"%>
<style>
body
{
background:  url('tbg.jpg') no-repeat center left;
}
</style>
   <script type="text/javascript">
   var pos=0,neg=0,neu=0;
   <% 
   String search = (String)request.getSession().getAttribute("search");
   Connection conn=DBConnection.createConnection();
   PreparedStatement ps = null;
   Statement st ;
   st = conn.createStatement();
   ResultSet rs = st.executeQuery("select * from twitter2 where text like "+"'%"+search+"%'");
   	while(rs.next())
   	{
   		System.out.print(rs.getString(1));
   		System.out.print(rs.getString(2));
   		System.out.print(rs.getString(3));
   		if(rs.getString(3).equalsIgnoreCase("positive"))
   		{
   			%>
   			pos = pos+1;
   			<%
   		}
   		if(rs.getString(3).equalsIgnoreCase("negative"))
   		{
   			%>
   			neg = neg+1;
   			<%
   		}
   		if(rs.getString(3).equalsIgnoreCase("neutral"))
   		{
   			%>
   			neu = neu+1;
   		<%
   	}
   	}
   %>
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Sentiment', 'Trend'],
          ['Negative',     neg],
          ['Positive',      pos],
          ['Neutral',  neu]
        ]);

        var options = {
          title: 'Sentiment Trend',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>
<title>Sentiment Trend</title>
</head>
<body>
<br><br><br>
<center>
    <div id="piechart_3d" style="width: 900px; height: 500px;"></div>
    </center>
</body>
</html>