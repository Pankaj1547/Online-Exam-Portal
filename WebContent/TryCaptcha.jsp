<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.captcha.botdetect.web.servlet.Captcha"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
  // Adding BotDetect Captcha to the page
  Captcha captcha = Captcha.load(request, "exampleCaptcha");
  captcha.setUserInputID("captchaCode");

  String captchaHtml = captcha.getHtml();
  out.write(captchaHtml);
%>

</body>
</html>