package com.globalmesh.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import com.globalmesh.dto.Hall;
import com.globalmesh.dto.User;
import com.globalmesh.util.EMFService;

public enum HallDAO {

	INSTANCE;
	
	public List<Hall> listHalls(){
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("Select h from Hall h");
		
		List<Hall> hallList = q.getResultList();
		em.close();
		return hallList;
	}
	
	public Hall getHallById(String hallId){
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("select h from Hall h where h.hallId = :hallId");
		q.setParameter("hallId", hallId);		
		Hall hall;
		try {
			hall = (Hall) q.getResultList().get(0);
		} catch (IndexOutOfBoundsException e) {
			hall = null;
		}
		em.close();
		return hall;
	}
	
	public boolean addHall(Hall hall){
		boolean isSuccess = false;
		
		synchronized (this) {
			EntityManager em = EMFService.get().createEntityManager();
			try {
				
				em.getTransaction().begin();
				em.persist(hall);
				em.getTransaction().commit();
				isSuccess = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				em.close();
			}
			
		}
		
		return isSuccess;
	}
	
	public boolean removeHall(String hallId) {
		boolean isSuccess = false;
		
		synchronized (this) {
			EntityManager em = EMFService.get().createEntityManager();
			try {
				
				Hall h = em.find(Hall.class, hallId);
				em.getTransaction().begin();
				em.remove(h);
				em.getTransaction().commit();
				
				isSuccess = true;
			} catch (Exception e) {
				e.printStackTrace();
			}  finally {
				em.close();
			}
		}
		
		return isSuccess;
	}
	
	public boolean updateHall(Hall h) {
		boolean isSuccess = false;
		
		synchronized (this) {
			EntityManager em = EMFService.get().createEntityManager();
			
			em.getTransaction().begin();
			em.merge(h);
			em.getTransaction().commit();
			em.close();
			
			isSuccess = true;
		}
		
		return isSuccess;
	}
	
}
