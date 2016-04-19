<!DOCTYPE html>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="db.DBConnection"%>
<html>
  <head>
    <meta charset="utf-8">
    <title>Heatmaps</title>
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
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=visualization"></script>
    <script>
// Adding 500 Data Points
var map, pointarray, heatmap;
var GeoData = []
<% 
Connection conn=DBConnection.createConnection();
PreparedStatement ps = null;
Statement st ;
st = conn.createStatement();
ResultSet rs = st.executeQuery("select * from twitter2");
	while(rs.next())
	{
		System.out.print(rs.getString(1));
		System.out.print(rs.getString(2));
		System.out.print(rs.getString(3));
%>
var lat = <%=rs.getString(1)%>;
var lon = <%=rs.getString(2)%>;

GeoData.push(new google.maps.LatLng(lat,lon))
<%}%>

function initialize() {
  var mapOptions = {
    zoom:2,
    center: new google.maps.LatLng(41.850033, -87.6500523),
    mapTypeId: google.maps.MapTypeId.SATELLITE
  };

  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  var pointArray = new google.maps.MVCArray(GeoData);

  heatmap = new google.maps.visualization.HeatmapLayer({
    data: pointArray
  });

  heatmap.setMap(map);
}

function toggleHeatmap() {
  heatmap.setMap(heatmap.getMap() ? null : map);
}

function changeGradient() {
  var gradient = [
    'rgba(0, 255, 255, 0)',
    'rgba(0, 255, 255, 1)',
    'rgba(0, 191, 255, 1)',
    'rgba(0, 127, 255, 1)',
    'rgba(0, 63, 255, 1)',
    'rgba(0, 0, 255, 1)',
    'rgba(0, 0, 223, 1)',
    'rgba(0, 0, 191, 1)',
    'rgba(0, 0, 159, 1)',
    'rgba(0, 0, 127, 1)',
    'rgba(63, 0, 91, 1)',
    'rgba(127, 0, 63, 1)',
    'rgba(191, 0, 31, 1)',
    'rgba(255, 0, 0, 1)'
  ]
  heatmap.set('gradient', heatmap.get('gradient') ? null : gradient);
}

function changeRadius() {
  heatmap.set('radius', heatmap.get('radius') ? null : 20);
}

function changeOpacity() {
  heatmap.set('opacity', heatmap.get('opacity') ? null : 0.2);
}

google.maps.event.addDomListener(window, 'load', initialize);

    </script>
       <script type="text/javascript">
	setInterval('window.location.reload()', 30000);
    </script>
  </head>

  <body>
    <div id="panel">
     <button onclick="toggleHeatmap()">Toggle Heatmap</button>
    <button onclick="changeGradient()">Change gradient</button>
      <button onclick="changeRadius()">Change radius</button>
      <button onclick="changeOpacity()">Change opacity</button>
	  
    </div>
    <div id="map-canvas"></div>
  </body>
</html>