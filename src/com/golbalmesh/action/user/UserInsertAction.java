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
			
			user.setUserId(req.getParameter("userId")) ;
			user.setFirstName(req.getParameter("firstName")) ;
			user.setLastName(req.getParameter("lastName")) ;
			user.setEmail(req.getParameter("email"));
			user.setPassword(MD5HashGenerator.md5(req.getParameter("password")));			
			
			if(req.getParameter("gender").equals("Male"))
			{
				user.setGender('M');//M-Male F-Female
			}
			else
			{			
				user.setGender('F');//M-Male F-Female
			}
				
			user.setDob(new SimpleDateFormat("yyyy/MM/dd", Locale.ENGLISH).parse(req.getParameter("dob")));
			user.setNicNo(req.getParameter("nicNo"));
			user.setCountry(req.getParameter("country"));
			user.setAddress(req.getParameter("address"));
			user.setMobileNo(req.getParameter("mobileNo"));
			
			UserDAO.INSTANCE.add(user);
			
			//resp.sendRedirect("/TodoApplication.jsp");
			
		} catch (Exception e) {
			
		}
	}
}
