/**
 * 
 */
package com.globalmesh.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import com.globalmesh.dto.MovieDetail;
import com.globalmesh.util.Constants;
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

	public boolean addMovieDetail(MovieDetail movieDetail) {	

		boolean isAddScuccess = false;
		
		synchronized (this) {
			try {

				EntityManager em = EMFService.get().createEntityManager();
				em.getTransaction().begin();
				em.persist(movieDetail);
				em.getTransaction().commit();
				isAddScuccess = true;
								
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return isAddScuccess;
	}

	public boolean updateMovieDetail(MovieDetail movie){
		boolean isUpdateSuccess = false;
		
		synchronized (this) {			
			try
			{				
				EntityManager em = EMFService.get().createEntityManager();								
				em.getTransaction().begin();
				em.merge(movie);
				em.getTransaction().commit();
				
				
				isUpdateSuccess = true;
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
	
		}
		
		return isUpdateSuccess;
	}
	
	public MovieDetail getMovieById(String movieId) {
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("select t from MovieDetail t where t.movieId = :movieId");
		q.setParameter("movieId", movieId);
		MovieDetail movieDetail = null;
		try {
			movieDetail = (MovieDetail) q.getResultList().get(0);
		} catch (IndexOutOfBoundsException e) {
		}
		
		return movieDetail;
	}
	
	public MovieDetail getNowShowingMovie(String hallId) {
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("select t from MovieDetail t where t.movieTheatre = :movieTheatre AND t.status = :status");
		q.setParameter("movieTheatre", hallId);
		q.setParameter("status", Constants.MovieStatus.NowShowing);
		MovieDetail movieDetail = null;
		try {
			movieDetail = (MovieDetail) q.getResultList().get(0);
		} catch (IndexOutOfBoundsException e) {
		}
		
		return movieDetail;
	}


	public void remove(long movieId) throws Exception {
		
		EntityManager em = EMFService.get().createEntityManager();
		try {
			MovieDetail movieDetail = em.find(MovieDetail.class, movieId);
			em.getTransaction().begin();
			em.remove(movieDetail);
			em.getTransaction().commit();
		} finally {
			
		}
	}
}
