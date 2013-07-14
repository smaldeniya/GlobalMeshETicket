/**
 * 
 */
package com.golbalmesh.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.golbalmesh.dao.UserDAO;
import com.golbalmesh.dto.User;
import com.golbalmesh.util.MD5HashGenerator;

/**
 * @author dil
 *
 */
public class LoginUserServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String userId = req.getParameter("userId");
		String pwd = req.getParameter("pwd");
		
		try {
			String encryptPwd = MD5HashGenerator.md5(pwd);
			
			User user = UserDAO.INSTANCE.getUserById(userId);
			
			if(user.getPassword().equals(encryptPwd))
			{
				//redirect to logon successfull page				
			}
			else
			{
				//redirect to login failed page				
			}
				
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
