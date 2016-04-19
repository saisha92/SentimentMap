<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    
    <script>
// Adding 500 Data Points
var map, pointarray, heatmap,pointArray;
var GeoData = []
$(document).ready(function(){
	  (function poll() {
	   setTimeout(function() {
	     $.ajax({ type: "GET",url:'<%=request.getContextPath() %>/validate1.jsp?data=val' , success: function(data) {
	    	 //console.log(JSON.parse(JSON.stringify(data))[0]);
	    	 
	    	 //var something = jQuery.parseJSON(data);
	    	  
	    	 for (var x = 0; x < data.length; x++) {
	    		
	    		 var points = data[x].split(","); 
	    		 console.log(points[0]);
	    		 console.log(points[1]);
	    		 //GeoData.push(new google.maps.LatLng(points[0],points[1]));
	    		 pointArray.push(new google.maps.LatLng(points[0],points[1]));
	    		// pointArray.push(points[0],points[1]);
	    		 
	            }
	    	  

	    	 
	    	 
	    	 
	    }, dataType: "json", complete: poll });
	   }, 1000);
	 })();
	});

function initialize() {
  var mapOptions = {
    zoom:4,
    center: new google.maps.LatLng(41.850033, -87.6500523),
    mapTypeId: google.maps.MapTypeId.SATELLITE
  };

  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

   pointArray = new google.maps.MVCArray(GeoData);

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