package com.DAO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Model.User;

/**
 * Servlet implementation class RegisterCredentials
 */
@WebServlet("/RegisterCredentials")
public class RegisterCredentials extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection myCon = null;
	private PreparedStatement mySmt = null;
	private ResultSet myRs = null;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String company = request.getParameter("company");
		try {
			myCon = DatabaseConnection.getConnection();
			mySmt = myCon.prepareStatement("select * from Users where email=?");
			mySmt.setString(1, email);
			myRs = mySmt.executeQuery();
			mySmt = null;
			if (!myRs.next()) {
				mySmt = myCon.prepareStatement("insert into Users(email,firstname,lastname,passwd,company) values(?,?,?,?,?)");
				mySmt.setString(1, email);
				mySmt.setString(2, firstname);
				mySmt.setString(3, lastname);
				mySmt.setString(4, password);
				mySmt.setString(5, company);
				int status = mySmt.executeUpdate();
				if (status > 0){
					request.getSession().setAttribute("user", new User(firstname,lastname,email,company));
					response.sendRedirect("Dashboard.jsp");
				}
				else {
					response.sendRedirect("index.jsp");
				}
			}
			else {
				response.sendRedirect("index.jsp");
			}
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
