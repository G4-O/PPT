<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ItemPerpustakaan" %>
<%@ page import="model.Buku" %>
<%@ page import="model.DVD" %>
<%@ page import="model.Jurnal" %>
<%@ page import="model.Majalah" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Item - Open Library</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .form-container h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
        }
        .form-group input {
            width: calc(100% - 16px);
            padding: 8px;
            margin-top: 5px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        .form-actions {
            text-align: center;
        }
        .btn {
            padding: 10px 20px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h1>Edit Item</h1>

    <% 
       String type = request.getParameter("type");
       ItemPerpustakaan item = (ItemPerpustakaan) request.getAttribute("item");
    %>

    <form action="updateItem" method="post">
        <input type="hidden" name="type" value="<%= type %>">
        <input type="hidden" name="idItem" value="<%= item.getIdItem() %>">

        <% if ("buku".equals(type)) { 
           Buku buku = (Buku) item; 
        %>
           <div class="form-group">
               <label for="judul">Judul</label>
               <input type="text" name="judul" id="judul" value="<%= buku.getJudul() %>" required>
           </div>
           <div class="form-group">
               <label for="penulis">Penulis</label>
               <input type="text" name="penulis" id="penulis" value="<%= buku.getPenulis() %>" required>
           </div>
           <div class="form-group">
               <label for="tahunTerbit">Tahun Terbit</label>
               <input type="number" name="tahunTerbit" id="tahunTerbit" value="<%= buku.getTahunTerbit() %>" required>
           </div>
           <div class="form-group">
               <label for="gambarUrl">Gambar URL</label>
               <input type="text" name="gambarUrl" id="gambarUrl" value="<%= buku.getGambarUrl() %>" required>
           </div>
           <div class="form-group">
               <label for="stok">Stok</label>
               <input type="number" name="stok" id="stok" value="<%= buku.getStok() %>" required>
           </div>

        <% } else if ("dvd".equals(type)) { 
           DVD dvd = (DVD) item; 
        %>
           <!-- Similar fields for DVD -->

        <% } else if ("jurnal".equals(type)) { 
           Jurnal jurnal = (Jurnal) item; 
        %>
           <!-- Similar fields for Jurnal -->

        <% } else if ("majalah".equals(type)) { 
           Majalah majalah = (Majalah) item; 
        %>
           <!-- Similar fields for Majalah -->

        <% } %>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Update</button>
            <a href="dashboardItem?type=<%= type %>" class="btn btn-secondary">Cancel</a>
        </div>

    </form>

</div>

</body>
</html>
