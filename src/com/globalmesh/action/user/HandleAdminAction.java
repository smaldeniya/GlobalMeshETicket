package com.globalmesh.action.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.HallDAO;
import com.globalmesh.dto.Hall;

public class HandleAdminAction extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
				
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
