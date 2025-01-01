<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Item - Open Library</title>
    <!-- Add CSS styles here -->
</head>
<body>

<h1>Add Item - <%= request.getParameter("type") != null ? request.getParameter("type").toUpperCase() : "" %></h1>

<form action="addItem" method="post">
    <input type="hidden" name="type" value="<%= request.getParameter("type") %>" />
    <!-- Add form fields dynamically based on type -->
    <% String type = request.getParameter("type"); 
       if ("buku".equals(type)) { 
    %>
        Judul: <input type="text" name="judul" required /><br/>
        Penulis: <input type="text" name="penulis" required /><br/>
        Tahun Terbit: <input type="number" name="tahunTerbit" required /><br/>
        Gambar URL: <input type="text" name="gambarUrl" required /><br/>
        Stok: <input type="number" name="stok" required /><br/>
    <% } else if ("dvd".equals(type)) { 
        // Similar fields for DVD
    } else if ("jurnal".equals(type)) { 
        // Similar fields for Jurnal
    } else if ("majalah".equals(type)) { 
        // Similar fields for Majalah
    } %>

    <button type="submit">Submit</button>

</form>

<a href="dashboardItem?type=<%= type %>">Cancel</a>

