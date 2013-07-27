/**
 * 
 */
package com.globalmesh.action.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.UserDAO;
import com.globalmesh.dto.User;
import com.globalmesh.util.Constants;
import com.globalmesh.util.Utility;

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
		if(email == null){
			req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
			req.setAttribute("message", Utility.getCONFG().getProperty(Constants.LOGIN_NEED_MESSAGE));
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);
		} else {
			User user = null;
			
			user = UserDAO.INSTANCE.getUserByEmail(email);
			
			req.setAttribute("user", user);
			req.setAttribute("msgClass", Constants.MSG_CSS_INFO);
			req.setAttribute("message", Utility.getCONFG().getProperty(Constants.USER_PROFILE_UPDATE_INFO));
			req.getRequestDispatcher("/profile.jsp").forward(req, resp);
		}
	}
}
