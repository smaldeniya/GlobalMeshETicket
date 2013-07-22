package com.globalmesh.dao;

import javax.persistence.EntityManager;

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
			em.close();
		}

		return isSuccess;
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
