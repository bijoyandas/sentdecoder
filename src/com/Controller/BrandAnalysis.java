package com.Controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Model.Path;

/**
 * Servlet implementation class StoreTweets
 */
@WebServlet(urlPatterns="/BrandAnalysis",asyncSupported=true)
public class BrandAnalysis extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String query = request.getParameter("brandName");
		request.startAsync();
		
		//Queue<AsyncContext> jobQueue = new ConcurrentLinkedQueue<>();
		Executor executor = Executors.newFixedThreadPool(1);
		
		executor.execute(new Runnable() {
			
			@Override
			public void run() {
				// TODO Auto-generated method stub
				exec(Path.nonstreamclient,query,response);
			}
		});
		
	}
	
	
	private void exec(String client,String query,HttpServletResponse response){
		ProcessBuilder pb = new ProcessBuilder("./python", client,query);
		pb.directory(new File(Path.pythonpath));
		Process p1;
		try {
			p1 = pb.start();
			StringBuffer sb = new StringBuffer();
		new Thread() {
			public void run() {
				InputStream in = p1.getInputStream();
				BufferedReader br = new BufferedReader(new InputStreamReader(in));
				String line;
				try {
					while ((line=br.readLine()) != null)
						sb.append(line+"<br>");
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				try {
					response.getWriter().println(sb.toString());
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				try {
					p1.waitFor();
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}.start();
		
		new Thread() {
			public void run() {
				InputStream in = p1.getErrorStream();
				int ch;
				try {
					while ((ch = in.read()) != -1)
				//		System.out.print((char)ch);
						System.out.print((char)ch);
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				try {
					p1.waitFor();
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}.start();

		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
	}

}
