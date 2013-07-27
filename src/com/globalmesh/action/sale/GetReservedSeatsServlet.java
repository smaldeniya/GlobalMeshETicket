package com.globalmesh.action.sale;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dto.Hall;
import com.globalmesh.dto.Sale;
import com.globalmesh.dao.HallDAO;
import com.globalmesh.dao.SaleDAO;
import com.globalmesh.util.Utility;

public class GetReservedSeatsServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String date = req.getParameter("showDate");
		String time = req.getParameter("showTime"); //time is must to identify the booking
		String hall = Utility.chooseHall(req.getParameter("hallName"));
		Hall h = HallDAO.INSTANCE.getHallById(hall);
		
		DateFormat showFormat = new SimpleDateFormat("yyyy-MM-dd");
		List<Sale> bookings = null;
		try {
			bookings = SaleDAO.INSTANCE.listSalesByDateAndHall(showFormat.parse(date + " " + time), h);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		StringBuilder sb = new StringBuilder();
		for (Sale s : bookings) {
			
/*			sb.append(s.getSeats());
			if(bookings.indexOf(s) < bookings.size() -1 ){
				sb.append(";");
			}*/
		}
		
		resp.getWriter().write(sb.toString());
		
	}
	
}
