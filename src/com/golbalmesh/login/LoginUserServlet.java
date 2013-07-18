/**
 * 
 */
package com.golbalmesh.login;

import java.io.IOException;

import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.golbalmesh.dao.UserDAO;
import com.golbalmesh.dto.User;
import com.golbalmesh.util.Constants;
import com.golbalmesh.util.MD5HashGenerator;

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
			
			if(user.getPassword().equals(encryptPwd))
			{
				HttpSession session = req.getSession();
				session.setAttribute("login", user.getFirstName() + " " + user.getLastName());
				session.setAttribute("email", user.getEmail());
				session.setAttribute("type", user.getUserType());
				
				resp.sendRedirect("/index.jsp");
			}
			else
			{
				req.setAttribute("message", Constants.USER_LOGIN_FAILED);
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);		
			}
				
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
