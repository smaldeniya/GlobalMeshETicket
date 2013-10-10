package com.globalmesh.action.hall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.util.Constants;
import com.globalmesh.util.Utility;

public class SelectHall extends HttpServlet {

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String user = (String) req.getSession().getAttribute("email");

		if (user == null) {
			req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
			req.setAttribute("message",
					Utility.getCONFG()
							.getProperty(Constants.LOGIN_NEED_MESSAGE));
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);

		} else {
		
			resp.sendRedirect("/selectHall.jsp");
			
		}
		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("doPost");
	}
	
}
