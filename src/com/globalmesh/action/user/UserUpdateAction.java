package com.globalmesh.action.user;

import java.io.IOException;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;

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
				} else {
					req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
					req.setAttribute("message", Utility.getCONFG().getProperty(Constants.USER_UPDATE_WRONG_CURRUNT_PASSWORD));
				}
								
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String newPassword = req.getParameter("newPasswordU");
			
			
		} else {
			try {
				String email = req.getParameter("email");
				
				User user = UserDAO.INSTANCE.getUserByEmail(email);
				
				String firstName = req.getParameter("firstName");
				String lastName = req.getParameter("lastName");	
				String mobile = req.getParameter("mobile");			
				String country = req.getParameter("country");
				String address = req.getParameter("address");
				
				user.setFirstName(firstName);
				user.setLastName(lastName);		
				user.setMobileNo(mobile);
				
				if (country != null && !country.equals("")) {
					user.setCountry(country); // this will add later not need in
												// registration
				}

				if (address != null && !address.equals("")) {
					user.setAddress(address); // this will add later not need in
												// registration
				}
				
				if(UserDAO.INSTANCE.update(user)){
					req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
					req.setAttribute("message", Utility.getCONFG().getProperty(Constants.USER_UPDATED_MESSAGE));
				}
				
				req.getRequestDispatcher("/profile.jsp").forward(req, resp);

			} catch (Exception e) {
				req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.USER_UPDATE_FAIL_MESSAGE));
			}
		}
		
		req.getRequestDispatcher("/profile.jsp").forward(req, resp);		

	}
}
