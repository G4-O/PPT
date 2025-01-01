<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
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
    <title>Dashboard - Open Library</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            display: flex;
            height: 100vh;
            background-color: #f8f9fa;
        }
        .sidebar {
            width: 250px;
            background-color: #1e3c72;
            color: white;
            display: flex;
            flex-direction: column;
            padding-top: 20px;
        }
        .sidebar h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            display: block;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .sidebar a.active {
            background-color: #007bff;
        }
        .submenu {
            display: none; /* Default submenu hidden */
            padding-left: 20px;
        }
        .main-content {
            flex-grow: 1;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        table th {
            background-color: #f4f4f4;
        }
        .btn {
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
        }
        .btn-primary {
            background-color: #007bff;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-danger {
            background-color: #dc3545;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <h2>Open Library</h2>
    <a href="dashboardItem" class="<%= request.getParameter("type") == null ? "active" : "" %>">Dashboard</a>
    <!-- Item Management -->
    <a href="#" class="toggle">Item Management</a>
    <div class="submenu">
        <a href="dashboardItem?type=buku" class="<%= "buku".equals(request.getParameter("type")) ? "active" : "" %>">Buku</a>
        <a href="dashboardItem?type=dvd" class="<%= "dvd".equals(request.getParameter("type")) ? "active" : "" %>">DVD</a>
        <a href="dashboardItem?type=jurnal" class="<%= "jurnal".equals(request.getParameter("type")) ? "active" : "" %>">Jurnal</a>
        <a href="dashboardItem?type=majalah" class="<%= "majalah".equals(request.getParameter("type")) ? "active" : "" %>">Majalah</a>
    </div>
</div>

<div class="main-content">
    <% 
       String type = (String) request.getAttribute("type"); 
       List<ItemPerpustakaan> items = (List<ItemPerpustakaan>) request.getAttribute("items"); 
    %>

    <h1>Item Management - <%= type != null ? type.substring(0, 1).toUpperCase() + type.substring(1) : "" %></h1>

    <!-- Add Item Button -->
    <% if (type != null) { %>
    <a href="addItemForm.jsp?type=<%= type %>" class="btn btn-primary">Add Item</a>
    <% } %>

    <% if (items != null && !items.isEmpty()) { %>
        <table>
            <thead>
                <% if ("buku".equals(type)) { %>
                    <tr><th>ID</th><th>Judul</th><th>Penulis</th><th>Tahun Terbit</th><th>Gambar</th><th>Stok</th><th>Aksi</th></tr>
                <% } else if ("dvd".equals(type)) { %>
                    <tr><th>ID</th><th>Judul</th><th>Sutradara</th><th>Durasi (menit)</th><th>Gambar</th><th>Stok</th><th>Aksi</th></tr>
                <% } else if ("jurnal".equals(type)) { %>
                    <tr><th>ID</th><th>Judul</th><th>Penulis</th><th>Bidang</th><th>Gambar</th><th>Stok</th><th>Aksi</th></tr>
                <% } else if ("majalah".equals(type)) { %>
                    <tr><th>ID</th><th>Judul</th><th>Edisi</th><th>Gambar</th><th>Stok</th><th>Aksi</th></tr>
                <% } %>
            </thead>
            <tbody>
                <% for (ItemPerpustakaan item : items) { 
                       if (item instanceof Buku && "buku".equals(type)) { 
                           Buku buku = (Buku) item; 
                %>
                    <tr>
                        <td><%= buku.getIdItem() %></td>
                        <td><%= buku.getJudul() %></td>
                        <td><%= buku.getPenulis() %></td>
                        <td><%= buku.getTahunTerbit() %></td>
                        <td><img src="<%= buku.getGambarUrl() %>" alt="Gambar Buku" width="50"></td>
                        <td><%= buku.getStok() %></td>
                        <td>
                            <!-- Edit and Delete Buttons -->
                            <a href="editItemForm.jsp?id=<%= buku.getIdItem() %>&type=buku" class="btn btn-secondary">Edit</a>
                            <a href="deleteItem?id=<%= buku.getIdItem() %>&type=buku" class="btn btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                        </td>
                    </tr>

                <% } else if (item instanceof DVD && "dvd".equals(type)) { 
                       DVD dvd = (DVD) item; 
                %>

                    <tr>
                            <td><img src="<%= dvd.getGambarUrl() %>" alt="Gambar DVD" width="50"></td>
                            <td><%= dvd.getIdItem() %></td>
                            <td><%= dvd.getJudul() %></td>
                            <td><%= dvd.getSutradara() %></td>
                            <td><%= dvd.getDurasi() %></td>
                            <td><%= dvd.getStok() %></td>
                        </tr>

                <% } else if (item instanceof Jurnal && "jurnal".equals(type)) { 
                       Jurnal jurnal = (Jurnal) item; 
                %>

                    <tr>
                            <td><img src="<%= jurnal.getGambarUrl() %>" alt="Gambar Jurnal" width="50"></td>
                            <td><%= jurnal.getIdItem() %></td>
                            <td><%= jurnal.getJudul() %></td>
                            <td><%= jurnal.getPenulis() %></td>
                            <td><%= jurnal.getBidang() %></td>
                            <td><%= jurnal.getStok() %></td>
                        </tr>

                <% } else if (item instanceof Majalah && "majalah".equals(type)) { 
                       Majalah majalah = (Majalah) item; 
                %>

                    <tr>
                            <td><img src="<%= majalah.getGambarUrl() %>" alt="Gambar Majalah" width="50"></td>
                            <td><%= majalah.getIdItem() %></td>
                            <td><%= majalah.getJudul() %></td>
                            <td>Edisi ke-<%= majalah.getEdisi() %></td>
                            <td><%= majalah.getStok() %></td>
                        </tr>

                <% } } %>

            </tbody>    
        </table>

    <% } else { %>

        <!-- Jika tidak ada data -->
        <p>Tidak ada data untuk kategori ini.</p>

    <% }%>

</div>

<script>
// Toggle Submenu
document.querySelectorAll('.toggle').forEach(item => {
    item.addEventListener('click', () => {
        item.classList.toggle('collapsed');
        const submenu = item.nextElementSibling;
        submenu.style.display = submenu.style.display === 'block' ? 'none' : 'block';
    });
});
</script>

</body>
</html>
