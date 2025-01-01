<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Borrow Item - Open Library</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #1e3c72;
            --secondary-color: #2a5298;
            --accent-color: #3b82f6;
            --background-color: #f8fafc;
            --text-color: #1e293b;
            --card-background: #ffffff;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
        }

        header {
            background: var(--primary-color);
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .navbar {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            font-size: 32px;
            font-weight: 800;
            color: #fff;
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: transform 0.3s ease;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
        }

        .navbar-brand i {
            margin-right: 12px;
            font-size: 28px;
        }

        .navbar-nav {
            display: flex;
            gap: 24px;
            list-style: none;
            align-items: center;
            margin: 0;
            padding: 0;
        }
        
        .nav-link {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 8px;
            align-items: center;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }
        
        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: white;
            background-color: var(--secondary-color);
        }
    
        .btn:hover {
            background-color: #4c628a;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgba(59, 130, 246, 0.5);
        }

        .content {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 2rem;
            display: flex;
            align-items: flex-start;
        }

        .book-card {
            width: 180px;
            background-color: var(--card-background);
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            margin-right: 20px;
        }

        .book-card img {
            width: 120px;
            height: 180px;
        }

        .book-card h4 {
            margin: 10px 0 5px 0;
            font-size: 16px;
        }

        .book-card p {
            margin: 0;
            font-size: 14px;
            color: #666;
        }

        form {
            flex-grow: 1;
            background: white;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        form label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
        }

        form input[type="text"], form input[type="number"] {
            width: calc(100% - 16px);
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        form button {
            background-color: var(--primary-color);
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        form button:hover {
            background-color: var(--secondary-color);
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 16px;
            }
        }
    </style>
</head>
<body>
    <header>
        <nav class="navbar">
            <a href="index.jsp" class="navbar-brand">
                <i class="fas fa-book-reader"></i>
                Open Library
            </a>
            <ul class="navbar-nav">
                <% Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
                   String username = (String) session.getAttribute("loggedInUser");
                   if (isLoggedIn != null && isLoggedIn) { %>
                    <li><a href="index.jsp" class="nav-link"><i class="fas fa-home"></i> Home</a></li>
                    <li><a href="<%= request.getContextPath() %>/mybooks" class="nav-link"><i class="fas fa-book"></i> My Books</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogue" class="nav-link"><i class="fas fa-compass"></i> Explore</a></li>
                    <li><span style="color: white;"><i class="fas fa-user"></i> <%= username %></span></li>
                    <li><a href="logout" class="btn">LOGOUT</a></li>
                <% } else { %>
                    <li><a href="index.jsp" class="nav-link"><i class="fas fa-home"></i> Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogue" class="nav-link"><i class="fas fa-compass"></i> Explore</a></li>
                    <li><a href="login.jsp" class="btn">Log In</a></li>
                    <li><a href="signup.jsp" class="btn">Sign Up</a></li>
                <% } %>
            </ul>
        </nav>
    </header>

    <div class="content">
        <!-- Display Book Information -->
        <div class="book-card">
            <img src="<%= request.getAttribute("gambarUrl") %>" alt="<%= request.getAttribute("judul") %>">
            <h4><%= request.getAttribute("judul") %></h4>
            <p><%= request.getAttribute("penulis") %></p>
        </div>

        <!-- Borrow Form -->
        <form action="<%= request.getContextPath() %>/processBorrow" method="post">
            <!-- ID Item -->
            <input type="hidden" name="idItem" value="${idItem}">

            <p>judul: <%= request.getAttribute("judul") %></p>
            <p>penulis: <%= request.getAttribute("penulis") %></p>
            <p>deskripsi: <%= request.getAttribute("deskripsi") %></p>
            <p>klasifikasi: <%= request.getAttribute("klasifikasi") %></p>
            <p>views: <%= request.getAttribute("viewCount") %></p>
            <p>stok: <%= request.getAttribute("stok") %></p>
            <p>bidang: <%= request.getAttribute("bidang") %></p>

            <!-- Durasi Peminjaman -->
            <label for="durasiPinjam">Durasi Peminjaman (hari):</label>
            <input type="number" name="durasiPinjam" required>

            <!-- Tombol Submit -->
            <button type="submit">Confirm Borrow</button>
        </form>

    </div>
</body>
</html>
