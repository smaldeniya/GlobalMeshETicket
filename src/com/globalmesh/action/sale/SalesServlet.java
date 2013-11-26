package com.globalmesh.action.sale;

import java.io.IOException;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.globalmesh.dao.HallDAO;
import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dao.SaleDAO;
import com.globalmesh.dao.UserDAO;
import com.globalmesh.dto.Hall;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.dto.Sale;
import com.globalmesh.dto.User;
import com.globalmesh.util.Constants;
import com.globalmesh.util.RandomKeyGen;
import com.globalmesh.util.TicketPrinter;
import com.globalmesh.util.Utility;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfWriter;

public class SalesServlet extends HttpServlet {
	
	private static final Logger log = Logger.getLogger(SalesServlet.class.getName());
	 
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String userEmail = (String) req.getSession().getAttribute("email");
		log.info("Inside sales servlet. Initiate sales.");
		
		if(userEmail == null) {
			req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
			req.setAttribute("message", Utility.getCONFG().getProperty(Constants.LOGIN_NEED_MESSAGE));
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			
		} else {
			String hallName = Utility.chooseHall(req.getParameter("hallName"));
			String showDate = req.getParameter("showDate");
			String showTime = req.getParameter("showTime");
			int numOfHalfTickets = Integer.parseInt(req.getParameter("halfTicket"));
			int seatCount = Integer.parseInt(req.getParameter("seatCount"));
			String seatSelection = req.getParameter("seatSelection");			
			
			DateFormat showFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm a");
			try {
				Calendar show = Calendar.getInstance();
				show.setTime(showFormat.parse(showDate + " " + showTime));

				User u = UserDAO.INSTANCE.getUserByEmail(userEmail);
				Hall h = HallDAO.INSTANCE.getHallById(hallName);
				MovieDetail movie = MovieDetailDAO.INSTANCE.getNowShowingMovie(h.getHallId());
					
				Sale sale = new Sale();
				sale.setUserId(u.getUserId());
				sale.setHall(h.getHallId());
				sale.setMovie(movie.getMovieId());
				sale.setSeatCount(seatCount);
				sale.setNumOfHalfTickets(numOfHalfTickets);
				sale.setSeats(seatSelection);
				sale.setId(Utility.shortUUID());
				
				//if hall is 3D add the 3D price to the ticket price.
				
				if(h.isThreeD()){
					sale.setFullTicketPrice(h.getOdcFull() + h.getPrice3D());
					sale.setHalfTicketPrice(h.getOdcHalf() + h.getPrice3D());
				} else {
					sale.setFullTicketPrice(h.getOdcFull());					
					sale.setHalfTicketPrice(h.getOdcHalf());
				}
					
				int numOfFullTickets = (seatCount - numOfHalfTickets);					
				sale.setNumOfFullfTickets(numOfFullTickets);
					
				double total = numOfFullTickets * h.getOdcFull() + numOfHalfTickets * h.getOdcHalf();					
				sale.setTotal(total);
					
				sale.setShowDate(show.getTime());
				sale.setTransactionDate(Calendar.getInstance().getTime());
				Calendar today = Calendar.getInstance();
				
				if(u.getUserType().compareTo(Utility.getCONFG().getProperty(Constants.USER_TYPE_ADMIN)) == 0) {
					
					sale.setPaid(true);
					sale.setOnline(false);
					sale.setRedeem(true);
					sale.setVeriFicationCode("NONE");
					
					if(today.before(show)){					
						if(SaleDAO.INSTANCE.insertSale(sale)){
							
							resp.setContentType("application/pdf");
							Rectangle pagesize = new Rectangle(Utility.mmToPt(78), Utility.mmToPt(158));	
							
							Document ticket = new Document(pagesize, Utility.mmToPt(5), Utility.mmToPt(5),
									Utility.mmToPt(5), Utility.mmToPt(5)); 
							
							try {
								
								PdfWriter writer = PdfWriter.getInstance(ticket, resp.getOutputStream());
								ticket.open();
								TicketPrinter.printTicket(sale, ticket, movie.getMovieName());
								ticket.close();
								
							} catch (DocumentException e) {
								/*req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
								req.setAttribute("message",Utility.getCONFG().getProperty(Constants.SALE_FAIL));
								req.getRequestDispatcher("/messages.jsp").forward(req, resp);*/
							}							
							
						} else {
							req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
							req.setAttribute("message",Utility.getCONFG().getProperty(Constants.SALE_FAIL));
							req.getRequestDispatcher("/messages.jsp").forward(req, resp);
						}
					} else {
						req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
						req.setAttribute("message", Utility.getCONFG().getProperty(Constants.DATE_EXCEED));
						req.getRequestDispatcher("/messages.jsp").forward(req, resp);
					}
						
				} else {
					
					today.add(Calendar.MINUTE, 40);
					/**
					 * Add 40 minutes to current time and check whether this new time is before the show time.
					 */
						
					if(today.before(show)){
						
						sale.setOnline(true);
						sale.setRedeem(false);
						
						String verificationCode = RandomKeyGen.createId();
						sale.setVeriFicationCode(verificationCode);
						sale.setPaid(false);
						
						HttpSession session = req.getSession();
						Sale oldSale = (Sale) session.getAttribute("sale");
						
						if(oldSale == null) {
														
							//payment gateway related fields set to table values should move to config file
							Map<String, String> paymentGVal = new HashMap<String, String>();
							
							paymentGVal.put("Title", Utility.getCONFG().getProperty(Constants.PAYMENT_TITLE));
							paymentGVal.put("virtualPaymentClientURL", Utility.getCONFG().getProperty(Constants.PAYMENT_VPC_LOCATION));
							paymentGVal.put("vpc_Version", Utility.getCONFG().getProperty(Constants.PAYMENT_VPC_VERSION));
							paymentGVal.put("vpc_Command", Utility.getCONFG().getProperty(Constants.PAYMENT_VPC_COMMAND));
							paymentGVal.put("vpc_AccessCode", Utility.getCONFG().getProperty(Constants.PAYMENT_VPC_ACCESS_CODE));
							paymentGVal.put("vpc_MerchTxnRef", sale.getId());
							paymentGVal.put("vpc_Merchant", Utility.getCONFG().getProperty(Constants.PAYMENT_VPC_MERCHANT));							
							paymentGVal.put("vpc_OrderInfo", sale.getId());
							int totalCents = (int) sale.getTotal() * 100;
							paymentGVal.put("vpc_Amount", Integer.toString(totalCents));
							paymentGVal.put("vpc_ReturnURL", Utility.getCONFG().getProperty(Constants.PAYMENT_RETURN_URL));
							paymentGVal.put("vpc_Locale", Utility.getCONFG().getProperty(Constants.PAYMENT_LOCALE));
							/**
							 * Sale id is null at the moment because this is not persisted. So the unique value will be sale detail
							 **/
							paymentGVal.put("vpc_TicketNo", sale.getId());
							
							session.setAttribute("sale", sale);
							req.setAttribute("payMap", paymentGVal);
							log.info("End of sales servlet. Dispatching request to /pdetail.do");
							
							String bankURL = processRequest(paymentGVal, req.getHeader("Referer"));
							resp.sendRedirect(bankURL); // pdetial = vpc-do jsp file
							return;
							
							//TODO payment gateway send verification code to user
							//req.getRequestDispatcher("/afterP.do").forward(req, resp); 
						} else {
							//do what ever with old sale object that does not persisted.							
							req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
							req.setAttribute("message",Utility.getCONFG().getProperty(Constants.SALE_FAIL));
							req.getRequestDispatcher("/messages.jsp").forward(req, resp);

						}
						
							
					} else {
						req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
						req.setAttribute("message", Utility.getCONFG().getProperty(Constants.DATE_EXCEED));
						req.getRequestDispatcher("/messages.jsp").forward(req, resp);
					}
				}
					
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
			
			
		}	
		
	}

	static final String SECURE_SECRET = "6A92740F77EFF1C21DFF9281EC53C519";
	static final char[] HEX_TABLE = new char[] {
        '0', '1', '2', '3', '4', '5', '6', '7',
        '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
	
String hashAllFields(Map fields) {
        
        // create a list and sort it
        List fieldNames = new ArrayList(fields.keySet());
        Collections.sort(fieldNames);
        
        // create a buffer for the md5 input and add the secure secret first
        StringBuffer buf = new StringBuffer();
        buf.append(SECURE_SECRET);
        
        // iterate through the list and add the remaining field values
        Iterator itr = fieldNames.iterator();
        
		while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) fields.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                buf.append(fieldValue);
            }
 	    }
             
        MessageDigest md5 = null;
        byte[] ba = null;
        
        // create the md5 hash and UTF-8 encode it
        try {
            md5 = MessageDigest.getInstance("MD5");
            ba = md5.digest(buf.toString().getBytes("UTF-8"));
         } catch (Exception e) {} // wont happen
       
        //return buf.toString();
        return hex(ba);
    
	}
	
	static String hex(byte[] input) {
	    // create a StringBuffer 2x the size of the hash array
	    StringBuffer sb = new StringBuffer(input.length * 2);
	
	    // retrieve the byte array data, convert it to hex
	    // and add it to the StringBuffer
	    for (int i = 0; i < input.length; i++) {
	        sb.append(HEX_TABLE[(input[i] >> 4) & 0xf]);
	        sb.append(HEX_TABLE[input[i] & 0xf]);
	    }
	    return sb.toString();
	}

	void appendQueryFields(StringBuffer buf, Map fields) {
        
        // create a list
        List fieldNames = new ArrayList(fields.keySet());
        Iterator itr = fieldNames.iterator();
        
        // move through the list and create a series of URL key/value pairs
        while (itr.hasNext()) {
            String fieldName = (String)itr.next();
            String fieldValue = (String)fields.get(fieldName);
            
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                // append the URL parameters
                buf.append(URLEncoder.encode(fieldName));
                buf.append('=');
                buf.append(URLEncoder.encode(fieldValue));
            }

            // add a '&' to the end if we have more fields coming.
            if (itr.hasNext()) {
                buf.append('&');
            }
        }
    
    }
	
	private String processRequest(Map fields, String againLink) {
		String vpcURL = (String) fields.remove("virtualPaymentClientURL");
		fields.remove("SubButL");
				
		fields.put("AgainLink", againLink);
		
		if (SECURE_SECRET != null && SECURE_SECRET.length() > 0) {
			String secureHash = hashAllFields(fields);
			fields.put("vpc_SecureHash", secureHash);
		}
		
		StringBuffer buf = new StringBuffer();
		buf.append(vpcURL).append('?');
		appendQueryFields(buf, fields);
		
		return buf.toString();
	}
}
