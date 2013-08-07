package com.globalmesh.util;

import java.security.SecureRandom;

public class RandomKeyGen {

	
	private final static char[] idchars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".toCharArray();
	private final static int len = 10;
	
	
	public static String createId() {
	    char[] id = new char[len];
	    SecureRandom r = new SecureRandom();
	    for (int i = 0;  i < len;  i++) {
	        id[i] = idchars[r.nextInt(idchars.length)];
	    }
	    return new String(id);
	}
	
}
