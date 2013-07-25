package com.globalmesh.action.hall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.util.Constants;
import com.globalmesh.util.Utility;

public class SuperiorAction extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String user = (String) req.getSession().getAttribute("email");
		
		if(user == null) {
			req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
			req.setAttribute("message", Utility.getCONFG().getProperty(Constants.LOGIN_NEED_MESSAGE));
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			
		} else {
			String [] shows = {"10:30 AM", "1:30 PM", "4:30 PM", "7:00 PM"};
			
			req.setAttribute("superiorShows", shows);		
			req.getRequestDispatcher("/superior_seatPlan.jsp").forward(req, resp);
		}
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
		String userEmail = (String) req.getSession().getAttribute("email");
		
		System.out.println(hallName);
		
	}
	
}
