

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.DBConnection;

import java.sql.*;

/**
 * Servlet implementation class TweetControl
 */
public class TweetControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TweetControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");
		String searchtext = request.getParameter("word");
		HttpSession session = request.getSession();
		session.setAttribute("search", searchtext);
		System.out.println(action);
	if(action.equalsIgnoreCase("search"))
	{
		String resp = request.getParameter("option");
		if(resp.equalsIgnoreCase("      Sentiment Trend      "))
		{
			
			response.sendRedirect(request.getContextPath()+"/PieChart.jsp");
		}
		if(resp.equalsIgnoreCase("      Sentiment Map        "))
		{
			response.sendRedirect(request.getContextPath()+"/marker.jsp");	
		}
		if(resp.equalsIgnoreCase("Positive Sentiment Heat Map"))
		{
			response.sendRedirect(request.getContextPath()+"/TestHeat.jsp");	
		}
		if(resp.equalsIgnoreCase("Negative Sentiment Heat Map"))
		{
			response.sendRedirect(request.getContextPath()+"/TestHeat1.jsp");	
		}
	
	
	}
	
	}

}
