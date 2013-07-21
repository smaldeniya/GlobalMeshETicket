/**
 * 
 */
package com.globalmesh.action.user;

import java.io.IOException;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.UserDAO;
import com.globalmesh.dto.User;
import com.globalmesh.util.Constants;
import com.globalmesh.util.MD5HashGenerator;
import com.globalmesh.util.Utility;

/**
 * @author Transformers
 *
 */
@SuppressWarnings("serial")
public class UserInsertAction extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
	
		try {
			User user = new User();

			String nic = req.getParameter("nic");
			String firstName = req.getParameter("firstName");
			String lastName = req.getParameter("lastName");
			String email = req.getParameter("email");
			String password = MD5HashGenerator.md5(req.getParameter("regpassword"));
			String gender = req.getParameter("gender");
			String mobile = req.getParameter("mobile");
			String dob = req.getParameter("dob");
			String country = req.getParameter("country");
			String address = req.getParameter("address");
			
			user.setUserId(nic) ; 
			user.setFirstName(firstName) ;
			user.setLastName(lastName) ;
			user.setEmail(email);
			user.setPassword(password);			
			user.setGender(gender);
			user.setMobileNo(mobile);
				
			if (dob != null) {
				user.setDob(new SimpleDateFormat("yyyy/MM/dd", Locale.ENGLISH)
						.parse(dob)); //this will not need in registration wil update later
			}
			
			if(country != null) {
				user.setCountry(country); //this will add later not need in registration 
			}
			
			if(address != null){
				user.setAddress(address); //this will add later not need in registration
			}
			
			String verification = MD5HashGenerator.md5(email);
			user.setVerified(verification);
			user.setUserType(Utility.getCONFG().getProperty(Constants.USER_TYPE_USER));
			
			
			if (UserDAO.INSTANCE.add(user)) {
				
				String URL = MessageFormat.format(Utility.getCONFG().getProperty(Constants.SITE_URL), "useri.do?verifi="+user.getVerified());
				System.out.println(URL);
				String emailBody = MessageFormat.format(Utility.getCONFG().getProperty(Constants.USER_REG_EMAIL_BODY), user.getFirstName(), user.getEmail(), URL);
				Utility.sendEmail(Utility.getCONFG().getProperty(Constants.USER_REG_EMAIL_SUBJECT), emailBody, user.getEmail(), Utility.getCONFG().getProperty(Constants.SITE_EMAIL));
				
				String message = Utility.getCONFG().getProperty(Constants.USER_REG_SUCCESS_MESSAGE);		
				req.setAttribute("message", message);
			}
			
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			
		} catch (Exception e) {
			
		}
	}
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
	
		try {
			System.out.println(req.getParameter("verifi"));
			User user = UserDAO.INSTANCE.getUserByVeriCode(req.getParameter("verifi"));
			
			if(user != null) {
				user.setVerified(Constants.USER_VERIFIED_DONE);
				UserDAO.INSTANCE.add(user);
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.USER_REG_VARIFIED_MESSAGE));
				
			} else {
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.USER_REG_VARIFIED_FAIL));
			}			
			
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
}
