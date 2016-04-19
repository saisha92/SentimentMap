<%@ page language="java" contentType="application/json; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%> 
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="db.DBConnection"%>
<%@page import="com.google.gson.*"%>
<%

try{
	
	ArrayList<String> points = new ArrayList();
	String search = (String)request.getSession().getAttribute("search");
	PrintWriter outPrintWriter = response.getWriter();
	Connection conn=DBConnection.createConnection();
	PreparedStatement ps = null;
	Statement st ;
	st = conn.createStatement();
	ResultSet rs = st.executeQuery("select * from twitter2 where sentiment like '%negative%' and text like "+"'%"+search+"%'");
	Gson obj = new Gson();
		while(rs.next())
		{
			points.add(rs.getString(1)+","+rs.getString(2));
			 
		}
		DBConnection.closeConnection(conn);
		String json = obj.toJson(points);
		System.out.println(json);
		//response.setContentType("application/json");  
		  //response.setCharacterEncoding("UTF-8"); 
		  //response.getWriter().write(json);
		//outPrintWriter.write("hello");
		
		outPrintWriter.write(json);
		
}
catch(Exception e){}

%>
