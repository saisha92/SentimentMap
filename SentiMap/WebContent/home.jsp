<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tweet Buzz</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="jquery.onepage-scroll.js"></script>
  <link href='onepage-scroll.css' rel='stylesheet' type='text/css'>
</head>
<script>
  $(document).ready(function(){
  	$(".main").onepage_scroll({
   sectionContainer: "section",     // sectionContainer accepts any kind of selector in case you don't want to use section
   easing: "ease",                  // Easing options accepts the CSS3 easing animation such "ease", "linear", "ease-in",
                                    // "ease-out", "ease-in-out", or even cubic bezier value such as "cubic-bezier(0.175, 0.885, 0.420, 1.310)"
   animationTime: 1000,             // AnimationTime let you define how long each section takes to animate
   pagination: true,                // You can either show or hide the pagination. Toggle true for show, false for hide.
   updateURL: false,                // Toggle this true if you want the URL to be updated automatically when the user scroll to each page.
   beforeMove: function(index) {},  // This option accepts a callback function. The function will be called before the page moves.
   afterMove: function(index) {},   // This option accepts a callback function. The function will be called after the page moves.
   loop: false,                     // You can have the page loop back to the top/bottom when the user navigates at up/down on the first/last page.
   keyboard: true,                  // You can activate the keyboard controls
   responsiveFallback: false,        // You can fallback to normal page scroll by defining the width of the browser in which
                                    // you want the responsive fallback to be triggered. For example, set this to 600 and whenever
                                    // the browser's width is less than 600, the fallback will kick in.
   direction: "vertical"            // You can now define the direction of the One Page Scroll animation. Options available are "vertical" and "horizontal". The default value is "vertical".  
});

  			});
</script>
<style>
.first {
background:  url('twit.png') no-repeat center left;
 background-size: 100% 100%;
width: 100%;
height: 100%;
height: auto !important;
min-height:100%;
}
.second {
background:  url('nyc.jpg') no-repeat center left;
 background-size: 100% 100%;
width: 100%;
height: 100%;
height: auto !important;
min-height:100%;
}
</style>
<body>
<div class="main">
<section class="first">
<center>
<h1>Twitt-Senti</h1><br><br>
<h4>Scroll down to see what is the response from the people all around the world.</h4>
</center>
</section>
<section class="second">
<center>
<h2><font color="white">What are people thinking about it?</font></h2>
</center>
<br><br><br><br>
<br><br>
<br><br>
<br><br>
<br>

<center>

<form method="post" action="<%=request.getContextPath()%>/TweetControl" >
<input type= "text" name = "word"  ></input><br><br>
<input type="submit" name = "option" value="      Sentiment Map        " class="btn btn-primary "></input><br><br>
<input type="hidden" name = "action" value="search" >
<input type="submit" name ="option" value="Positive Sentiment Heat Map" class="btn btn-success"></input><br><br>
<input type="submit" name ="option" value="Negative Sentiment Heat Map" class="btn btn-danger"></input><br><br>
<input type="submit" name="option" value="      Sentiment Trend      " class="btn btn-warning"></input>
</form>
</center>
</section>
</div>
</body>
</html>