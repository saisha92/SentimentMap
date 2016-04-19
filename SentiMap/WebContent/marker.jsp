<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="db.DBConnection"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Marker Map</title>
 <style>
      html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      }
      #panel {
        position: absolute;
        top: 5px;
        left: 50%;
        margin-left: -180px;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
      }
    </style>
    
      <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
    <script>
   
    function initialize() {
    	  // Create the map.
    	  var mapOptions = {
    	    zoom: 4,
    	    center: new google.maps.LatLng(37.09024, -95.712891),
    	  mapTypeId: google.maps.MapTypeId.TERRAIN

    	  };

    	  var map = new google.maps.Map(document.getElementById('map-canvas'),
    	      mapOptions);

    <%
    String search = (String)request.getSession().getAttribute("search");
    System.out.println(search);
    Connection conn=DBConnection.createConnection();
    PreparedStatement ps = null;
    Statement st ;
    st = conn.createStatement();
    ResultSet rs = st.executeQuery("select * from twitter2 where text like "+"'%"+search+"%'");
    	while(rs.next())
    	{
    		System.out.println(rs.getString(1));
    		System.out.println(rs.getString(2));
    		System.out.println(rs.getString(3));
    %>
    var lat = <%=rs.getString("latitude")%>+","+<%=rs.getString("longitude")%>+","+"<%=rs.getString("sentiment")%>";
     var x = lat.split(",");
     
	if(x[2]=="positive")
{
    var myLatlng = new google.maps.LatLng(x[0],x[1]);
    var marker = new google.maps.Circle({
  	  strokeColor: '#006400',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: '#006400',
        fillOpacity: 0.35,
        map: map,
        center: myLatlng,
        radius:88888

    });
}
	 if(x[2]=="negative")
		{
		var myLatlng = new google.maps.LatLng(x[0],x[1]);
	    var marker = new google.maps.Circle({
	  	  strokeColor: '#FF0000',
	        strokeOpacity: 0.8,
	        strokeWeight: 2,
	        fillColor: '#FF0000',
	        fillOpacity: 0.35,
	        map: map,
	        center: myLatlng,
	        radius:88888
	    });
		}
	
	else if(x[2]=="neutral")
	{
	var myLatlng = new google.maps.LatLng(x[0],x[1]);
    var marker = new google.maps.Circle({
  	  strokeColor: '#FF33CC',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: '#FF33CC',
        fillOpacity: 0.35,
        map: map,
        center: myLatlng,
        radius:88888
    });
	}
	
    <%}
    DBConnection.closeConnection(conn);  %>
    }
google.maps.event.addDomListener(window, 'load', initialize);

    </script>
</head>
<body>
    <div id="map-canvas"></div>
</body>
</html>