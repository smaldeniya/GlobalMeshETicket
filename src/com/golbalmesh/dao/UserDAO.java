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

	//Creates an instance
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
			
			try
			{
				
				EntityManager em = EMFService.get().createEntityManager();
				em.getTransaction().begin();
				em.persist(user);
				em.getTransaction().commit();
				em.close();
			}
			catch(Exception e)
			{
				e.printStackTrace();
				
			}
			
		}
	}

	public User getUserById(String userId)  throws Exception{
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("select t from User t");
				//.createQuery("select t from User t where t.userId = :userId");
		//q.setParameter("userId", userId);		
		User user = (User)q.getResultList().get(0);
		return user;
	}

	public void remove(String userId)  throws Exception{
		EntityManager em = EMFService.get().createEntityManager();
		try {
			User user = em.find(User.class, userId);
			em.getTransaction().begin();
			em.remove(user);
			em.getTransaction().commit();
		} finally {
			em.close();
		}
	}
}
