/**
 * 
 */
package com.globalmesh.action.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.globalmesh.dao.UserDAO;
import com.globalmesh.dto.User;
import com.globalmesh.util.Constants;
import com.globalmesh.util.MD5HashGenerator;
import com.globalmesh.util.Utility;

/**
 * @author dil
 *
 */
public class LoginUserServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String email = req.getParameter("username");
		String pwd = req.getParameter("password");
		
		try {
			String encryptPwd = MD5HashGenerator.md5(pwd);
			
			User user = UserDAO.INSTANCE.getUserByEmail(email);
			
			if(user != null && user.getPassword().equals(encryptPwd))
			{
				HttpSession session = req.getSession();
				String name = user.getFirstName() + " " + user.getLastName();
				session.setAttribute("login", name.trim());
				session.setAttribute("email", user.getEmail());
				session.setAttribute("type", user.getUserType());
				
				resp.sendRedirect("/init.do");
			}
			else
			{
				req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.USER_LOGIN_FAILED));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);		
			}
				
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
