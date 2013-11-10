<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<!-- Version 3.1 -->

<!-- ------------ Disclaimer ---------------------------------------------------

Copyright 2004 Dialect Solutions Holdings.  All rights reserved.

This document is provided by Dialect Solutions Holdings on the basis that you
will treat it as confidential.

No part of this document may be reproduced or copied in any form by any means
without the written permission of Dialect Solutions Holdings.  Unless otherwise
expressly agreed in writing, the information contained in this document is
subject to change without notice and Dialect Solutions Holdings assumes no
responsibility for any alteration to, or any error or other deficiency, in this
document.

All intellectual property rights in the Document and in all extracts and things
derived from any part of the Document are owned by Dialect and will be assigned
to Dialect on their creation. You will protect all the intellectual property
rights relating to the Document in a manner that is equal to the protection you
provide your own intellectual property.  You will notify Dialect immediately,
and in writing where you become aware of a breach of Dialect's intellectual
property rights in relation to the Document.

The names "Dialect", "QSI Payments" and all similar words are trademarks of
Dialect Solutions Holdings and you must not use that name or any similar name.

Dialect may at its sole discretion terminate the rights granted in this document
with immediate effect by notifying you in writing and you will thereupon return
(or destroy and certify that destruction to Dialect) all copies and extracts of
the Document in its possession or control.

Dialect does not warrant the accuracy or completeness of the Document or its
content or its usefulness to you or your merchant customers. To the extent
permitted by law, all conditions and warranties implied by law (whether as to
fitness for any particular purpose or otherwise) are excluded.  Where the
exclusion is not effective, Dialect limits its liability to AU$100 or the
resupply of the Document (at Dialect's option).

Data used in examples and sample data files are intended to be fictional and any
resemblance to real persons or companies is entirely coincidental.

Dialect does not indemnify you or any third party in relation to the content or
any use of the content as contemplated in these terms and conditions.

Mention of any product not owned by Dialect does not constitute an endorsement
of that product.

This document is governed by the laws of New South Wales, Australia and is
intended to be legally binding.
-------------------------------------------------------------------------------- 

Following is a copy of the disclaimer / license agreement provided by RSA:

Copyright (C) 1991-2, RSA Data Security, Inc. Created 1991. All rights
reserved.

License to copy and use this software is granted provided that it is 
identified as the "RSA Data Security, Inc. MD5 Message-Digest Algorithm" in 
all material mentioning or referencing this software or this function.

License is also granted to make and use derivative works provided that such 
works are identified as "derived from the RSA Data Security, Inc. MD5 
Message-Digest Algorithm" in all material mentioning or referencing the 
derived work.

RSA Data Security, Inc. makes no representations concerning either the 
merchantability of this software or the suitability of this software for any 
particular purpose. It is provided "as is" without express or implied warranty 
of any kind.

These notices must be retained in any copies of any part of this documentation 
and/or software.

-------------------------------------------------------------------------------- 

@author Dialect Payment Solutions Pty Ltd Group 

------------------------------------------------------------------------------->

<head><title>Virtual Payment Client Example</title>
<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>
<style type='text/css'>
    <!--
    h1       { font-family:Arial,sans-serif; font-size:20pt; font-weight:600; margin-bottom:0.1em; color:#08185A;}
    h2       { font-family:Arial,sans-serif; font-size:14pt; font-weight:100; margin-top:0.1em; color:#08185A;}
    h2.co    { font-family:Arial,sans-serif; font-size:24pt; font-weight:100; margin-top:0.1em; margin-bottom:0.1em; color:#08185A}
    h3       { font-family:Arial,sans-serif; font-size:16pt; font-weight:100; margin-top:0.1em; margin-bottom:0.1em; color:#08185A}
    h3.co    { font-family:Arial,sans-serif; font-size:16pt; font-weight:100; margin-top:0.1em; margin-bottom:0.1em; color:#FFFFFF}
    body     { font-family:Verdana,Arial,sans-serif; font-size:10pt; background-color:#FFFFFF; color:#08185A}
    th       { font-family:Verdana,Arial,sans-serif; font-size:8pt; font-weight:bold; background-color:#E1E1E1; padding-top:0.5em; padding-bottom:0.5em;  color:#08185A}
    tr       { height:25px; }
    .shade   { height:25px; background-color:#E1E1E1 }
    .title   { height:25px; background-color:#C1C1C1 }
    td       { font-family:Verdana,Arial,sans-serif; font-size:8pt;  color:#08185A }
    td.red   { font-family:Verdana,Arial,sans-serif; font-size:8pt;  color:#FF0066 }
    td.green { font-family:Verdana,Arial,sans-serif; font-size:8pt;  color:#008800 }
    p        { font-family:Verdana,Arial,sans-serif; font-size:10pt; color:#FFFFFF }
    p.blue   { font-family:Verdana,Arial,sans-serif; font-size:7pt;  color:#08185A }
    p.red    { font-family:Verdana,Arial,sans-serif; font-size:7pt;  color:#FF0066 }
    p.green  { font-family:Verdana,Arial,sans-serif; font-size:7pt;  color:#008800 }
    div.bl   { font-family:Verdana,Arial,sans-serif; font-size:7pt;  color:#C1C1C1 }
    div.red  { font-family:Verdana,Arial,sans-serif; font-size:7pt;  color:#FF0066 }
    li       { font-family:Verdana,Arial,sans-serif; font-size:8pt;  color:#FF0066 }
    input    { font-family:Verdana,Arial,sans-serif; font-size:8pt;  color:#08185A; background-color:#E1E1E1; font-weight:bold }
    select   { font-family:Verdana,Arial,sans-serif; font-size:8pt;  color:#08185A; background-color:#E1E1E1; font-weight:bold; }
    textarea { font-family:Verdana,Arial,sans-serif; font-size:8pt;  color:#08185A; background-color:#E1E1E1; font-weight:normal; scrollbar-arrow-color:#08185A; scrollbar-base-color:#E1E1E1 }
    -->
</style></head>
<body>

<!-- Start Branding Table -->
<table width="100%" border="2" cellpadding="2" bgcolor="#C1C1C1">
    <tr>
        <td class="shade" width="90%"><h2 class="co">&nbsp;Virtual Payment Client Example</h2></td>
        <td bgcolor="#C1C1C1" align="center"><h3 class="co">MIGS</h3></td>
    </tr>
</table>
<!-- End Branding Table -->

<center><h1>JSP 3-Party Basic Example - Request Details</h1></center>

<!-- The "Pay Now!" button submits the form, transferring control -->
<form action="vpc_jsp_serverhost_DO.jsp" method="post">
<input type="hidden" name="Title" value="JSP VPC 3-Party"/>

<!-- get user input -->
<table width="80%" align="center" border="0" cellpadding='0' cellspacing='0'>

    <tr class="shade">
        <td width="1%">&nbsp;</td>
        <td width="40%" align="right"><strong><em>Virtual Payment Client URL:&nbsp;</em></strong></td>
        <td width="59%"><input type="text" name="virtualPaymentClientURL" size="63" value="https://migs.mastercard.com.au/vpcpay" maxlength="250"/></td>
    </tr>
    <tr>
        <td colspan="3">&nbsp;<hr width="75%">&nbsp;</td>
    </tr>
    <tr class="title">
        <td colspan="3" height="25"><p><strong>&nbsp;Basic 3-Party Transaction Fields</strong></p></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td align="right"><strong><em> VPC Version: </em></strong></td>
        <td><input type="text" name="vpc_Version" value="1" size="20" maxlength="8"/></td>
    </tr>
    <tr class="shade">
        <td>&nbsp;</td>
        <td align="right"><strong><em>Command Type: </em></strong></td>
        <td><input type="text" name="vpc_Command" value="pay" size="20" maxlength="16"/></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td align="right"><strong><em>Merchant AccessCode: </em></strong></td>
        <td><input type="text" name="vpc_AccessCode" value="" size="20" maxlength="8"/></td>
    </tr>
    <tr class="shade">
        <td>&nbsp;</td>
        <td align="right"><strong><em>Merchant Transaction Reference: </em></strong></td>
        <td><input type="text" name="vpc_MerchTxnRef" value="" size="20" maxlength="40"/></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td align="right"><strong><em>MerchantID: </em></strong></td>
        <td><input type="text" name="vpc_Merchant" value="" size="20" maxlength="16"/></td>
    </tr>
    <tr class="shade">
        <td>&nbsp;</td>
        <td align="right"><strong><em>Transaction OrderInfo: </em></strong></td>
        <td><input type="text" name="vpc_OrderInfo" value="VPC Example" size="20" maxlength="34"/></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td align="right"><strong><em>Purchase Amount: </em></strong></td>
        <td><input type="text" name="vpc_Amount" value="100" size="20" maxlength="10"/></td>
    </tr>
    <tr class="shade">
        <td>&nbsp;</td>
        <td align="right"><strong><em>Receipt ReturnURL: </em></strong></td>
        <td><input type="text" name="vpc_ReturnURL" size="63" value="http://localhost/vpc_jsp_serverhost_DR.jsp" maxlength="250"/></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td align="right"><strong><em>Payment Server Display Language Locale: </em></strong></td>
        <td><input type="text" name="vpc_Locale" value="en" size="20" maxlength="5"/></td>
    </tr>
    <tr>    <td colspan="3">&nbsp;</td></tr>

    <tr>    <td colspan="2">&nbsp;</td> 
            <td><input type="submit" name="SubButL" value="Pay Now!"/></td></tr>

    <tr><td colspan="3">&nbsp;<hr width="75%">&nbsp;</td></tr>
    <tr class="title">
        <td colspan="3"><p><strong>&nbsp;Optional Supplementary Data Field</strong> <font size="1">(15 characters alpha-numeric field)</font></p></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td align="right"><strong><em>TicketNo: </em></strong></td>
        <td><input type="text" name="vpc_TicketNo" maxlength="15"/></td>
    </tr>

    <tr><td colspan="3">&nbsp;<hr width="75%">&nbsp;</td></tr>
    <tr>
        <td colspan="3">
        <p class='blue'><strong><em><u>Note</u>:</em></strong><br/> 
        Any information passed through the customer's browser 
        can potentially be modified by the customer, or even by third parties to 
        fraudulently alter the transaction data. Therefore all transactional 
        information should <strong>not</strong> be passed through the browser in
        a way that could potentially be modified (e.g. hidden form fields). 
        Transaction data should only be accepted once from a browser at the 
        point of input, and then kept in a way that does not allow others 
        to modify it (e.g. database, server session, etc.). Any transaction 
        information displayed to a customer, such as amount, should be passed 
        only as display information and the actual transactional data should be 
        retrieved from the secure source last thing at the point of processing 
        the transaction.</p>

        <p class='blue'>Fields like return links back to the order page (AgainLink), 
        titles, (sockets' data when applicable), and any other non-transactional 
        information are only included here in the example for information purposes. 
        They do not apply to the transaction and should not be included in production 
        code orders.</p>
        </td>
    </tr>

</table>

</form>
</body>
</html>
