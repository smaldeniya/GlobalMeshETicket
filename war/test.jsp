<%@page import="java.net.URLEncoder"%>
<%
	String sesid = session.getId();
	String url = "http://localhost:8080/platinum.do"; //?jsessionid="+sesid;
	String encodedUrl = URLEncoder.encode(url, "UTF-8");
%>

<a href='http://localhost:8081/TestRunner/test.jsp?path=<%=encodedUrl %>'><%=encodedUrl %></a>