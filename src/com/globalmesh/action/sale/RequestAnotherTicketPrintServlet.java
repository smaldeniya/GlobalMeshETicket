package com.globalmesh.action.sale;

import java.io.IOException;
import java.text.MessageFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dao.SaleDAO;
import com.globalmesh.dao.UserDAO;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.dto.Sale;
import com.globalmesh.dto.User;
import com.globalmesh.util.Constants;
import com.globalmesh.util.RandomKeyGen;
import com.globalmesh.util.Utility;

public class RequestAnotherTicketPrintServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String saleId = req.getParameter("saleId");
		
		Sale sale = SaleDAO.INSTANCE.getSaleById(saleId);
		
		if(sale != null) {
			
			String newVarCode = RandomKeyGen.createId();
			sale.setVeriFicationCode(newVarCode);
						
			if(SaleDAO.INSTANCE.update(sale)) {
				MovieDetail movie = MovieDetailDAO.INSTANCE.getMovieById(sale.getMovie());
				User user = UserDAO.INSTANCE.getUserById(sale.getUserId());
				String emailBody = MessageFormat.format(Utility.getCONFG().getProperty(Constants.SALE_VERI_CODE_EMAIL_BODY), 
							movie.getMovieName(), sale.getShowDate(), sale.getHall(), sale.getVeriFicationCode());
				
				Utility.sendEmail(Utility.getCONFG().getProperty(Constants.SALE_VERI_CODE_EMAIL_SUBJECT), emailBody, user.getEmail(), Utility.getCONFG().getProperty(Constants.SITE_EMAIL));
				
				req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.TICKET_RE_PRINT_SUCCESS));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
				
			} else {
				req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.TICKET_RE_PRINT_FAIL));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			}
			
		}
		
	}
	
}
