<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Enumeration"%>
<%

Map<String, String> map = (Map<String, String>) request.getAttribute("payMap");

Set<String> keySet = map.keySet();

for(String s : keySet) {
	out.println(s + " " + map.get(s));
}


%>