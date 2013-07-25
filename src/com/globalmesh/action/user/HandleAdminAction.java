package com.globalmesh.action.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HandleAdminAction extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		/**
		 * setting hall names from database hall objects
		 */
		req.setAttribute("", "");
		req.setAttribute("", "");
		req.setAttribute("", "");
		req.setAttribute("", "");
		
		req.getRequestDispatcher("/adminProfile.jsp").forward(req, resp);
	}
	
}
