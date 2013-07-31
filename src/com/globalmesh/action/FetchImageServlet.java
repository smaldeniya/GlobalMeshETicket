package com.globalmesh.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.HallDAO;
import com.globalmesh.dto.Hall;
import com.globalmesh.util.Constants;
import com.globalmesh.util.Utility;
import com.google.appengine.api.datastore.Blob;

public class FetchImageServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String type = req.getParameter("type");
		String hall = req.getParameter("hall");
		
		Blob image = null;
		
		if(type != null ) {
			if(type.compareTo("hall") == 0){
				if(hall != null){
					if(hall.compareTo("gold") == 0){
						image = getHallBanner(Utility.getCONFG().getProperty(Constants.HALL_GOLD));
					} else if(hall.compareTo("ultra") == 0) {
						image = getHallBanner(Utility.getCONFG().getProperty(Constants.HALL_ULTRA));
					} if(hall.compareTo("platinum") == 0) {
						image = getHallBanner(Utility.getCONFG().getProperty(Constants.HALL_PLATINUM));
					} if(hall.compareTo("superior") == 0) {
						image = getHallBanner(Utility.getCONFG().getProperty(Constants.HALL_SUPERIOR));
					} else {
						
					}
				}
			}
			
			// other images
		} else {
			
		}
		
		if(image != null) {
			resp.setContentType("image/jpg");
			resp.getOutputStream().write(image.getBytes());
		} else {
			throw new RuntimeException("Banner can not find for " + hall);
		}
		
	}
	
	private Blob getHallBanner(String hallName) {
		Hall h = HallDAO.INSTANCE.getHallById(hallName);
		return h.getMovieBanner();
	}
	
}
