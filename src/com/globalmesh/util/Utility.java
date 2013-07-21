package com.globalmesh.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.Properties;
import java.util.UUID;
import java.util.logging.Logger;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.datanucleus.query.evaluator.memory.GetClassMethodEvaluator;

@SuppressWarnings("rawtypes")
public class Utility {

	private static final String CONFIG_FILE = "noqWeb.properties";
		
	private static Properties CONFG = new Properties();
	
	static {
		
		try {
			//CONFG.load(new FileInputStream(CONFIG_FILE));
			getCONFG().load(Utility.class.getResourceAsStream(CONFIG_FILE));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void sendEmail(String subject, String message, String to,
			String from) {
		Properties props = new Properties();
		Session session = Session.getDefaultInstance(props, null);

		try {
			Message email = new MimeMessage(session);
			email.setFrom(new InternetAddress(from));
			email.addRecipient(Message.RecipientType.TO,
					new InternetAddress(to));
			email.setSubject(subject);
			email.setText(message);
			Transport.send(email);
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static String shortUUID() {
		UUID uuid = UUID.randomUUID();
		long l = ByteBuffer.wrap(uuid.toString().getBytes()).getLong();
		return Long.toString(l, Character.MAX_RADIX);
	}

	public static Properties getCONFG() {
		return CONFG;
	}

	public static void setCONFG(Properties cONFG) {
		CONFG = cONFG;
	}

}
