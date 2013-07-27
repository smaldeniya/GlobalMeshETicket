package com.globalmesh.action.hall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.HallDAO;
import com.globalmesh.dto.Hall;

public class GetHall extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String hallId = req.getParameter("hallId");
		Hall h = HallDAO.INSTANCE.getHallById(hallId);
		
		resp.setContentType("text/plain");
		resp.setCharacterEncoding("UTF-8");
		resp.getWriter().write(h.getNumOfSeats() + ";" + h.isThreeD() + ";" + h.getOdcFull() + ";" + h.getOdcHalf());
		
	}
	
}
