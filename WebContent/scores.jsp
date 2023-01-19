<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.swing.*"%>
<%@page import="java.lang.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<style type="text/css">
.img {
	position: relative;
	left: 100px;
	width: 20em;
	height: 50em;
}

.form {
	background-color: lightgrey;
	width: 300px;
	border: 15px solid green;
	padding: 50px;
	margin: 20px;
	color: blue;
	font-size: 20px;
	float: left;
	z-index: 0;
}

body {
	background-image: url("question.jpg");
}
</style>
</head>
<body>
	<%!Connection con;
	PreparedStatement st;
	ResultSet rs; HttpSession sess;%>
	<%
		int i=0;
		try {

			String a=request.getParameter("num1");
			System.out.println(a);
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "manager");
		String sql = "select question,option1,option2,option3,option4 from  questions where name=?";
		st = con.prepareStatement(sql);
		st.setString(1, a);
		rs = st.executeQuery();
		%>
		<form  class="form" action="scores" method="get">
		<input type="text" name="uid"><br><br><br>
		<% 
		while (rs.next()) {
			i=i+1;
			%>
			<c:forEach item="${requestScope.Question}" var="question">
			
			<input type="text" value="<%=rs.getString(1)%>" readonly="readonly" name="ques<%=i %>">
			<br>
			<input type="radio" value="<%=rs.getString(2)%>" name="set<%=i %>"  >
			<label><%=rs.getString(2)%></label>
			<br>
			<input type="radio" value="<%=rs.getString(3)%>" name="set<%=i %>" >			
			<label><%=rs.getString(3)%></label>
			<br>
			<input type="radio" value="<%=rs.getString(4) %>" name="set<%=i %>">		
			<label><%=rs.getString(4)%></label>
			<br>
			<input type="radio" value="<%=rs.getString(5) %>" name="set<%=i %>">
			<label><%=rs.getString(5)%></label>
			<br><br>
	</c:forEach>
	<%
		}
	System.out.println(i);
		
	con.close();
	} catch (Exception e2) {
		System.out.println(e2.toString());
	}
	%>
	<input type="submit" value="Submit">
	</form>
</body>


</html>