/**
 * 
 */
package com.globalmesh.dao;

import java.util.ArrayList;
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
		List<MovieDetail> returnList = new ArrayList<MovieDetail>();
		for (MovieDetail movieDetail : movieDetails) {
			returnList.add(movieDetail);
		}
		em.close();
		return movieDetails;
	}

	public boolean addMovieDetail(MovieDetail movieDetail) {	

		boolean isAddScuccess = false;
		EntityManager em = EMFService.get().createEntityManager();
		
		synchronized (this) {
			try {
			
				em.getTransaction().begin();
				em.persist(movieDetail);
				em.getTransaction().commit();
				isAddScuccess = true;
								
			} catch (Exception e) {
				e.printStackTrace();
			} finally{
				em.close();
			}

		}

		return isAddScuccess;
	}

	public boolean updateMovieDetail(MovieDetail movie){
		boolean isUpdateSuccess = false;
		
		synchronized (this) {		
			EntityManager em = EMFService.get().createEntityManager();
			try
			{				
												
				em.getTransaction().begin();
				em.merge(movie);
				em.getTransaction().commit();
				
				
				isUpdateSuccess = true;
			}
			catch(Exception e)
			{
				e.printStackTrace();
			} finally {
				em.close();
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
		em.close();
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
		em.close();
		return movieDetail;
	}
	
	public List<MovieDetail> listNowShowingMovies() {
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("select t from MovieDetail t where t.status = :status");
		q.setParameter("status", Constants.MovieStatus.NowShowing);
		
		List<MovieDetail> movieList = q.getResultList();
		List<MovieDetail> returnList = new ArrayList<MovieDetail>();
		
		for (MovieDetail movieDetail : movieList) {
			returnList.add(movieDetail);
		}
		em.close();
		return returnList;
	}
	
	public List<String> listNowShowingMovieHalls() {
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("select t from MovieDetail t where t.status = :status");
		q.setParameter("status", Constants.MovieStatus.NowShowing);
		
		List<MovieDetail> hallList = q.getResultList();
		List<String> returnList = new ArrayList<String>();
		
		for (MovieDetail movieDetail : hallList) {
			returnList.add(movieDetail.getMovieTheatre());
		}
		em.close();
		return returnList;
	}


	public void remove(long movieId) throws Exception {
		
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
	
	public List<MovieDetail> listNowShowingAndCommingSoonMovies() {
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("select t from MovieDetail t where t.status <> :status");
		q.setParameter("status", Constants.MovieStatus.Shown);
		
		List<MovieDetail> movieList = q.getResultList();
		List<MovieDetail> returnList = new ArrayList<MovieDetail>();
		
		for (MovieDetail movieDetail : movieList) {
			returnList.add(movieDetail);
		}
		em.close();
		return returnList;
	}
	
	public MovieDetail searchMovie(String pattern) {
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("Select m from MovieDetail m where m.movieName LIKE '" + pattern + "%'");
		MovieDetail movie = null;
		try {
			movie = (MovieDetail) q.getResultList().get(0);
		} catch (IndexOutOfBoundsException e) {
			// TODO: handle exception
		}
		em.close();
		return movie;
	}
	
}
