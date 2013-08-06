package com.globalmesh.util;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

public class TemperySaleHolder {

	private static final Map<String,String> ticketBlocker = new HashMap<String, String>();
	
	public static boolean notHas(String key) { // return true if use
		if(ticketBlocker.get(key) == null){
			return true;
		} else {
			return false;
		}
	} 
	
	public static boolean compare(String key, String userEmail) { // ruturn true if sale entry is belong to user
		if(ticketBlocker.get(key) != null ) {
			return (ticketBlocker.get(key).compareTo(userEmail) == 0);
		}
		return false;
	}
	
	public static boolean add(String key, String userEmail) {
		if(notHas(key)) {
			return ticketBlocker.put(key, userEmail) == null;
		} else {
			return false;
		}
	}
	
	public static boolean remove(String key, String userEmail) {
		if(compare(key, userEmail)){
			return (ticketBlocker.remove(key).compareTo(userEmail) == 0 );
		} else {
			return false;
		}
	}
	
	public static void removeBySeat(String seat, String userEmail) {
		Set<String> key = ticketBlocker.keySet();
		
		for (String string : key) {
			if(string.contains(seat)) {
				remove(string, userEmail);
				return;
			}
		}
	}
	
}
