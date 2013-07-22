package com.globalmesh.action.hall;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GoldAction extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String [] shows = {"10:30", "1:30", "4:30", "7"};
		
		req.setAttribute("goldShows", shows);		
		req.getRequestDispatcher("/gold_seatPlan.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String hallName = req.getParameter("hallName");
		String showDate = req.getParameter("showDate");
		String showTime = req.getParameter("showTime");
		String numOfHalfTickets = req.getParameter("halfTicket");
		String seatSelection = req.getParameter("seatSelection");
		String seatCount = req.getParameter("seatCount");
		
		
	}
	
}
