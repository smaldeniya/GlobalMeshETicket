package com.globalmesh.action.report;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.dto.Sale;
import com.globalmesh.util.OnlineSalesReportPrinter;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfWriter;
		

public class ReportRequestServlet extends HttpServlet {

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String fromDate = req.getParameter("reportFromDate");
		String toDate = req.getParameter("reportToDate");
		String reportType = req.getParameter("reqreportType");
		String hall = req.getParameter("reportHall");
		//int showNumber = Integer.parseInt(req.getParameter("reportShow"));
		
		MovieDetail movie = MovieDetailDAO.INSTANCE.getNowShowingMovie(hall);
		
//		int dateToday = Calendar.getInstance().get(Calendar.DAY_OF_WEEK);
//		Date showTime = null;
		
//		if(showNumber == 1 & movie.getMovieTime1() != null && movie.getMovieTime1().length > 0 ) {
//			showTime = movie.getMovieTime1()[dateToday];
//			
//		} else if(showNumber == 2 & movie.getMovieTime2() != null && movie.getMovieTime2().length > 0 ) {
//			showTime = movie.getMovieTime2()[dateToday];
//			
//		} else if(showNumber == 3 & movie.getMovieTime3() != null && movie.getMovieTime3().length > 0 ) {
//			showTime = movie.getMovieTime3()[dateToday];
//			
//		} else if(showNumber == 4 & movie.getMovieTime4() != null && movie.getMovieTime4().length > 0 ) {
//			showTime = movie.getMovieTime4()[dateToday];
//			
//		} else if(showNumber == 5 & movie.getMovieTime5() != null && movie.getMovieTime5().length > 0 ) {
//			showTime = movie.getMovieTime5()[dateToday];
//			
//		}
		
		
		resp.setContentType("application/pdf");	
		Rectangle pagesize = new Rectangle(PageSize.A4.rotate());
		Document report = new Document(pagesize);
		
		try {
			PdfWriter writer = PdfWriter.getInstance(report,resp.getOutputStream());
			report.open();
			List<Sale> sales = null;
						
			OnlineSalesReportPrinter.generateOnlineSalesReport(report, reportType, fromDate, toDate, movie);
			report.close();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}
