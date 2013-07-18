/**
 * 
 */
package com.golbalmesh.action.user;

import java.io.IOException;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.golbalmesh.dao.UserDAO;
import com.golbalmesh.dto.User;
import com.golbalmesh.util.Constants;
import com.golbalmesh.util.MD5HashGenerator;
import com.golbalmesh.util.Utility;

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
			
			
			
			if (UserDAO.INSTANCE.add(user)) {
				String message = Constants.USER_REG_SUCCESS_MESSAGE;		
				req.setAttribute("message", message);
				String URL = MessageFormat.format(Constants.SITE_URL, "useri.do?email="+user.getEmail()+"&verifi="+user.getVerified());
				System.out.println(URL);
				
				String emailBody = MessageFormat.format(Constants.USER_REG_EMAIL_BODY, user.getFirstName(), user.getEmail(), URL);
				Utility.sendEmail(Constants.USER_REG_EMAIL_SUBJECT, emailBody, user.getEmail(), Constants.SITE_EMAIL);
			}
			
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			
		} catch (Exception e) {
			
		}
	}
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
	
		try {
			User user = new User();
			
			user.setUserId("userId") ;
			user.setFirstName("firstName") ;
			user.setLastName("lastName") ;
			user.setEmail("email");
			user.setPassword(MD5HashGenerator.md5("password"));			
			user.setGender("M");//M-Male F-Female								
			//user.setDob(new SimpleDateFormat("yyyy/MM/dd", Locale.ENGLISH).parse("2013-07-12"));
			user.setCountry("country");
			user.setAddress("address");
			user.setMobileNo("mobileNo");
			
			UserDAO.INSTANCE.add(user);
			
			//resp.sendRedirect("/TodoApplication.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
