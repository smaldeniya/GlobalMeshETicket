/**
 * 
 */
package com.globalmesh.util;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * @author Dil
 *
 */
public class EMFService {

	private static final EntityManagerFactory emfInstance = Persistence
		      .createEntityManagerFactory("transactions-optional");

	private EMFService() {
	}
	
	public static EntityManagerFactory get() {
		return emfInstance;
	}	
}
