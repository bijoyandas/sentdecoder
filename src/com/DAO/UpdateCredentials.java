package com.DAO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Model.User;


/**
 * Servlet implementation class UpdateCredentials
 */
@WebServlet("/UpdateCredentials")
public class UpdateCredentials extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection myCon = null;
	PreparedStatement mySmt = null;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setHeader("Cache-Control","no-cache");
		response.setHeader("Cache-Control","no-store");
		response.setHeader("Pragma","no-cache");
		response.setDateHeader ("Expires", 0);
		
		try {
			myCon = DatabaseConnection.getConnection();
			mySmt = myCon.prepareStatement("update Users set firstname=?,lastname=?,company=?,passwd=? where email=?");
			mySmt.setString(1, request.getParameter("firstname"));
			mySmt.setString(2, request.getParameter("lastname"));
			mySmt.setString(3, request.getParameter("company"));
			mySmt.setString(4, request.getParameter("password"));
			mySmt.setString(5, ((User)request.getSession().getAttribute("user")).getEmail());
			int status = mySmt.executeUpdate();
			if (status > 0) {
				User user = new User(request.getParameter("firstname"),request.getParameter("lastname"),((User)request.getSession().getAttribute("user")).getEmail(),request.getParameter("company"));
				request.getSession().setAttribute("user", user);
				response.sendRedirect("Settings.jsp?m=Succesfully updated information");
			}
			else 
				response.sendRedirect("Settings.jsp?m=Couldn't update information");
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
