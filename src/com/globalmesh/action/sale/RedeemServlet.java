package com.globalmesh.action.sale;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.SaleDAO;
import com.globalmesh.dto.Sale;

public class RedeemServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String type = req.getParameter("type");
		
		if(type.compareTo("getDetails") == 0) {
			String verifiCode = req.getParameter("ticketSerial");
			
			resp.setContentType("text/plain");
			resp.setCharacterEncoding("UTF-8");
			
			Sale sale = SaleDAO.INSTANCE.getSaleByVeriCode(verifiCode);			
			
			if(sale != null) {
				DateFormat showDate = new SimpleDateFormat("yyyy-MM-dd");
				DateFormat showTime = new SimpleDateFormat("hh:mm a");
				
				StringBuilder sb = new StringBuilder();
				
				sb.append(showDate.format(sale.getShowDate()));
				sb.append(";");
				
				sb.append(showTime.format(sale.getShowDate()));
				sb.append(";");
				
				sb.append(showDate.format(sale.getTransactionDate()));
				sb.append(";");
				
				sb.append(sale.getTotal());
								
				resp.getWriter().write(sb.toString());
			} else {
				resp.getWriter().write("false");
			}
			
		}
		
	}
	
}
