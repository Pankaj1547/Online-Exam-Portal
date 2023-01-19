<%@page import="java.lang.ProcessBuilder.Redirect"%>
 <%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.swing.*"%>
<%@page import="java.lang.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%--  <%@ taglib prefix="c" <%-- uri="http://java.sun.com/jsp/jstl/core" --%> 
 <!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%!Connection con;
PreparedStatement st;
ResultSet rs;
%>
<%try {

	  String a = request.getParameter("num");
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "manager");
	// String sql="select * from questions where name=?";
	String sql = "select question,option1,option2,option3,option4,answer from  questions where name=?";
	st = con.prepareStatement(sql);
  st.setString(1, a);
	rs = st.executeQuery();

	while (rs.next()) {
   %><c:forEach item="${requestScope.Question}" var="question">
<p>Question:${Question} <%=rs.getString(1) %></p>
<p>Option1:${Option1}<%=rs.getString(2) %><br></p>	
<p>Option2:${Option2}<%=rs.getString(3) %><br></p>
<p>Option3:${Option3}<%=rs.getString(4) %><br></p>		
<p>Option4:${Option4}<%=rs.getString(5) %><br></p>
<p>Answer:${Answer}<%=rs.getString(6) %><br></p><br>
		
</c:forEach>
   
<%		
	}
		
	  con.close();
}
	catch (Exception e2) {
		System.out.println(e2.toString());
	}


%>


 


</body>


</html>