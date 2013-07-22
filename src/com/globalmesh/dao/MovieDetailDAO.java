/**
 * 
 */
package com.globalmesh.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import com.globalmesh.dto.MovieDetail;
import com.globalmesh.dto.User;
import com.globalmesh.util.EMFService;

/**
 * @author Dil
 * 
 */
public enum MovieDetailDAO {

	// Creates an instance
	INSTANCE;

	public List<MovieDetail> listMovies() throws Exception {
		EntityManager em = EMFService.get().createEntityManager();
		// Read the existing entries
		Query q = em.createQuery("select m from MovieDetail m");
		@SuppressWarnings("unchecked")
		List<MovieDetail> movieDetails = q.getResultList();
		return movieDetails;
	}

	public boolean addMovieDetail(MovieDetail movieDetail) throws Exception {	

		boolean isAddScuccess = false;
		
		synchronized (this) {
			try {

				EntityManager em = EMFService.get().createEntityManager();
				em.getTransaction().begin();
				em.persist(movieDetail);
				em.getTransaction().commit();
				isAddScuccess = true;
				em.close();				
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return isAddScuccess;
	}

	public MovieDetail getMovieById(int movieId) throws Exception {
		EntityManager em = EMFService.get().createEntityManager();
		Query q = null;//em.createQuery("select t from User t");
		//q.createQuery("select t from User t where t.userId = :userId");
		// q.setParameter("userId", userId);
		MovieDetail movieDetail = (MovieDetail) q.getResultList().get(0);
		return movieDetail;
	}


	public void remove(int movieId) throws Exception {
		
		EntityManager em = EMFService.get().createEntityManager();
		try {
			MovieDetail movieDetail = em.find(MovieDetail.class, movieId);
			em.getTransaction().begin();
			em.remove(movieDetail);
			em.getTransaction().commit();
		} finally {
			em.close();
		}
	}
}
