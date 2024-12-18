<%@ page session="true" %>
<%
    session.invalidate(); // Hapus semua data session
    response.sendRedirect("index.jsp"); // Redirect ke halaman utama
%>
