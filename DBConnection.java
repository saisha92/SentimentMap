import java.io.*;
import java.sql.*;
public class DBConnection {
	public static Connection createConnection() throws Exception
	{System.out.println("Conn.........");
	Connection conn=null;
	DriverManager.registerDriver(new com.mysql.jdbc.Driver());
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://twitterheatmap.cjkuojdbhc2z.us-east-1.rds.amazonaws.com:3306/twitter";
	String uname="";
	String pwd="";
	conn=DriverManager.getConnection(url,uname,pwd);
	return conn;
	}
	public static void closeConnection(Connection con)
	{
	if(con!=null)
	{
	try{
	con.close();
	}
	catch(SQLException e){
	e.printStackTrace();
	}
	}
	}
	

		


}

