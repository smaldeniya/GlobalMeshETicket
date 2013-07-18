package com.golbalmesh.login;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.golbalmesh.dao.UserDAO;
import com.golbalmesh.dto.User;
import com.golbalmesh.util.Constants;
import com.golbalmesh.util.MD5HashGenerator;
import com.golbalmesh.util.Utility;

public class ResetPasswordServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String email = req.getParameter("resetEmale");
		
		try {
			User user = UserDAO.INSTANCE.getUserByEmail(email);
			
			if(user != null) {
				String newPassword = Utility.shortUUID();
				System.out.println(newPassword);
				user.setPassword(MD5HashGenerator.md5(newPassword));
				
				String messaageBody = MessageFormat.format(Constants.RESET_PASSWORD_EMAIL_BODY, newPassword);
				
				Utility.sendEmail(Constants.RESET_PASSWORD_EMAIL_SUBJECT, messaageBody, user.getEmail(), Constants.SITE_EMAIL);
				
				req.setAttribute("resetMsg", Constants.RESET_PASSWORD_SUCCESS_MESSAGE);
				
			} else {
				req.setAttribute("resetMsg", Constants.RESET_PASSWORD_WRONG_USER);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		req.getRequestDispatcher("/resetPassword.jsp").forward(req, resp);
	}
	
}
