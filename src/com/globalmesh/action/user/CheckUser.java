package com.globalmesh.action.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.UserDAO;
import com.globalmesh.dto.User;

public class CheckUser extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String byParameter = req.getParameter("by");
		String value = req.getParameter("value");
		String response = checkParameter(byParameter, value);		
		
		resp.setContentType("text/plain");
		resp.setCharacterEncoding("UTF-8");
//		resp.setStatus(resp.SC_OK);
		resp.getWriter().write(response);
		
	}
	
	private String checkParameter(String byParameter, String value) {
		String response = "";
		if(byParameter.compareTo("email") == 0){
			try {
				User user = UserDAO.INSTANCE.getUserByEmail(value);
				if(user == null) {
					response = "null";
				} else {
					response = user.getEmail();
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return response;
	}
	
}
