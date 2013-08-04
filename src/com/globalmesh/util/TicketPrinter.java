package com.globalmesh.util;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dto.Sale;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.VerticalPositionMark;
import com.itextpdf.text.Rectangle;

public class TicketPrinter {

	private static Font smallFont = new Font(FontFamily.TIMES_ROMAN, 8, Font.NORMAL);
	private static Font smallFontBold = new Font(FontFamily.TIMES_ROMAN, 8, Font.BOLD);
	private static Font midFont = new Font(FontFamily.TIMES_ROMAN, 10, Font.NORMAL);
	private static Font midFontBold = new Font(FontFamily.TIMES_ROMAN, 10, Font.BOLD);
	private static Font largeFont = new Font(FontFamily.TIMES_ROMAN, 14, Font.NORMAL);
	private static Font largeFontBold = new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD);	
	
	
	private static final SimpleDateFormat timeFormet = new SimpleDateFormat("hh:mm a");
	private static final SimpleDateFormat dateFomatter = new SimpleDateFormat("yyyy-MM-dd");
	
	public static Document printTicket(Sale sale, Document ticket, String movieName) {

		
		String[] seatNosArray = sale.getSeats().split(";");
		
		int loopCnt = 0;
		
		for (int halfTktCnt = 0; halfTktCnt < sale.getNumOfHalfTickets(); halfTktCnt++) {

			ticket.newPage();
			// Set Address top right
			setAddress(ticket);
			
			String seatNo = seatNosArray[loopCnt];
			
			printTicketBody(ticket, seatNo, (sale.getId() + " - " + loopCnt), sale,
					Constants.TicketTypes.Half, movieName);
			
			printTicketSummary(ticket, seatNo, (sale.getId() + " - " + loopCnt), sale,
					Constants.TicketTypes.Half, movieName);
			
			loopCnt++;
		}
		
		for (int fullTktCnt = 0; fullTktCnt < sale.getNumOfFullfTickets(); fullTktCnt++) {
			ticket.newPage();
			// Set Address top right
			setAddress(ticket);

			String seatNo = seatNosArray[loopCnt];
			
			printTicketBody(ticket, seatNo, (sale.getId() + " - " + loopCnt), sale,
					Constants.TicketTypes.Full, movieName);

			printTicketSummary(ticket, seatNo, (sale.getId() + " - " + loopCnt), sale,
					Constants.TicketTypes.Full, movieName);
			
			loopCnt++;
		}
		
		return ticket;
		
	}
	
	
	private static void printTicketSummary(Document document,
			String seatNo, String ticketNo, Sale sale,
			Constants.TicketTypes typeOfTicket, String movieName) {

		Paragraph para = null;

		try {	
			// creates tabs
						Chunk tab1 = new Chunk(new VerticalPositionMark(), 40, true);
						Chunk tab2 = new Chunk(new VerticalPositionMark(), 80, true);
						Chunk tab3 = new Chunk(new VerticalPositionMark(), 90, true);
			
			para = new Paragraph("",midFont);
			//para.add(tab1);
			para.add(String.format("Ticket No : %s", ticketNo));
			para.setAlignment(Element.ALIGN_RIGHT);
			document.add(para);

			para.add(tab1);
			para = new Paragraph(String.format("CINEMA : %s", sale.getHall()),
					midFontBold);
			para.setAlignment(Element.ALIGN_CENTER);
			document.add(para);

			
			para.add(tab1);
			para = new Paragraph("Date", smallFont);
			para.add(tab2);
			para.add(":");
			para.add(tab3);
			String showDate = dateFomatter.format(sale.getShowDate());
			para.add(showDate);
			para.setAlignment(Element.ALIGN_LEFT);
			document.add(para);

			para.add(tab1);
			para = new Paragraph("Show Time", smallFont);
			para.add(tab2);
			para.add(":");
			para.add(tab3);			
			para.add(timeFormet.format(sale.getShowDate()));
			para.setAlignment(Element.ALIGN_LEFT);
			document.add(para);

			para.add(tab1);
			para = new Paragraph("Show Title", smallFont);
			para.add(tab2);
			para.add(":");
			para.add(tab3);
			para.add(movieName);
			para.setAlignment(Element.ALIGN_LEFT);
			document.add(para);

			para.add(tab1);
			para = new Paragraph("Seat No", smallFont);
			para.add(tab2);
			para.add(":");
			para.add(tab3);
			para.add(seatNo);
			para.setAlignment(Element.ALIGN_LEFT);
			document.add(para);

			para.add(tab1);
			para = new Paragraph("Ticket Amount", smallFont);
			para.add(tab2);
			para.add(":");
			para.add(tab3);
			
			if (typeOfTicket == Constants.TicketTypes.Full)
				para.add(String.format("Rs. %.2f", sale.getFullTicketPrice()));

			if (typeOfTicket == Constants.TicketTypes.Half)
				para.add(String.format("Rs. %.2f", sale.getHalfTicketPrice()));

			para.setAlignment(Element.ALIGN_LEFT);
			document.add(para);
			
			
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	private static void setAddress(Document document) {

		Paragraph addrLine1 = new Paragraph("4th Floor, Majestic City,",
				smallFontBold);
		addrLine1.setAlignment(Element.ALIGN_RIGHT);

		Paragraph addrLine2 = new Paragraph("Bambalapitiya.", smallFontBold);
		addrLine2.setAlignment(Element.ALIGN_RIGHT);

		Paragraph telNoLine = new Paragraph("Tel: +94 11 2581 759", smallFontBold);
		telNoLine.setAlignment(Element.ALIGN_RIGHT);

		try {
			document.add(addrLine1);
			document.add(addrLine2);
			document.add(telNoLine);
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	private static void printTicketBody(Document document,
			String seatNo, String ticketNo, Sale sale,
			Constants.TicketTypes typeOfTicket, String movieName) {

		Paragraph para = null;

		try {
			para = new Paragraph(
					"---------------------------------------------------------------------",
					smallFont);
			para.setAlignment(Element.ALIGN_MIDDLE);
			document.add(para);

			para = new Paragraph(String.format("Ticket No : %s", ticketNo),
					midFont);
			para.setAlignment(Element.ALIGN_RIGHT);
			document.add(para);

			para = new Paragraph(String.format("CINEMA : %s", sale.getHall()),
					largeFontBold);
			para.setAlignment(Element.ALIGN_CENTER);
			document.add(para);

			document.add(Chunk.NEWLINE);

			// creates tabs
			Chunk tab1 = new Chunk(new VerticalPositionMark(), 70, true);
			Chunk tab2 = new Chunk(new VerticalPositionMark(), 80, true);

			para = new Paragraph("Date", midFontBold);
			para.add(tab1);
			para.add(":");
			para.add(tab2);
			String showDate = dateFomatter.format(sale.getShowDate());
			para.add(showDate);
			para.setAlignment(Element.ALIGN_LEFT);
			document.add(para);

			para = new Paragraph("Show Time", midFontBold);
			para.add(tab1);
			para.add(":");
			para.add(tab2);
			para.add(timeFormet.format(sale.getShowDate()));
			para.setAlignment(Element.ALIGN_LEFT);
			document.add(para);

			document.add(Chunk.NEWLINE);

			para = new Paragraph("Show Title", midFontBold);
			para.add(tab1);
			para.add(":");
			para.add(tab2);
			para.add(movieName);
			para.setAlignment(Element.ALIGN_LEFT);
			document.add(para);

			document.add(Chunk.NEWLINE);

			para = new Paragraph("Category", midFontBold);
			para.add(tab1);
			para.add(":");
			para.add(tab2);
			para.add("ODC");
			para.setAlignment(Element.ALIGN_LEFT);
			document.add(para);

			para = new Paragraph("Seat No", midFontBold);
			para.add(tab1);
			para.add(":");
			para.add(tab2);
			para.add(seatNo);
			para.setAlignment(Element.ALIGN_LEFT);
			document.add(para);

			para = new Paragraph("Type", midFontBold);
			para.add(tab1);
			para.add(":");
			para.add(tab2);

			if (typeOfTicket == Constants.TicketTypes.Full)
				para.add("Full");

			if (typeOfTicket == Constants.TicketTypes.Half)
				para.add("Half");

			if (typeOfTicket == Constants.TicketTypes.Service)
				para.add("Service");

			para.setAlignment(Element.ALIGN_LEFT);
			document.add(para);

			document.add(Chunk.NEWLINE);
				
			para = new Paragraph("Ticket Amount", midFontBold);
			para.add(tab1);
			para.add(":");
			para.add(tab2);
			
			if (typeOfTicket == Constants.TicketTypes.Full)
				para.add(String.format("Rs. %.2f", sale.getFullTicketPrice()));

			if (typeOfTicket == Constants.TicketTypes.Half)
				para.add(String.format("Rs. %.2f", sale.getHalfTicketPrice()));

			para.setAlignment(Element.ALIGN_LEFT);
			document.add(para);
			
			para = new Paragraph("Amount Paid", midFontBold);
			para.add(tab1);
			para.add(":");
			para.add(tab2);			
			para.add(String.format("Rs. %.2f", sale.getTotal()));
			
			para.setAlignment(Element.ALIGN_LEFT);
			document.add(para);
			
			para = new Paragraph("Balance", midFontBold);
			para.add(tab1);
			para.add(":");
			para.add(tab2);
			para.add(String.format("Rs. %s", "0.00"));

			para.setAlignment(Element.ALIGN_LEFT);
			document.add(para);
			
			para = new Paragraph(
					"---------------------------------------------------------------------",
					smallFont);
			para.setAlignment(Element.ALIGN_MIDDLE);
			document.add(para);
			
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
