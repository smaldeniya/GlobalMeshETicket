package com.globalmesh.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TemporalType;

import com.globalmesh.dto.Hall;
import com.globalmesh.dto.Sale;
import com.globalmesh.util.EMFService;

public enum SaleDAO {

	INSTANCE;

	public boolean insertSale(Sale sale) {
		boolean isSuccess = false;

		synchronized (this) {
			EntityManager em = EMFService.get().createEntityManager();
			try {
				em.getTransaction().begin();
				em.persist(sale);
				em.getTransaction().commit();
				isSuccess = true;
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		}

		return isSuccess;
	}

	public List<Sale> listSales(){
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("Select s from  Sale s");
		
		List<Sale> saleList = q.getResultList();
		
		return saleList;
	}
	
	public List<Sale> listSalesByDate(Date date){
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("Select s from  Sale s where s.showDate =: showDates");
		q.setParameter("showDate", date);
		
		List<Sale> saleList = q.getResultList();		
		return saleList;
	}
	
	public List<Sale> listSalesByDateAndHall(Date date, Hall h){
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("Select s from  Sale s where s.hall= :hall and s.showDate= :showDate");
		q.setParameter("hall", h.getHallId());
		q.setParameter("showDate", date);
		List<Sale> saleList = q.getResultList();	
		
		List<Sale> returnList = new ArrayList<Sale>();
		for (Sale sale : saleList) {
			returnList.add(sale);
		}
		return returnList;
	}
	
	
	/**
	 * Query that will fetch a lazy relationship Be carefull, with this kind of
	 * query only those who have the relationship will come in the result
	 */
	/*private static Person findPersonByNameWithAllDogs(EntityManager em, String name) {
		  Query query = em.createQuery('select p from Person p join fetch p.dogs where p.name = :name', Person.class);
		  query.setParameter('name', name);
		  return (Person) query.getSingleResult();
	}*/
}
