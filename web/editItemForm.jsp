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
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        form {
            max-width: 500px;
            margin: 0 auto;
        }
        input {
            width: 100%;
            padding: 8px;
            margin: 5px 0 15px 0;
            box-sizing: border-box;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <%
        String type = (String) request.getAttribute("type");
        ItemPerpustakaan item = (ItemPerpustakaan) request.getAttribute("item");

        if (item == null) {
            response.sendRedirect("dashboardItem?type=" + type + "&error=Data tidak ditemukan");
            return;
        }
    %>


    <h1>Edit Item - <%= type != null ? type.toUpperCase() : "" %></h1>

    <form action="updateItem" method="post">
        <input type="hidden" name="type" value="<%= type %>">
        <input type="hidden" name="idItem" value="<%= item.getIdItem() %>">

        <% if ("buku".equals(type)) {
            Buku buku = (Buku) item; %>
            <label for="judul">Judul:</label>
            <input type="text" id="judul" name="judul" value="<%= buku.getJudul() %>" required>
            
            <label for="penulis">Penulis:</label>
            <input type="text" id="penulis" name="penulis" value="<%= buku.getPenulis() %>" required>
            
            <label for="tahunTerbit">Tahun Terbit:</label>
            <input type="number" id="tahunTerbit" name="tahunTerbit" value="<%= buku.getTahunTerbit() %>" required>
            
            <label for="gambarUrl">Gambar URL:</label>
            <input type="text" id="gambarUrl" name="gambarUrl" value="<%= buku.getGambarUrl() %>" required>
            
            <label for="stok">Stok:</label>
            <input type="number" id="stok" name="stok" value="<%= buku.getStok() %>" required>

        <% } else if ("dvd".equals(type)) {
            DVD dvd = (DVD) item; %>
            <label for="judul">Judul:</label>
            <input type="text" id="judul" name="judul" value="<%= dvd.getJudul() %>" required>
            
            <label for="sutradara">Sutradara:</label>
            <input type="text" id="sutradara" name="sutradara" value="<%= dvd.getSutradara() %>" required>
            
            <label for="durasi">Durasi:</label>
            <input type="number" id="durasi" name="durasi" value="<%= dvd.getDurasi() %>" required>
            
            <label for="gambarUrl">Gambar URL:</label>
            <input type="text" id="gambarUrl" name="gambarUrl" value="<%= dvd.getGambarUrl() %>" required>
            
            <label for="stok">Stok:</label>
            <input type="number" id="stok" name="stok" value="<%= dvd.getStok() %>" required>

        <% } else if ("jurnal".equals(type)) {
            Jurnal jurnal = (Jurnal) item; %>
            <label for="judul">Judul:</label>
            <input type="text" id="judul" name="judul" value="<%= jurnal.getJudul() %>" required>
            
            <label for="penulis">Penulis:</label>
            <input type="text" id="penulis" name="penulis" value="<%= jurnal.getPenulis() %>" required>
            
            <label for="bidang">Bidang:</label>
            <input type="text" id="bidang" name="bidang" value="<%= jurnal.getBidang() %>" required>
            
            <label for="gambarUrl">Gambar URL:</label>
            <input type="text" id="gambarUrl" name="gambarUrl" value="<%= jurnal.getGambarUrl() %>" required>
            
            <label for="stok">Stok:</label>
            <input type="number" id="stok" name="stok" value="<%= jurnal.getStok() %>" required>

        <% } else if ("majalah".equals(type)) {
            Majalah majalah = (Majalah) item; %>
            <label for="judul">Judul:</label>
            <input type="text" id="judul" name="judul" value="<%= majalah.getJudul() %>" required>
            
            <label for="edisi">Edisi:</label>
            <input type="number" id="edisi" name="edisi" value="<%= majalah.getEdisi() %>" required>
            
            <label for="gambarUrl">Gambar URL:</label>
            <input type="text" id="gambarUrl" name="gambarUrl" value="<%= majalah.getGambarUrl() %>" required>
            
            <label for="stok">Stok:</label>
            <input type="number" id="stok" name="stok" value="<%= majalah.getStok() %>" required>
        <% } %>

        <button type="submit">Update</button>
        <button type="button" onclick="window.location.href='dashboardItem?type=<%= type %>'">Batal</button>
    </form>
</body>
</html>
