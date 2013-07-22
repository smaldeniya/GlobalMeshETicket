/**
 * 
 */
package com.globalmesh.action.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.UserDAO;
import com.globalmesh.dto.User;

/**
 * @author Dil
 *
 */
@SuppressWarnings("serial")
public class UserGetAction extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String email = (String) req.getSession().getAttribute("email");
		User user = null;
		try {
			user = UserDAO.INSTANCE.getUserByEmail(email);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		req.setAttribute("user", user);
		
		RequestDispatcher view = req.getRequestDispatcher("profile.jsp");		
		view.forward(req, resp);
	}
}
