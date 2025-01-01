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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        :root {
            --primary-color: #1e3c72;
            --secondary-color: #2a5298;
            --accent-color: #007bff;
            --text-color: #333;
            --bg-color: #f8f9fa;
        }

        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            display: flex;
            min-height: 100vh;
            background: linear-gradient(135deg, var(--bg-color) 0%, #ffffff 100%);
            color: var(--text-color);
        }

        .sidebar {
            width: 250px;
            background: linear-gradient(180deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            display: flex;
            flex-direction: column;
            padding-top: 20px;
            position: fixed;
            height: 100vh;
            transition: all 0.3s ease;
            box-shadow: 4px 0 10px rgba(0,0,0,0.1);
        }

        .sidebar h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: 600;
            padding: 0 20px;
            position: relative;
        }

        .sidebar h2::after {
            content: '';
            display: block;
            width: 50px;
            height: 3px;
            background: var(--accent-color);
            margin: 10px auto;
            border-radius: 2px;
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 12px 20px;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }

        .sidebar a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        .sidebar a:hover {
            background: rgba(255,255,255,0.1);
            border-left-color: var(--accent-color);
            transform: translateX(4px);
        }

        .sidebar a.active {
            background: var(--accent-color);
            border-left-color: white;
        }

        .main-content {
            flex-grow: 1;
            margin-left: 250px;
            padding: 30px;
            transition: all 0.3s ease;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--accent-color);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card:hover::before {
            transform: scaleX(1);
        }

        .stat-card i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--primary-color);
            transition: all 0.3s ease;
        }

        .stat-card:hover i {
            transform: scale(1.1);
            color: var(--accent-color);
        }

        .stat-card h3 {
            margin: 0;
            color: var(--primary-color);
            font-size: 16px;
            font-weight: 500;
        }

        .stat-card p {
            margin: 10px 0 0;
            font-size: 28px;
            font-weight: bold;
            color: var(--accent-color);
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 30px;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        table th, table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        table th {
            background: var(--primary-color);
            color: white;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 0.5px;
        }

        table tr {
            transition: all 0.3s ease;
        }

        table tr:hover {
            background: #f8f9fa;
            transform: scale(1.01);
        }

        .btn {
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            color: white;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn i {
            font-size: 14px;
        }

        .btn-primary {
            background: var(--accent-color);
        }

        .btn-primary:hover {
            background: #0056b3;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #6c757d;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        .btn-danger {
            background: #dc3545;
        }

        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
        }

        .alert {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideInDown 0.5s ease;
        }

        .alert i {
            font-size: 20px;
        }

        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }

        .search-bar {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }

        .search-input {
            flex: 1;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-family: inherit;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 3px rgba(0,123,255,0.1);
        }

        @keyframes slideInDown {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
                overflow: hidden;
            }

            .sidebar h2, .sidebar a span {
                display: none;
            }

            .main-content {
                margin-left: 70px;
            }

            .stats-container {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            }
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
