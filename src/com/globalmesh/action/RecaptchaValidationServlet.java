package com.globalmesh.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

public class RecaptchaValidationServlet extends HttpServlet {

	private static final String PRIVATE_KEY = "6LffU-kSAAAAAAUjm3MlhFHDBZ6_09WM-B9n6VtE";
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String remoteIp = req.getParameter("remoteip");
		String challenge  = req.getParameter("challenge");
		String response = req.getParameter("response");
		
		ReCaptchaImpl recaptcha = new ReCaptchaImpl();
		recaptcha.setPrivateKey(PRIVATE_KEY);
		
		ReCaptchaResponse recaptchaResponse = recaptcha.checkAnswer(remoteIp, challenge, response);
		
		resp.setContentType("text/html");
		if(recaptchaResponse.isValid()){
			resp.getWriter().write("true");
		} else {
			resp.getWriter().write("false");
		}
		
	}
	
}
