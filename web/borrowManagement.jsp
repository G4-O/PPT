<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Borrow Management - Open Library</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
    <!-- Sidebar yang sama dengan dashboard.jsp -->
    <div class="sidebar">
        <h2>Open Library</h2>
        <a href="dashboardItem" class="<%= request.getParameter("type") == null ? "active" : "" %>">Dashboard</a>

        <!-- Item Management Menu yang sudah ada -->
        <a href="#" class="toggle">Item Management</a>
        <div class="submenu">
            <a href="dashboardItem?type=buku" class="<%= "buku".equals(request.getParameter("type")) ? "active" : "" %>">Buku</a>
            <a href="dashboardItem?type=dvd" class="<%= "dvd".equals(request.getParameter("type")) ? "active" : "" %>">DVD</a>
            <a href="dashboardItem?type=jurnal" class="<%= "jurnal".equals(request.getParameter("type")) ? "active" : "" %>">Jurnal</a>
            <a href="dashboardItem?type=majalah" class="<%= "majalah".equals(request.getParameter("type")) ? "active" : "" %>">Majalah</a>
        </div>

        <!-- Tambahkan Borrow Management Menu -->
        <a href="#" class="toggle">Borrow Management</a>
        <div class="submenu">
            <a href="borrowManagement?status=active" class="<%= "active".equals(request.getParameter("status")) ? "active" : "" %>">Active Borrow</a>
            <a href="borrowManagement?status=overdue" class="<%= "overdue".equals(request.getParameter("status")) ? "active" : "" %>">Overdue Borrow</a>
        </div>
    </div>
    
    <div class="sidebar">
        <h2>Open Library</h2>
        <a href="dashboardItem">Dashboard</a>
        <a href="#" class="toggle">Item Management</a>
        <div class="submenu">
            <a href="dashboardItem?type=buku">Buku</a>
            <a href="dashboardItem?type=dvd">DVD</a>
            <a href="dashboardItem?type=jurnal">Jurnal</a>
            <a href="dashboardItem?type=majalah">Majalah</a>
        </div>
        <a href="#" class="toggle">Borrow Management</a>
        <div class="submenu">
            <a href="borrowManagement?status=active" class="<%= "active".equals(request.getParameter("status")) ? "active" : "" %>">Active Borrow</a>
            <a href="borrowManagement?status=overdue" class="<%= "overdue".equals(request.getParameter("status")) ? "active" : "" %>">Overdue Borrow</a>
        </div>
    </div>

    <div class="main-content">
    <h1>Borrow Management - <%= request.getAttribute("status").toString().substring(0, 1).toUpperCase() + request.getAttribute("status").toString().substring(1) %></h1>

    <table>
        <thead>
            <tr>
                <th>ID TRANSAKSI</th>
                <th>JUDUL ITEM</th>
                <th>ID ANGGOTA</th>
                <th>TANGGAL PINJAM</th>
                <th>TANGGAL KEMBALI</th>
                <% if ("overdue".equals(request.getAttribute("status"))) { %>
                    <th>KETERLAMBATAN</th>
                    <th>DENDA</th>
                <% } %>
                <th>AKSI</th>
            </tr>
        </thead>
        <tbody>
            <% 
            List<Map<String, Object>> borrowList = (List<Map<String, Object>>) request.getAttribute("borrowList");
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            for (Map<String, Object> borrow : borrowList) {
            %>
            <tr>
                <td><%= borrow.get("idTransaksi") %></td>
                <td><%= borrow.get("judul") != null ? borrow.get("judul") : "-" %></td>
                <td><%= borrow.get("idAnggota") != null ? borrow.get("idAnggota") : "-" %></td>
                <td><%= sdf.format(borrow.get("tanggalTransaksi")) %></td>
                <td><%= sdf.format(borrow.get("tanggalKembali")) %></td>
                <% if ("overdue".equals(request.getAttribute("status"))) { %>
                    <td><%= borrow.get("keterlambatan") %></td>
                    <td>Rp <%= String.format("%,d", (Long)borrow.get("denda")) %></td>
                <% } %>
                <td>
                    <a href="returnItem?id=<%= borrow.get("idTransaksi") %>&idItem=<%= borrow.get("idItem") %>&status=<%= request.getAttribute("status") %>" 
                       class="btn btn-primary" onclick="return confirm('Konfirmasi pengembalian item?')">
                        <i class="fas fa-undo"></i> Kembalikan
                    </a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>


    <script>
        // Gunakan script yang sama dengan dashboard.jsp untuk toggle submenu
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
