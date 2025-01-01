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
            display: none;
            padding-left: 20px;
        }
        .main-content {
            flex-grow: 1;
            padding: 20px;
        }
        .stats-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 30px;
            padding: 20px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: transform 0.2s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: #1e3c72;
        }

        .stat-card h3 {
            margin: 0;
            color: #1e3c72;
            font-size: 16px;
        }

        .stat-card p {
            margin: 10px 0 0;
            font-size: 24px;
            font-weight: bold;
            color: #007bff;
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
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
        }
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>Open Library</h2>
        <a href="dashboardItem" class="<%= request.getParameter("type") == null ? "active" : "" %>">Dashboard</a>
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
        String successMessage = request.getParameter("success");
        String errorMessage = request.getParameter("error");
        if (successMessage != null) { 
        %>
            <div class="alert alert-success" role="alert">
                <%= successMessage %>
            </div>
        <% } 
        if (errorMessage != null) { 
        %>
            <div class="alert alert-danger" role="alert">
                <%= errorMessage %>
            </div>
        <% } %>

        <% 
        String type = (String) request.getAttribute("type");
        List<ItemPerpustakaan> items = (List<ItemPerpustakaan>) request.getAttribute("items");
        
        if (type == null) { 
        %>
            <div class="stats-container">
                <div class="stat-card">
                    <i class="fas fa-book"></i>
                    <h3>Total Buku</h3>
                    <p><%= request.getAttribute("totalBuku") %></p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-compact-disc"></i>
                    <h3>Total DVD</h3>
                    <p><%= request.getAttribute("totalDvd") %></p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-newspaper"></i>
                    <h3>Total Jurnal</h3>
                    <p><%= request.getAttribute("totalJurnal") %></p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-book-open"></i>
                    <h3>Total Majalah</h3>
                    <p><%= request.getAttribute("totalMajalah") %></p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-users"></i>
                    <h3>Total Users</h3>
                    <p><%= request.getAttribute("totalUsers") %></p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-handshake"></i>
                    <h3>Total Peminjaman</h3>
                    <p><%= request.getAttribute("totalPeminjaman") %></p>
                </div>
            </div>
        <% } %>

        <% if (type != null) { %>
            <h1>Item Management - <%= type.substring(0, 1).toUpperCase() + type.substring(1) %></h1>
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
                                <a href="editItem?id=<%= buku.getIdItem() %>&type=buku" class="btn btn-secondary">Edit</a>
                                <a href="deleteItem?id=<%= buku.getIdItem() %>&type=buku" class="btn btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                            </td>
                        </tr>
                    <% } else if (item instanceof DVD && "dvd".equals(type)) { 
                        DVD dvd = (DVD) item; 
                    %>
                        <tr>
                            <td><%= dvd.getIdItem() %></td>
                            <td><%= dvd.getJudul() %></td>
                            <td><%= dvd.getSutradara() %></td>
                            <td><%= dvd.getDurasi() %></td>
                            <td><img src="<%= dvd.getGambarUrl() %>" alt="Gambar DVD" width="50"></td>
                            <td><%= dvd.getStok() %></td>
                            <td>
                                <a href="editItem?id=<%= dvd.getIdItem() %>&type=dvd" class="btn btn-secondary">Edit</a>
                                <a href="deleteItem?id=<%= dvd.getIdItem() %>&type=dvd" class="btn btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                            </td>
                        </tr>
                    <% } else if (item instanceof Jurnal && "jurnal".equals(type)) { 
                        Jurnal jurnal = (Jurnal) item; 
                    %>
                        <tr>
                            <td><%= jurnal.getIdItem() %></td>
                            <td><%= jurnal.getJudul() %></td>
                            <td><%= jurnal.getPenulis() %></td>
                            <td><%= jurnal.getBidang() %></td>
                            <td><img src="<%= jurnal.getGambarUrl() %>" alt="Gambar Jurnal" width="50"></td>
                            <td><%= jurnal.getStok() %></td>
                            <td>
                                <a href="editItem?id=<%= jurnal.getIdItem() %>&type=jurnal" class="btn btn-secondary">Edit</a>
                                <a href="deleteItem?id=<%= jurnal.getIdItem() %>&type=jurnal" class="btn btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                            </td>
                        </tr>
                    <% } else if (item instanceof Majalah && "majalah".equals(type)) { 
                        Majalah majalah = (Majalah) item; 
                    %>
                        <tr>
                            <td><%= majalah.getIdItem() %></td>
                            <td><%= majalah.getJudul() %></td>
                            <td><%= majalah.getEdisi() %></td>
                            <td><img src="<%= majalah.getGambarUrl() %>" alt="Gambar Majalah" width="50"></td>
                            <td><%= majalah.getStok() %></td>
                            <td>
                                <a href="editItem?id=<%= majalah.getIdItem() %>&type=majalah" class="btn btn-secondary">Edit</a>
                                <a href="deleteItem?id=<%= majalah.getIdItem() %>&type=majalah" class="btn btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                            </td>
                        </tr>
                    <% } 
                    } %>
                </tbody>
            </table>
        <% } else if (type != null) { %>
            <p>Tidak ada data untuk kategori ini.</p>
        <% } %>
    </div>

    <script>
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
