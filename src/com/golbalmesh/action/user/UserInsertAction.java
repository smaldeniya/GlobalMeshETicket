/**
 * 
 */
package com.golbalmesh.action.user;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.golbalmesh.dao.UserDAO;
import com.golbalmesh.dto.User;
import com.golbalmesh.util.MD5HashGenerator;

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
			
			user.setUserId("1") ; //autogenrate
			user.setFirstName(req.getParameter("firstName")) ;
			user.setLastName(req.getParameter("lastName")) ;
			user.setEmail(req.getParameter("email"));
			user.setPassword(MD5HashGenerator.md5(req.getParameter("regpassword")));			
			
			user.setGender(req.getParameter("gender"));
				
//			user.setDob(new SimpleDateFormat("yyyy/MM/dd", Locale.ENGLISH).parse(req.getParameter("dob"))); this will not need in registration wil update later
			user.setNicNo(req.getParameter("nic"));
//			user.setCountry(req.getParameter("country")); this will add later not need in registration 
//			user.setAddress(req.getParameter("address"));this will add later not need in registration 
			user.setMobileNo(req.getParameter("mobile"));
			
			UserDAO.INSTANCE.add(user);
			
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
			user.setNicNo("882690938V");
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
