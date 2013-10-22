package com.globalmesh.util;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.globalmesh.dao.SaleDAO;
import com.globalmesh.dao.UserDAO;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.dto.Sale;
import com.globalmesh.dto.User;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.draw.VerticalPositionMark;

public class OnlineSalesReportPrinter {

	private static Font font = new Font(FontFamily.TIMES_ROMAN, 10, Font.NORMAL);
	private static Font fontBold = new Font(FontFamily.TIMES_ROMAN, 10, Font.BOLD);
	
	public static void generateOnlineSalesReport(Document document, String type, String fromDate, String toDate	, MovieDetail movie) throws ParseException{
		
		DateFormat showFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date from = showFormat.parse(fromDate);
		Date to = showFormat.parse(toDate);
		
		DateFormat showTimeFormat = new SimpleDateFormat("hh:mm a");
		
		List<Sale> saleList = SaleDAO.INSTANCE.listSalesFromTO(from, to, type, movie.getMovieId());
		
		if(saleList.size() > 0){
			Sale sale = saleList.get(0);
			
			printHeaderInfo( document, fromDate, toDate, movie, showTimeFormat.format(sale.getShowDate()));
			
			printSummaryTbl( document, saleList);
			
			printReportBody( document, saleList);
		}
		
	}
	
	private static void printHeaderInfo(Document document, String from, String to, MovieDetail movie, String showTime) {
		
		Paragraph para = new Paragraph( String.format("%s - %s | %s | %s - %s", from, to, showTime, movie.getMovieName(), movie.getMovieTheatre()) , font);
		para.setAlignment(Element.ALIGN_LEFT);
		try {
			document.add(para);
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private static void printSummaryTbl(Document document, List<Sale> saleList) {

		int noOfFullTickets = 0;		
		int noOfHalfTickets = 0;
		
		double fullTicketTotal = 0.00;
		double halfTicketTotal = 0.00;
		
		for (Sale sale : saleList) {
			noOfFullTickets += sale.getNumOfFullfTickets();
			noOfHalfTickets += sale.getNumOfHalfTickets();
			fullTicketTotal += (sale.getNumOfFullfTickets() * sale.getFullTicketPrice());
			halfTicketTotal += (sale.getNumOfHalfTickets() * sale.getHalfTicketPrice());
		}
		
		// creates tabs
		Chunk tab1 = new Chunk(new VerticalPositionMark(), 400, true);
		Chunk tab2 = new Chunk(new VerticalPositionMark(), 500, true);
		Chunk tab3 = new Chunk(new VerticalPositionMark(), 600, true);
		
		Paragraph para = null;

		try {
			document.add(Chunk.NEWLINE);
			
			para = new Paragraph("", font);
			para.add(tab1);
			para.add("Full");
			para.add(tab2);
			para.add("Half");
			para.add(tab3);
			para.add("Total");
			document.add(para);
			
			para = new Paragraph("", font);
			para.add("No of Tickets");
			para.add(tab1);
			para.add(String.format("%s", noOfFullTickets));
			para.add(tab2);
			para.add(String.format("%s", noOfHalfTickets));
			para.add(tab3);
			para.add(String.format("%s", noOfFullTickets + noOfHalfTickets));
			document.add(para);
			
			para = new Paragraph("", font);
			para.add("Price of Tickets");
			para.add(tab1);
			para.add(String.format("Rs. %.2f",  fullTicketTotal));
			para.add(tab2);
			para.add(String.format("Rs. %.2f", halfTicketTotal));
			para.add(tab3);
			para.add(String.format("Rs. %.2f", fullTicketTotal + halfTicketTotal));
			document.add(para);
			
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
private static void printReportBody(Document document, List<Sale> salesList){
		
		// creates tabs				
				Chunk tab1 = new Chunk(new VerticalPositionMark(), 30, true);//no - refcode
				Chunk tab2 = new Chunk(new VerticalPositionMark(), 100, true);//refcode - fullname
				Chunk tab3 = new Chunk(new VerticalPositionMark(), 200, true);//fullname - nic
				Chunk tab4 = new Chunk(new VerticalPositionMark(), 270, true);//nic - seats
				Chunk tab5 = new Chunk(new VerticalPositionMark(), 480, true);//seats - totalseats
				Chunk tab6 = new Chunk(new VerticalPositionMark(), 540, true);//totalseats - totalrs
				Chunk tab7 = new Chunk(new VerticalPositionMark(), 600, true);//totalrs - bookedby
				Chunk tab8 = new Chunk(new VerticalPositionMark(), 670, true);//bookedby - transactionDate
				
				Paragraph para = null;

				try {
					document.add(Chunk.NEWLINE);
					
					para = new Paragraph("", fontBold);					
					para.add("No");
					para.add(tab1);
					para.add("Ref Code");
					para.add(tab2);
					para.add("Full Name");
					para.add(tab3);
					para.add("NIC/Passport");
					para.add(tab4);
					para.add("Seats List");
					para.add(tab5);
					para.add("Total Seats");
					para.add(tab6);
					para.add("Total (Rs.)");
					para.add(tab7);
					para.add("Booking Method");
					para.add(tab8);
					para.add("Transaction Date");
					document.add(para);
					
					document.add(Chunk.NEWLINE);
					
					for(int ticketCnt = 1; ticketCnt <= salesList.size(); ticketCnt++){
						
						Sale saleRecord = salesList.get(ticketCnt - 1);
						
						para = new Paragraph("", font);					
						para.add(String.format("%s", ticketCnt));
						para.add(tab1);
						para.add(String.format("%s", saleRecord.getId()));
						para.add(tab2);
						
						User user = UserDAO.INSTANCE.getUserById(saleRecord.getUserId());
						
						para.add(String.format("%s %s", user.getFirstName(), user.getLastName()));
						para.add(tab3);
						para.add(String.format("%s", user.getUserId()));
						para.add(tab4);
						para.add(String.format("%s", saleRecord.getSeats()));
						para.add(tab5);
						para.add(String.format("%s", saleRecord.getSeatCount()));
						para.add(tab6);
						para.add(String.format("%s", String.format("%.2f", saleRecord.getTotal())));
						para.add(tab7);
						para.add(String.format("%s", (saleRecord.isOnline()?"Online":"Offline")));
						para.add(tab8);						
						SimpleDateFormat dateFomatter = new SimpleDateFormat("yyyy-MM-dd HH:mm a");
						String tnxDate = dateFomatter.format(saleRecord.getTransactionDate());						
						para.add(String.format("%s", tnxDate));
						document.add(para);
					}
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	}
	
}
