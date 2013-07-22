package com.globalmesh.action.hall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SuperiorAction extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String [] shows = {"10:30", "1:30", "4:30", "7"};
		
		req.setAttribute("goldShows", shows);		
		req.getRequestDispatcher("/superior_seatPlan.jsp").forward(req, resp);
	}
	
}
