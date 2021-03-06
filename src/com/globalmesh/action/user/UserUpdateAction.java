package com.globalmesh.action.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.UserDAO;
import com.globalmesh.dto.User;
import com.globalmesh.util.Constants;
import com.globalmesh.util.MD5HashGenerator;
import com.globalmesh.util.Utility;

public class UserUpdateAction extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String updateType = req.getParameter("updatetype");
		
		if(updateType.compareTo(Utility.getCONFG().getProperty(Constants.USER_UPDATE_TYPE_PASSWORD)) == 0){
			System.out.println("inside password");
			
			String email = req.getParameter("emailU");
			try {
				User user = UserDAO.INSTANCE.getUserByEmail(email);
				
				String curPassword = MD5HashGenerator.md5(req.getParameter("curPasswordU"));
				String newPassword = MD5HashGenerator.md5(req.getParameter("newPasswordU"));
				
				if(curPassword.compareTo(user.getPassword()) == 0) {
					user.setPassword(newPassword);
					UserDAO.INSTANCE.update(user);
					req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
					req.setAttribute("message", Utility.getCONFG().getProperty(Constants.USER_UPDATED_MESSAGE));
					req.getRequestDispatcher("/messages.jsp").forward(req, resp);
				} else {
					req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
					req.setAttribute("message", Utility.getCONFG().getProperty(Constants.USER_UPDATE_WRONG_CURRUNT_PASSWORD));
					req.getRequestDispatcher("/messages.jsp").forward(req, resp);
				}
								
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} else if(updateType.compareTo("userType") == 0) {
			
			String email = req.getParameter("emailT");
			int accountType = Integer.parseInt(req.getParameter("newType"));
			
			User user = UserDAO.INSTANCE.getUserByEmail(email);
			if(user != null) {
				switch (accountType) {
				case 1:
					user.setUserType(Utility.getCONFG().getProperty(Constants.USER_TYPE_ADMIN));
					break;
				case 2:
					user.setUserType(Utility.getCONFG().getProperty(Constants.USER_TYPE_USER));
					break;
				}
				
				if(UserDAO.INSTANCE.update(user)){
					req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
					req.setAttribute("message", Utility.getCONFG().getProperty(Constants.USER_UPDATED_MESSAGE));
					req.getRequestDispatcher("/messages.jsp").forward(req, resp);
				} else {
					req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
					req.setAttribute("message", Utility.getCONFG().getProperty(Constants.USER_UPDATE_FAIL_MESSAGE));
					req.getRequestDispatcher("/messages.jsp").forward(req, resp);
				} 
			}else {
				req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.USER_UPDATE_FAIL_MESSAGE));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			}
			
		} else {
			String email = req.getParameter("emailU");

			User user = UserDAO.INSTANCE.getUserByEmail(email);

			String firstName = req.getParameter("firstNameU");
			String lastName = req.getParameter("lastNameU");
			String mobile = req.getParameter("mobileU");
			String city = req.getParameter("cityU");
			String address = req.getParameter("addressU");

			user.setFirstName(firstName);
			user.setLastName(lastName);
			user.setMobileNo(mobile);

			if (city != null && !city.equals("")) {
				user.setCity(city); // this will add later not need in
											// registration
			}

			if (address != null && !address.equals("")) {
				user.setAddress(address); // this will add later not need in
											// registration
			}

			if (UserDAO.INSTANCE.update(user)) {
				req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
				req.setAttribute(
						"message",
						Utility.getCONFG().getProperty(
								Constants.USER_UPDATED_MESSAGE));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			} else {
				req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
				req.setAttribute(
						"message",
						Utility.getCONFG().getProperty(
								Constants.USER_UPDATE_FAIL_MESSAGE));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			}

		}
		
	}
}
