<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ItemPerpustakaan" %>
<%@ page import="model.Buku" %>
<%@ page import="model.DVD" %>
<%@ page import="model.Jurnal" %>
<%@ page import="model.Majalah" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogue - Open Library</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideIn {
            from { transform: translateX(-100%); }
            to { transform: translateX(0); }
        }

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
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
            margin: 0px 25px 0px 25px;
            padding: 0;
        }

        .nav-link {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            margin: 0px 10px 0px -10px;
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
        }

        .btn-primary {
            margin-left: 24px;
            background-color: #435f91;
            color: white;
        }

        .btn-primary:hover {
            background-color: #4c628a;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgba(59, 130, 246, 0.5);
        }

        .btn-secondary {
            background-color: #6366f1;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #4f46e5;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgb(99 102 241 / 0.5);
        }

        .content {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
            animation: fadeIn 0.5s ease-out;
        }

        .search-container {
            background: white;
            padding: 1.5rem;
            border-radius: 0.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            margin: 0 auto 2rem;
            max-width: 800px;
        }

        .search-form {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .search-input {
            flex: 1;
            min-width: 200px;
            padding: 0.75rem 1rem;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            font-size: 1rem;
        }

        .search-select {
            padding: 0.75rem 1rem;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            font-size: 1rem;
            min-width: 150px;
        }

        .search-button {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-size: 1rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .catalogue-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 30px;
            padding: 20px 0;
        }

        .item-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            overflow: hidden;
            position: relative;
            animation: fadeIn 0.5s ease-out;
        }

        .item-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .item-image {
            width: 100%;
            height: 280px;
            object-fit: cover;
            transition: all 0.3s ease;
        }

        .item-info {
            padding: 20px;
        }
        
        .item-meta {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-top: 10px;
            color: #666;
            font-size: 14px;
        }

        .item-meta span {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .item-meta i {
            width: 16px;
            color: var(--primary-color);
        }


        .status-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
            color: white;
        }

        .status-badge.available {
            background: #4CAF50;
        }

        .status-badge.out-of-stock {
            background: #dc3545;
        }

        .borrow-button {
            width: 100%;
            padding: 10px;
            margin-top: 15px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .borrow-button.available {
            background-color: #1e3c72;
            color: white;
        }

        .borrow-button.available:hover {
            background-color: #1e3c72;
            transform: translateY(-2px);
        }

        .borrow-button.out-of-stock {
            background-color: #cccccc;
            color: white;
            cursor: not-allowed;
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 16px;
            }
            .navbar-nav {
                flex-direction: column;
                width: 100%;
            }
            .search-form {
                flex-direction: column;
            }
            .catalogue-grid {
                grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
            }
        }
    </style>
</head>
<body>
    <header>
        <nav class="navbar">
            <a href="index.jsp" class="navbar-brand animate__animated animate__fadeIn">
                <i class="fas fa-book-reader"></i> Open Library
            </a>
            <ul class="navbar-nav">
                <% Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
                   String username = (String) session.getAttribute("loggedInUser");
                   if (isLoggedIn != null && isLoggedIn) { %>
                    <li><a href="index.jsp" class="nav-link"><i class="fas fa-home"></i> Home</a></li>
                    <li><a href="<%= request.getContextPath() %>/mybooks" class="nav-link"><i class="fas fa-book"></i> My Books</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogue" class="nav-link"><i class="fas fa-compass"></i> Explore</a></li>
                    <li><span style="color: white;"><i class="fas fa-user"></i> <%= username %></span></li>
                    <li><a href="logout" class="btn btn-primary">Logout</a></li>
                <% } else { %>
                    <li><a href="index.jsp" class="nav-link"><i class="fas fa-home"></i> Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogue" class="nav-link"><i class="fas fa-compass"></i> Explore</a></li>
                    <li><a href="login.jsp" class="btn btn-primary">Log In</a></li>
                    <li><a href="signup.jsp" class="btn btn-secondary">Sign Up</a></li>
                <% } %>
            </ul>
        </nav>
    </header>

    <div class="content">
        <div class="search-container animate__animated animate__fadeIn">
            <form action="searchCatalogue" method="get" class="search-form">
                <input type="text" name="searchTerm" class="search-input" placeholder="Search by title, author, or ISBN...">
                <select name="filterType" class="search-select">
                    <option value="buku">Books</option>
                    <option value="dvd">DVDs</option>
                    <option value="majalah">Magazines</option>
                    <option value="jurnal">Journals</option>
                </select>
                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i> Search
                </button>
            </form>
        </div>

        <div class="catalogue-grid">
            <% List<ItemPerpustakaan> itemList = (List<ItemPerpustakaan>) request.getAttribute("itemList");
               if (itemList != null && !itemList.isEmpty()) {
                   for (ItemPerpustakaan item : itemList) { %>
                    <div class="item-card">
                        <div class="image-container">
                            <img src="<%= item.getGambarUrl() %>" alt="<%= item.getJudul() %>" class="item-image">
                            <div class="status-badge <%= item.getStok() > 0 ? "available" : "out-of-stock" %>">
                                <%= item.getStok() > 0 ? "Tersedia" : "Stok Habis" %>
                            </div>
                        </div>
                        <div class="item-info">
                            <h3 class="item-title"><%= item.getJudul() %></h3>
                            <div class="item-meta">
                                <% if (item instanceof Buku) { %>
                                    <span><i class="fas fa-user"></i> Penulis: <%= ((Buku)item).getPenulis() %></span>
                                <% } else if (item instanceof DVD) { %>
                                    <span><i class="fas fa-film"></i> Sutradara: <%= ((DVD)item).getSutradara() %></span>
                                <% } else if (item instanceof Jurnal) { %>
                                    <span><i class="fas fa-scroll"></i> Penulis: <%= ((Jurnal)item).getPenulis() %></span>
                                <% } else if (item instanceof Majalah) { %>
                                    <span><i class="fas fa-book"></i> Edisi: <%= ((Majalah)item).getEdisi() %></span>
                                <% } %>
                                <span><i class="fas fa-boxes"></i> Stok: <%= item.getStok() %></span>
                            </div>

                            <div class="item-actions">
                                <form action="<%= request.getContextPath() %>/borrowItem" method="post">
                                    <input type="hidden" name="idItem" value="<%= item.getIdItem() %>">
                                    <button type="submit" class="borrow-button <%= item.getStok() > 0 ? "available" : "out-of-stock" %>"
                                        <%= item.getStok() <= 0 ? "disabled" : "" %>>
                                        <i class="fas <%= item.getStok() > 0 ? "fa-hand-holding" : "fa-times-circle" %>"></i>
                                        <%= item.getStok() > 0 ? "Borrow Now" : "Out of Stock" %>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                <% }
               } else { %>
                <div class="no-results">
                    <p>Tidak ada item yang tersedia saat ini.</p>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
