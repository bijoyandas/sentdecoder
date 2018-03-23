package com.DAO;

import java.sql.*;
public class DatabaseConnection {
	private static Connection myCon = null;
	public static Connection getConnection() throws SQLException, ClassNotFoundException {
		if (myCon==null) {
			Class.forName("com.mysql.jdbc.Driver");
			myCon = DriverManager.getConnection("jdbc:mysql://localhost:3306/twitterprojectdb","bijoyan","mad12345");
		}
		return myCon;
	}
}
