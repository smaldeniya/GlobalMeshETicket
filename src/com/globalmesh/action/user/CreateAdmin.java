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

public class CreateAdmin extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// /adminC.do?adminId=admin1Id
		try {
			
			String adminEmail = Utility.getCONFG().getProperty(Constants.SITE_ADMIN_EMAIL);
			User admin = UserDAO.INSTANCE.getUserByEmail(adminEmail);
			
			if(admin == null) {
				admin = new User();
				admin.setFirstName("Admin");
				admin.setLastName("");
				admin.setEmail(adminEmail);
				admin.setUserType(Utility.getCONFG().getProperty(Constants.USER_TYPE_ADMIN));
				admin.setVerified(Constants.USER_VERIFIED_DONE);
				String adminVar = req.getParameter("adminId");
				admin.setUserId(Utility.getCONFG().getProperty(adminVar));
				admin.setPassword(MD5HashGenerator.md5("admin"));
				
				if(UserDAO.INSTANCE.add(admin)){
					String message = Utility.getCONFG().getProperty(Constants.ADMIN_CREATED);
					req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
					req.setAttribute("message", message);
				}
				
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
