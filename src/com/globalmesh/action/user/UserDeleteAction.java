/**
 * 
 */
package com.globalmesh.action.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.UserDAO;

/**
 * @author Dil
 *
 */
@SuppressWarnings("serial")
public class UserDeleteAction extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String id = req.getParameter("id");
		try {
			UserDAO.INSTANCE.remove(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    //resp.sendRedirect("/TodoApplication.jsp");
	}
}
