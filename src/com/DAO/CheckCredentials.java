package com.DAO;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Model.User;

/**
 * Servlet implementation class CheckCredentials
 */
@WebServlet("/CheckCredentials")
public class CheckCredentials extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreparedStatement mySmt = null;
	private Connection myCon = null;
	private ResultSet myRs = null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String email = request.getParameter("email").toString();
		String password = request.getParameter("password").toString();
		
		try {
			myCon = DatabaseConnection.getConnection();
			if (myCon != null){
				mySmt = myCon.prepareStatement("select firstname,lastname,email,company,passwd from Users where email=?");
				mySmt.setString(1, email);
				myRs = mySmt.executeQuery();
				if (myRs.next()) {
					if (password.equals(myRs.getString("passwd"))) {
						User user = new User(myRs.getString("firstname"),myRs.getString("lastname"),myRs.getString("email"),myRs.getString("company"));
						request.getSession().setAttribute("user", user);
						response.sendRedirect("Dashboard.jsp");
					}
					else {
						response.sendRedirect("index.jsp?m=Wrong password entered");
					}
				}
				else {
					response.sendRedirect("index.jsp?m=No such account found");
				}
			}
			else {
				response.sendRedirect("index.jsp?m=Cannot connect to the server");
			}
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
