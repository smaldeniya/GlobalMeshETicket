package com.globalmesh.action.sale;

import java.io.IOException;
import java.security.MessageDigest;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dao.SaleDAO;
import com.globalmesh.dao.UserDAO;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.dto.Sale;
import com.globalmesh.dto.User;
import com.globalmesh.util.Constants;
import com.globalmesh.util.Utility;

public class AfterPaymentServlet extends HttpServlet {

	// This is secret for encoding the MD5 hash
	static final String SECURE_SECRET = "";
	// This is an array for creating hex chars
    static final char[] HEX_TABLE = new char[] {
        '0', '1', '2', '3', '4', '5', '6', '7',
        '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
    
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		String email = (String) session.getAttribute("email");
		
		if(email == null) {
			
			req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
			req.setAttribute("message",
					Utility.getCONFG()
							.getProperty(Constants.LOGIN_NEED_MESSAGE));
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			
		} else {

			Sale sale = (Sale) session.getAttribute("sale");
			session.removeAttribute("sale");
			
			Sale saleDuplicate = SaleDAO.INSTANCE.findDuplicateSale(sale.getShowDate(), 
													sale.getSeats(), sale.getHall(), sale.getUserId(), sale.getMovie());
			if(saleDuplicate != null) {
				req.setAttribute("msgClass", Constants.MSG_CSS_WARNING);
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.SALE_DUPLICATE_MESSAGE));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			} else {
				
				Map<String, String> vpcResponse = processPaymentResponse(req);
				int succcess = Integer.parseInt(vpcResponse.get("success"));
				
				if(succcess == 1) {
					sale.setPaid(true);
					SaleDAO.INSTANCE.insertSale(sale);
					MovieDetail movie = MovieDetailDAO.INSTANCE.getMovieById(sale.getMovie());
					User u = UserDAO.INSTANCE.getUserById(sale.getUserId());
					
					String emailBody = MessageFormat.format(Utility.getCONFG().getProperty(Constants.SALE_VERI_CODE_EMAIL_BODY), 
							movie.getMovieName(), sale.getShowDate(), sale.getHall(), sale.getVeriFicationCode());
				
					Utility.sendEmail(Utility.getCONFG().getProperty(Constants.SALE_VERI_CODE_EMAIL_SUBJECT), emailBody, u.getEmail(), Utility.getCONFG().getProperty(Constants.SITE_EMAIL));
					
					String message = MessageFormat.format("{0} {1}", vpcResponse.get("message"), Utility.getCONFG().getProperty(Constants.TICKET_RE_PRINT_SUCCESS));
					
					req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
					req.setAttribute("message", message);
					req.getRequestDispatcher("/messages.jsp").forward(req, resp);
				} else {
					req.setAttribute("msgClass", Constants.MSG_CSS_WARNING);
					req.setAttribute("message", vpcResponse.get("message"));
					req.getRequestDispatcher("/messages.jsp").forward(req, resp);
				}
			}
			
			
		}
		
	}
	
	
	   /** 
		* This method is for sorting the fields and creating an MD5 secure hash.
	    *
	    * @param fields is a map of all the incoming hey-value pairs from the VPC
	    * @return is the hash being returned for comparison to the incoming hash
	    */
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
	       
	       return hex(ba);
	    
	    }
	    
	    /**
	     * This method takes a byte array and returns a string of its contents
	     *
	     * @param input - byte array containing the input data
	     * @return String containing the output String
	     */
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
	     
	     /**
	      * This method takes a data String and returns a predefined value if empty
	      * If data Sting is null, returns string "No Value Returned", else returns input
	      *
	      * @param in String containing the data String
	      * @return String containing the output String
	      */
	      private static String null2unknown(String in) {
	          if (in == null || in.length() == 0) {
	              return "No Value Returned";
	          } else {
	              return in;
	          }
	      } 
	      
	      /**
	       * This function uses the returned status code retrieved from the Digital
	       * Response and returns an appropriate description for the code
	       *
	       * @param vResponseCode String containing the vpc_TxnResponseCode
	       * @return description String containing the appropriate description
	       */ 
	       String getResponseDescription(String vResponseCode) {

	           String result = "";

	           // check if a single digit response code
	           if (vResponseCode.length() != 1) {
	           
	               // Java cannot switch on a string so turn everything to a char
	               char input = vResponseCode.charAt(0);

	               switch (input){
	                   case '0' : result = "Transaction Successful"; break;
	                   case '1' : result = "Unknown Error"; break;
	                   case '2' : result = "Bank Declined Transaction"; break;
	                   case '3' : result = "No Reply from Bank"; break;
	                   case '4' : result = "Expired Card"; break;
	                   case '5' : result = "Insufficient Funds"; break;
	                   case '6' : result = "Error Communicating with Bank"; break;
	                   case '7' : result = "Payment Server System Error"; break;
	                   case '8' : result = "Transaction Type Not Supported"; break;
	                   case '9' : result = "Bank declined transaction (Do not contact Bank)"; break;
	                   case 'A' : result = "Transaction Aborted"; break;
	                   case 'C' : result = "Transaction Cancelled"; break;
	                   case 'D' : result = "Deferred transaction has been received and is awaiting processing"; break;
	                   case 'F' : result = "3D Secure Authentication failed"; break;
	                   case 'I' : result = "Card Security Code verification failed"; break;
	                   case 'L' : result = "Shopping Transaction Locked (Please try the transaction again later)"; break;
	                   case 'N' : result = "Cardholder is not enrolled in Authentication Scheme"; break;
	                   case 'P' : result = "Transaction has been received by the Payment Adaptor and is being processed"; break;
	                   case 'R' : result = "Transaction was not processed - Reached limit of retry attempts allowed"; break;
	                   case 'S' : result = "Duplicate SessionID (OrderInfo)"; break;
	                   case 'T' : result = "Address Verification Failed"; break;
	                   case 'U' : result = "Card Security Code Failed"; break;
	                   case 'V' : result = "Address Verification and Card Security Code Failed"; break;
	                   case '?' : result = "Transaction status is unknown"; break;
	                   default  : result = "Unable to be determined";
	               }
	               
	               return result;
	           } else {
	               return "No Value Returned";
	           }
	       }
	       
	       /**
	        * This function uses the QSI AVS Result Code retrieved from the Digital
	        * Receipt and returns an appropriate description for this code.
	        *
	        * @param vAVSResultCode String containing the vpc_AVSResultCode
	        * @return description String containing the appropriate description
	        */
	        private String displayAVSResponse(String vAVSResultCode) {

	            String result = "";
	            if (vAVSResultCode != null || vAVSResultCode.length() == 0) {

	                if (vAVSResultCode.equalsIgnoreCase("Unsupported") || vAVSResultCode.equalsIgnoreCase("No Value Returned")) {
	                    result = "AVS not supported or there was no AVS data provided";
	                } else {
	                    // Java cannot switch on a string so turn everything to a char
	                    char input = vAVSResultCode.charAt(0);

	                    switch (input){
	                        case 'X' : result = "Exact match - address and 9 digit ZIP/postal code"; break;
	                        case 'Y' : result = "Exact match - address and 5 digit ZIP/postal code"; break;
	                        case 'S' : result = "Service not supported or address not verified (international transaction)"; break;
	                        case 'G' : result = "Issuer does not participate in AVS (international transaction)"; break;
	                        case 'A' : result = "Address match only"; break;
	                        case 'W' : result = "9 digit ZIP/postal code matched, Address not Matched"; break;
	                        case 'Z' : result = "5 digit ZIP/postal code matched, Address not Matched"; break;
	                        case 'R' : result = "Issuer system is unavailable"; break;
	                        case 'U' : result = "Address unavailable or not verified"; break;
	                        case 'E' : result = "Address and ZIP/postal code not provided"; break;
	                        case 'N' : result = "Address and ZIP/postal code not matched"; break;
	                        case '0' : result = "AVS not requested"; break;
	                        default  : result = "Unable to be determined";
	                    }
	                }
	            } else {
	                result = "null response";
	            }
	            return result;
	        }
	        
	        /**
	         * This function uses the QSI CSC Result Code retrieved from the Digital
	         * Receipt and returns an appropriate description for this code.
	         *
	         * @param vCSCResultCode String containing the vpc_CSCResultCode
	         * @return description String containing the appropriate description
	         */
	         private String displayCSCResponse(String vCSCResultCode) {

	             String result = "";
	             if (vCSCResultCode != null || vCSCResultCode.length() == 0) {

	                 if (vCSCResultCode.equalsIgnoreCase("Unsupported")  || vCSCResultCode.equalsIgnoreCase("No Value Returned")) {
	                     result = "CSC not supported or there was no CSC data provided";
	                 } else {
	                     // Java cannot switch on a string so turn everything to a char
	                     char input = vCSCResultCode.charAt(0);

	                     switch (input){
	                         case 'M' : result = "Exact code match"; break;
	                         case 'S' : result = "Merchant has indicated that CSC is not present on the card (MOTO situation)"; break;
	                         case 'P' : result = "Code not processed"; break;
	                         case 'U' : result = "Card issuer is not registered and/or certified"; break;
	                         case 'N' : result = "Code invalid or not matched"; break;
	                         default  : result = "Unable to be determined";
	                     }
	                 }

	             } else {
	                 result = "null response";
	             }
	             return result;
	         }
	         
	         /**
	          * This method uses the 3DS verStatus retrieved from the 
	          * Response and returns an appropriate description for this code.
	          *
	          * @param vpc_VerStatus String containing the status code
	          * @return description String containing the appropriate description
	          */
	          private String getStatusDescription(String vStatus) {

	              String result = "";
	              if (vStatus != null && !vStatus.equals("")) {

	                  if (vStatus.equalsIgnoreCase("Unsupported")  || vStatus.equals("No Value Returned")) {
	                      result = "3DS not supported or there was no 3DS data provided";
	                  } else {
	                  
	                      // Java cannot switch on a string so turn everything to a character
	                      char input = vStatus.charAt(0);

	                      switch (input){
	                          case 'Y'  : result = "The cardholder was successfully authenticated."; break;
	                          case 'E'  : result = "The cardholder is not enrolled."; break;
	                          case 'N'  : result = "The cardholder was not verified."; break;
	                          case 'U'  : result = "The cardholder's Issuer was unable to authenticate due to some system error at the Issuer."; break;
	                          case 'F'  : result = "There was an error in the format of the request from the merchant."; break;
	                          case 'A'  : result = "Authentication of your Merchant ID and Password to the ACS Directory Failed."; break;
	                          case 'D'  : result = "Error communicating with the Directory Server."; break;
	                          case 'C'  : result = "The card type is not supported for authentication."; break;
	                          case 'S'  : result = "The signature on the response received from the Issuer could not be validated."; break;
	                          case 'P'  : result = "Error parsing input from Issuer."; break;
	                          case 'I'  : result = "Internal Payment Server system error."; break;
	                          default   : result = "Unable to be determined"; break;
	                      }
	                  }
	              } else {
	                  result = "null response";
	              }
	              return result;
	          }
	          
	          private Map<String,String> processPaymentResponse(HttpServletRequest request) {
	        	  
	        	// retrieve all the incoming parameters into a hash map
	        	    Map fields = new HashMap();
	        	    for (Enumeration enume = request.getParameterNames(); enume.hasMoreElements();) {
	        	        String fieldName = (String) enume.nextElement();
	        	        String fieldValue = request.getParameter(fieldName);
	        	        if ((fieldValue != null) && (fieldValue.length() > 0)) {
	        	            fields.put(fieldName, fieldValue);
	        	        }
	        	    }
	        	    
	        	 // remove the vpc_TxnResponseCode code from the response fields as we do not 
	        	    // want to include this field in the hash calculation
	        	    String vpc_Txn_Secure_Hash = null2unknown((String) fields.remove("vpc_SecureHash"));
	        	    String hashValidated = null;

	        	    // defines if error message should be output
	        	    boolean errorExists = false;
	        	    
	        	    if (SECURE_SECRET != null && SECURE_SECRET.length() > 0 && 
	        	            (fields.get("vpc_TxnResponseCode") != null || fields.get("vpc_TxnResponseCode") != "No Value Returned")) {
	        	            
	        	            // create secure hash and append it to the hash map if it was created
	        	            // remember if SECURE_SECRET = "" it wil not be created
	        	            String secureHash = hashAllFields(fields);
	        	        
	        	            // Validate the Secure Hash (remember MD5 hashes are not case sensitive)
	        	            if (vpc_Txn_Secure_Hash.equalsIgnoreCase(secureHash)) {
	        	                // Secure Hash validation succeeded, add a data field to be 
	        	                // displayed later.
	        	                hashValidated = "<font color='#00AA00'><strong>CORRECT</strong></font>";
	        	            } else {
	        	                // Secure Hash validation failed, add a data field to be
	        	                // displayed later.
	        	                errorExists = true;
	        	                hashValidated = "<font color='#FF0066'><strong>INVALID HASH</strong></font>";
	        	            }
	        	        } else {
	        	            // Secure Hash was not validated, 
	        	            hashValidated = "<font color='orange'><strong>Not Calculated - No 'SECURE_SECRET' present.</strong></font>";
	        	        }

	        	        // Extract the available receipt fields from the VPC Response
	        	        // If not present then let the value be equal to 'Unknown'
	        	        // Standard Receipt Data
	        	        //String title           = null2unknown((String)fields.get("Title"));
	        	        //String againLink       = null2unknown((String)fields.get("AgainLink"));
	        	        String amount          = null2unknown((String)fields.get("vpc_Amount"));
	        	        //String locale          = null2unknown((String)fields.get("vpc_Locale"));
	        	        String batchNo         = null2unknown((String)fields.get("vpc_BatchNo"));
	        	        String command         = null2unknown((String)fields.get("vpc_Command"));
	        	        String message         = null2unknown((String)fields.get("vpc_Message"));
	        	        //String version         = null2unknown((String)fields.get("vpc_Version"));
	        	        String cardType        = null2unknown((String)fields.get("vpc_Card"));
	        	        String orderInfo       = null2unknown((String)fields.get("vpc_OrderInfo"));
	        	        String receiptNo       = null2unknown((String)fields.get("vpc_ReceiptNo"));
	        	        /*String merchantID      = null2unknown((String)fields.get("vpc_Merchant"));
	        	        String merchTxnRef     = null2unknown((String)fields.get("vpc_MerchTxnRef"));*/
	        	        String authorizeID     = null2unknown((String)fields.get("vpc_AuthorizeId"));
	        	        String transactionNo   = null2unknown((String)fields.get("vpc_TransactionNo"));
	        	        String acqResponseCode = null2unknown((String)fields.get("vpc_AcqResponseCode"));
	        	        String txnResponseCode = null2unknown((String)fields.get("vpc_TxnResponseCode"));

	        	        // CSC Receipt Data
	        	        String vCSCResultCode  = null2unknown((String)fields.get("vpc_CSCResultCode"));
	        	        /*String vCSCRequestCode = null2unknown((String)fields.get("vpc_CSCRequestCode"));
	        	        String vACQCSCRespCode = null2unknown((String)fields.get("vpc_AcqCSCRespCode"));*/
	        	        
	        	        // AVS Receipt Data
	        	       /* String vAVS_City       = null2unknown((String)fields.get("vpc_AVS_City"));
	        	        String vAVS_Country    = null2unknown((String)fields.get("vpc_AVS_Country"));
	        	        String vAVS_Street01   = null2unknown((String)fields.get("vpc_AVS_Street01"));
	        	        String vAVS_PostCode   = null2unknown((String)fields.get("vpc_AVS_PostCode"));
	        	        String vAVS_StateProv  = null2unknown((String)fields.get("vpc_AVS_StateProv"));*/
	        	        String vAVSResultCode  = null2unknown((String)fields.get("vpc_AVSResultCode"));
	        	        /*String vAVSRequestCode = null2unknown((String)fields.get("vpc_AVSRequestCode"));
	        	        String vACQAVSRespCode = null2unknown((String)fields.get("vpc_AcqAVSRespCode"));*/

	        	        // 3-D Secure Data
	        	        String transType3DS       = null2unknown((String)fields.get("vpc_VerType"));
	        	        String verStatus3DS       = null2unknown((String)fields.get("vpc_VerStatus"));
	        	        String token3DS           = null2unknown((String)fields.get("vpc_VerToken"));
	        	       /* String secureLevel3DS  = null2unknown((String)fields.get("vpc_VerSecurityLevel"));
	        	        String enrolled3DS       = null2unknown((String)fields.get("vpc_3DSenrolled"));
	        	        String xid3DS           = null2unknown((String)fields.get("vpc_3DSXID"));
	        	        String eci3DS           = null2unknown((String)fields.get("vpc_3DSECI"));
	        	        String status3DS       = null2unknown((String)fields.get("vpc_3DSstatus"));*/
	        	        
	        	        String error = "";
	        	        // Show this page as an error page if error condition
	        	        if (txnResponseCode.equals("7") || txnResponseCode.equals("No Value Returned") || errorExists) {
	        	            error = "Error ";
	        	        }
	        	        
	        	        Map<String,String> returnVal = new HashMap<String, String>();
	        	        /*returnVal.put("title", title);
	        	        returnVal.put("version", version);
	        	        returnVal.put("command", command);
	        	        returnVal.put("merchTxnRef", merchTxnRef);
	        	        returnVal.put("merchantID", merchantID);*/
	        	        returnVal.put("orderInfo", orderInfo);
	        	        returnVal.put("amount", amount);	        	        
	        	        returnVal.put("txnResponseCode", txnResponseCode);
	        	        returnVal.put("txnResponseCodeDiscription", getResponseDescription(txnResponseCode)); //TODOadd a boolean to response fail
	        	        returnVal.put("message", message);
	        	        
	        	        if(txnResponseCode.charAt(0) == '0'){
	        	        	returnVal.put("success", "1"); //Success true = 1
	        	        } else {
	        	        	returnVal.put("success", "0");
	        	        }
	        	        
	        	        if (!txnResponseCode.equals("7") && !txnResponseCode.equals("No Value Returned")) {
	        	        	// only add the this fields if not an error condition
	        	        	returnVal.put("receiptNo", receiptNo);
		        	        returnVal.put("transactionNo", transactionNo);
		        	        returnVal.put("acqResponseCode", acqResponseCode);
		        	        returnVal.put("authorizeID", authorizeID);
		        	        returnVal.put("batchNo", batchNo);
		        	        returnVal.put("cardType", cardType);
		        	        
		        	        //Fields above are for a standard transaction. Fields below are additional fields for extra functionality.
		        	        /*returnVal.put("vCSCRequestCode", vCSCRequestCode);
		        	        returnVal.put("vACQCSCRespCode", vACQCSCRespCode);
		        	        returnVal.put("vCSCResultCode", vCSCResultCode);*/
		        	        returnVal.put("cscDescription", displayCSCResponse(vCSCResultCode));
		        	       
		        	        //Address Verification Service Fields
		        	        /*returnVal.put("vAVS_Street01", vAVS_Street01);
		        	        returnVal.put("vAVS_City", vAVS_City);
		        	        returnVal.put("vAVS_StateProv", vAVS_StateProv);
		        	        returnVal.put("vAVS_PostCode", vAVS_PostCode);
		        	        returnVal.put("vAVS_Country", vAVS_Country);
		        	        returnVal.put("vAVSRequestCode", vAVSRequestCode);
		        	        returnVal.put("vACQAVSRespCode", vACQAVSRespCode);
		        	        returnVal.put("vAVSResultCode", vAVSResultCode);*/
		        	        returnVal.put("avsDescription", displayAVSResponse(vAVSResultCode));
		        	        
		        	        //3-D Secure Authentication Fields
		        	        returnVal.put("transType3DS", transType3DS);
		        	        returnVal.put("verStatus3DS", verStatus3DS);
		        	        returnVal.put("token3DS", token3DS);
		        	        /*returnVal.put("xid3DS", xid3DS);
		        	        returnVal.put("eci3DS", eci3DS);
		        	        returnVal.put("enrolled3DS", enrolled3DS);
		        	        returnVal.put("status3DS", status3DS);
		        	        returnVal.put("secureLevel3DS", secureLevel3DS);
		        	        returnVal.put("verStatus3DS", verStatus3DS);*/
		        	        returnVal.put("3dsDescription", getStatusDescription(verStatus3DS));
		        	        returnVal.put("hashValidated", hashValidated);
	        	        }
	        	                	        	        	        
	        	        return returnVal;	        	        
	        	        
	          }
	       
	
}
