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

		try {
			String email = req.getParameter("email");
			
			User user = new User();
			
			String firstName = req.getParameter("firstName");
			String lastName = req.getParameter("lastName");							
			String password = req.getParameter("repassword");	
			String mobile = req.getParameter("mobile");			
			String country = req.getParameter("country");
			String address = req.getParameter("address");
			
			user.setFirstName(firstName);
			user.setLastName(lastName);
			user.setPassword(password);			
			user.setMobileNo(mobile);
			user.setEmail(email);
			
			if(password != null && !password.equals("")){
				user.setPassword(MD5HashGenerator.md5(password));
			}
			
			if (country != null && !country.equals("")) {
				user.setCountry(country); // this will add later not need in
											// registration
			}

			if (address != null && !address.equals("")) {
				user.setAddress(address); // this will add later not need in
											// registration
			}
			
			if(UserDAO.INSTANCE.update(user)){
				
			}
			
			req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
			req.setAttribute("message", Utility.getCONFG().getProperty(Constants.USER_UPDATED_MESSAGE));
			req.getRequestDispatcher("/profile.jsp").forward(req, resp);

		} catch (Exception e) {

		}

	}
}
