package com.globalmesh.dao;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TemporalType;

import com.globalmesh.dto.Hall;
import com.globalmesh.dto.Sale;
import com.globalmesh.dto.User;
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
				em.close();
			}
			
		}

		return isSuccess;
	}

	public List<Sale> listSales(){
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("Select s from  Sale s");
		
		List<Sale> saleList = q.getResultList();
		List<Sale> returnList = new ArrayList<Sale>();
		for (Sale sale : saleList) {
			returnList.add(sale);
		}
		em.close();
		return returnList;
	}
	
	public List<Sale> listSalesByDate(Date date){
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("Select s from  Sale s where s.showDate =: showDates");
		q.setParameter("showDate", date);
		
		List<Sale> saleList = q.getResultList();
		List<Sale> returnList = new ArrayList<Sale>();
		for (Sale sale : saleList) {
			returnList.add(sale);
		}
		em.close();
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
		em.close();
		return returnList;
	}
	
	public Sale getSaleById(String saleId) {
		
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("select t from Sale t where t.id = :id");
		q.setParameter("id", saleId);		
		Sale sale;
		try {
			sale = (Sale) q.getResultList().get(0);
		} catch (IndexOutOfBoundsException e) {
			em.close();
			sale = null;
		}
		
		return sale;
		
	}
	
	public List<Sale> listSalesFromTO(Date from, Date to, String type , String movie, Date showTime){
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("Select s from  Sale s where s.online=:type and s.movie=:movie and s.showDate between :fromDate and :toDate ");
		
		if(type.compareTo("all") == 0) {
			// no sales type hence query changed
			q = em.createQuery("Select s from  Sale s where s.movie=:movie and s.showDate between :fromDate and :toDate ");
			
		} else if(type.compareTo("online") == 0 ) {
			
			q.setParameter("type", true);
			
		} else if(type.compareTo("offline") == 0 ){
			
			q.setParameter("type", false);
			
		} else {
			throw new RuntimeException("report type should be all, online or offline. You send " + type);
		}
		
		q.setParameter("movie", movie);
		q.setParameter("fromDate", from);
		q.setParameter("toDate", to);
		
		List<Sale> saleList = q.getResultList();		
		List<Sale> returnList = new ArrayList<Sale>();
		DateFormat showTimeFormat = new SimpleDateFormat("hh:mm a");
		
		for (Sale sale : saleList) {
			if(showTimeFormat.format(sale.getShowDate()).compareTo(showTimeFormat.format(showTime)) == 0)
				returnList.add(sale);
		} 
		em.close();
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
