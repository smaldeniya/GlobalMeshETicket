package com.globalmesh.action.login;

import java.io.IOException;
import java.text.MessageFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.UserDAO;
import com.globalmesh.dto.User;
import com.globalmesh.util.Constants;
import com.globalmesh.util.MD5HashGenerator;
import com.globalmesh.util.RandomKeyGen;
import com.globalmesh.util.Utility;

public class VerifyAccountServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String userEmail = (String) req.getAttribute("email");
		String type = req.getParameter("type");
		
		User user = UserDAO.INSTANCE.getUserByEmail(userEmail);
		
		if(user != null) {
			
			if(type.compareTo("resend") == 0) {
				if(user.getVerified().compareTo(Constants.USER_VERIFIED_DONE) != 0) {
					
					try {
						String verification = RandomKeyGen.createId();
						user.setVerified(verification);
						UserDAO.INSTANCE.update(user);

						String emailBody = MessageFormat.format(Utility.getCONFG().getProperty(Constants.USER_RESEND_VERIFICATIN_BODY), user.getFirstName(), user.getEmail(), user.getVerified());
						Utility.sendEmail(Utility.getCONFG().getProperty(Constants.USER_REG_EMAIL_SUBJECT), emailBody, user.getEmail(), Utility.getCONFG().getProperty(Constants.SITE_EMAIL));
						
						req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
						String message = Utility.getCONFG().getProperty(Constants.USER_VERI_RESEND_MESSAGE);		
						req.setAttribute("message", message);
						
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				} else {
					req.setAttribute("msgClass", Constants.MSG_CSS_INFO);
					String message = Utility.getCONFG().getProperty(Constants.USER_VERI_ACCOUNT_ALREDY_VERIFIED);		
					req.setAttribute("message", message);
				}
				
			}
			
			if(type.compareTo("verify") == 0) {
				
				String verification = req.getParameter("veriCode");
				
				if(user.getVerified().compareTo(verification) == 0) {
					user.setVerified(Constants.USER_VERIFIED_DONE);
					UserDAO.INSTANCE.update(user);
					
					req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
					String message = Utility.getCONFG().getProperty(Constants.USER_VERI_SUCCES);		
					req.setAttribute("message", message);
				} else {
					req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
					String message = Utility.getCONFG().getProperty(Constants.USER_VERI_WRONG_CODE);		
					req.setAttribute("message", message);
				}
				
			}
			
		}
		
	}
	
}
