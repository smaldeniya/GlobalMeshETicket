package com.globalmesh.action.hall;

import java.io.IOException;
import java.text.MessageFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.HallDAO;
import com.globalmesh.dto.Hall;
import com.globalmesh.util.Constants;
import com.globalmesh.util.Utility;

public class InsertHallDetails extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String hallName = req.getParameter("hallName");
		int numOfSeats = Integer.parseInt(req.getParameter("noOfSeats"));
		boolean is3D = (req.getParameter("is3D") != null);
		double odcFull = Double.parseDouble(req.getParameter("odcTicketPrice"));
		double odcHalf = Double.parseDouble(req.getParameter("odcHalfTicketPrice"));
		
		Hall h = HallDAO.INSTANCE.getHallById(hallName);
		
		if(h != null ) {
			h.setNumOfSeats(numOfSeats);
			h.setThreeD(is3D);
			h.setOdcFull(odcFull);
			h.setOdcHalf(odcHalf);
			
			if(HallDAO.INSTANCE.updateHall(h)){
				req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
				String message = MessageFormat.format(Utility.getCONFG().getProperty(Constants.HALL_UPDATE_SUCCESS_FULL), h.getHallId());
				req.setAttribute("message", message);
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			} else {
				req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
				req.setAttribute("message",Utility.getCONFG().getProperty(Constants.HALL_TRAN_FAIl));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			}
			
		} else {
			h = new Hall();
			h.setHallId(hallName);
			h.setNumOfSeats(numOfSeats);
			h.setThreeD(is3D);
			h.setOdcFull(odcFull);
			h.setOdcHalf(odcHalf);
			
			if(HallDAO.INSTANCE.addHall(h)){
				req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.HALL_ENTER_SUCCESSFULL));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			} else {
				req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.HALL_TRAN_FAIl));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			}
		}
		
		
	}
	
}
