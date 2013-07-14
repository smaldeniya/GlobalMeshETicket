/**
 * 
 */
package com.golbalmesh.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import com.golbalmesh.dto.User;
import com.golbalmesh.util.EMFService;

/**
 * @author Dil
 * 
 */
public enum UserDAO {

	INSTANCE;

	public List<User> listUsers() throws Exception{
		EntityManager em = EMFService.get().createEntityManager();
		// Read the existing entries
		Query q = em.createQuery("select u from User u");
		@SuppressWarnings("unchecked")
		List<User> todos = q.getResultList();
		return todos;
	}

	public void add(User user)  throws Exception{
		synchronized (this) {
			EntityManager em = EMFService.get().createEntityManager();
			em.persist(user);
			em.close();
		}
	}

	public User getUserById(String userId)  throws Exception{
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em
				.createQuery("select t from User t where t.userId = :userId");
		q.setParameter("userId", userId);		
		User user = (User)q.getResultList().get(0);
		return user;
	}

	public void remove(String userId)  throws Exception{
		EntityManager em = EMFService.get().createEntityManager();
		try {
			User user = em.find(User.class, userId);
			em.remove(user);
		} finally {
			em.close();
		}
	}
}
