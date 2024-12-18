<%-- 
    Document   : index
    Created on : 17 Dec 2024, 19.23.21
    Author     : Belacks
--%>
<%@page import="driver.JDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <p>Message</p>
        <%
JDBC db = new JDBC();
out.print("AA");
if (db.isConnected) {
out.print(db.message + "<br />");
} else {
out.print(db.message + "<br />");
}
out.print("BB");
%>
        <h1>Hello World!</h1>
    </body>
</html>
