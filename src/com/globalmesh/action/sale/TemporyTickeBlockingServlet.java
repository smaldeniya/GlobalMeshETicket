package com.globalmesh.action.sale;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.util.TemperySaleHolder;

public class TemporyTickeBlockingServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.getWriter().write("hello");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String userEmail = (String) req.getSession().getAttribute("email");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/plain");
		
		String type = req.getParameter("type");
		
		if(type.compareTo("addReservation") == 0) {
			String ticketKey = req.getParameter("ticketKey"); // key will be like '2013-08-13-10:30 AM-gold-C3'
			
			
			if(TemperySaleHolder.notHas(ticketKey)){
				resp.getWriter().write(TemperySaleHolder.add(ticketKey, userEmail)==true?"true":"false");
			} else {
				if(TemperySaleHolder.compare(ticketKey, userEmail)){
					resp.getWriter().write(TemperySaleHolder.remove(ticketKey, userEmail)==true?"true":"false");
				} else {
					resp.getWriter().write("false");
				}
			}
		}
		
		if(type.compareTo("removeReservation") == 0) {
			String seatSel = req.getParameter("seatSet");
			
			if(seatSel.compareTo("") != 0) {
				String[] seats = seatSel.split(";");
				for (String string : seats) {
					TemperySaleHolder.removeBySeat(string, userEmail);
				}
			}
		}		
		
	}
	
}
