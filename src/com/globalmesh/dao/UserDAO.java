/**
 * 
 */
package com.globalmesh.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import com.globalmesh.dto.User;
import com.globalmesh.util.EMFService;

/**
 * @author Dil
 * 
 */

public enum UserDAO {

	//Creates an instance
	INSTANCE;

	public List<User> listUsers() throws Exception{
		EntityManager em = EMFService.get().createEntityManager();
		// Read the existing entries
		Query q = em.createQuery("select u from User u");
		@SuppressWarnings("unchecked")
		List<User> users = q.getResultList();
		List<User> returnList = new ArrayList<User>();
		for (User user : users) {
			returnList.add(user);
		}
		em.close();
		return returnList;
	}

	public boolean add(User user)  throws Exception{
		boolean isRegistered = false;
		
		synchronized (this) {			
			EntityManager em = EMFService.get().createEntityManager();
			try
			{
				
				em.getTransaction().begin();
				em.persist(user);
				em.getTransaction().commit();
				
				
				isRegistered = true;
			}
			catch(Exception e)
			{
				
			}
			em.close();
		}
		
		return isRegistered;
	}

	public User getUserById(String userId){
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("select t from User t where t.userId = :userId");
		q.setParameter("userId", userId);		
		User user;
		try {
			user = (User) q.getResultList().get(0);
		} catch (IndexOutOfBoundsException e) {
			user = null;
		}
		em.close();
		return user;
	}
	
	public User getUserByEmail(String email){
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("select t from User t where t.email = :email");
		q.setParameter("email", email);		
		
		User user = null;
		
		try {
			user = (User)q.getResultList().get(0);
		} catch (IndexOutOfBoundsException e) {
			user = null;
		}	
		em.close();
		return user;
	}
	
	public User getUserByVeriCode(String verificationCode){
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("select t from User t where t.verified = :verified");
		q.setParameter("verified", verificationCode);		
		User user;
		try {
			user = (User) q.getResultList().get(0);
		} catch (IndexOutOfBoundsException e) {
			user = null;
		}
		em.close();
		return user;
	}

	public void remove(String userId) {
		EntityManager em = EMFService.get().createEntityManager();
		try {
			User user = em.find(User.class, userId);
			em.getTransaction().begin();
			em.remove(user);
			em.getTransaction().commit();
		} finally {
		
		}
		em.close();
	}
	
	public boolean update(User user){
		boolean isUpdateSuccess = false;
		
		synchronized (this) {
			EntityManager em = EMFService.get().createEntityManager();
			try
			{				
												
				em.getTransaction().begin();
				em.merge(user);
				em.getTransaction().commit();
				
				isUpdateSuccess = true;
			}
			catch(Exception e)
			{
			
			}
			em.close();
		}
		
		return isUpdateSuccess;
	}
}
