package com.golbalmesh.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResetPasswordServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.getSession().setAttribute("hasReset", "true");
//		resp.sendRedirect("resetPassword.jsp");
		req.getRequestDispatcher("resetPassword.jsp").forward(req, resp);
	}
	
}
