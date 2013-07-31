package com.globalmesh.action.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.HallDAO;
import com.globalmesh.dto.Hall;
import com.globalmesh.util.Constants;
import com.globalmesh.util.Utility;

public class HandleAdminAction extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String user = (String) req.getSession().getAttribute("email");
		
		if(user == null) {
			req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
			req.setAttribute("message", Utility.getCONFG().getProperty(Constants.LOGIN_NEED_MESSAGE));
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			
		} else {
			List<Hall> hallList = HallDAO.INSTANCE.listHalls();
			int numOfHalls = hallList.size();
			String [] hallNames = new String[numOfHalls];
			
			if(numOfHalls > 0){				
				for(int i = 0; i < numOfHalls; i++){
					hallNames[i] = hallList.get(i).getHallId();
				}
			}			
			
			req.setAttribute("hallNames", hallNames);		
			req.setAttribute("freeHalls", (4 - numOfHalls));
			
			req.getRequestDispatcher("/adminProfile.jsp").forward(req, resp);
		}	
		
		
	}
	
}
