<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.TrendingItem" %>
<%@ page import="controller.TrendingController" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Open Library - Your Digital Reading Companion</title>
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
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
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
            align-items: center;
            list-style: none;
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
            box-shadow: 0 4px 6px -1px rgb(59 130 246 / 0.5);
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

        .hero {
            background: linear-gradient(rgba(37, 99, 235, 0.1), rgba(37, 99, 235, 0.05));
            padding: 80px 24px;
            text-align: center;
        }

        .hero h1 {
            font-size: 48px;
            font-weight: 800;
            color: var(--text-color);
            margin-bottom: 24px;
        }

        .hero p {
            font-size: 20px;
            color: #64748b;
            max-width: 600px;
            margin: 0 auto 40px;
        }

        .search-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 24px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1);
        }

        .search-bar {
            display: flex;
            gap: 12px;
            margin-bottom: 16px;
        }

        .search-input {
            flex: 1;
            padding: 16px 24px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgb(59 130 246 / 0.3);
        }

        .search-btn {
            padding: 16px 32px;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-btn:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
        }

        .categories {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 24px;
            padding: 40px 24px;
            max-width: 1400px;
            margin: 0 auto;
        }

        .category-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
        }

        .category-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1);
        }

        .trending-section {
            padding: 40px 20px;
            max-width: 1400px;
            margin: 0 auto;
        }

        .section-header {
            margin-bottom: 30px;
        }

        .section-header h2 {
            color: var(--primary-color);
            font-size: 24px;
            font-weight: 700;
        }

        .catalogue-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
        }

        .item-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .item-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 20px rgba(0, 0, 0, 0.15);
        }

        .no-items {
            grid-column: 1 / -1;
            text-align: center;
            padding: 40px;
            color: #666;
        }

        .categories a {
            text-decoration: none;
            color: inherit;
        }

        .categories a:hover {
            text-decoration: none;
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
            background-color: #4CAF50;
            color: white;
        }

        .borrow-button.available:hover {
            background-color: #45a049;
            transform: translateY(-2px);
        }

        .borrow-button.out-of-stock {
            background-color: #dc3545;
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
            .hero h1 {
                font-size: 36px;
            }
            .hero p {
                font-size: 18px;
            }
            .search-bar {
                flex-direction: column;
            }
            .search-btn {
                width: 100%;
            }
            .catalogue-grid {
                grid-template-columns: 1fr;
            }
            
            .item-image {
                width: 100%;
                height: 280px;
                object-fit: cover;
            }

            .image-container {
                position: relative;
            }

            .item-info {
                padding: 20px;
            }

            .item-title {
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 12px;
                color: var(--text-color);
            }

            .item-meta {
                display: flex;
                flex-direction: column;
                gap: 8px;
                margin-bottom: 15px;
                color: #666;
                font-size: 14px;
            }

            .item-meta span {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .item-meta i {
                color: var(--primary-color);
                width: 16px;
            }

            .borrow-button {
                width: 100%;
                padding: 12px;
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
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
                color: white;
            }

            .borrow-button.out-of-stock {
                background: #cccccc;
                color: white;
                cursor: not-allowed;
            }

            .borrow-button.available:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

        }
    </style>
</head>
<body>
    <header>
        <nav class="navbar">
            <a href="#" class="navbar-brand">
                <i class="fas fa-book-reader"></i> Open Library
            </a>
            <ul class="navbar-nav">
                <% Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
                   String username = (String) session.getAttribute("loggedInUser");
                   if (isLoggedIn != null && isLoggedIn) { %>
                    <li><a href="<%= request.getContextPath() %>/mybooks" class="nav-link"><i class="fas fa-book"></i> My Books</a></li>
                    <li><a href="<%= request.getContextPath() %>/catalogue" class="nav-link"><i class="fas fa-compass"></i> Explore</a></li>
                    <li><span style="color: white;"><i class="fas fa-user"></i> <%= username %></span></li>
                    <li><a href="logout" class="btn btn-primary">Logout</a></li>
                <% } else { %>
                    <li><a href="<%= request.getContextPath() %>/mybooks" class="nav-link"><i class="fas fa-book"></i> My Books</a></li>
                    <li><a href="<%= request.getContextPath() %>/catalogue" class="nav-link"><i class="fas fa-compass"></i> Explore</a></li>
                    <li><a href="login.jsp" class="btn btn-primary">Log In</a></li>
                    <li><a href="signup.jsp" class="btn btn-secondary">Sign Up</a></li>
                <% } %>
            </ul>
        </nav>
    </header>

    <section class="hero">
        <h1>Discover Your Next Great Read</h1>
        <p>Access millions of eBooks, audiobooks, magazines, and more from your device.</p>
        <div class="search-container">
            <form action="<%= request.getContextPath() %>/searchCatalogue" method="get" class="search-bar">
                <input type="text" name="searchTerm" class="search-input" placeholder="Search by title">
                <button type="submit" class="search-btn">
                    <i class="fas fa-search"></i> Search
                </button>
            </form>
        </div>
    </section>

    <section class="categories">
        <a href="http://localhost:8080/PERPUSTERBUKA/searchCatalogue?searchTerm=&filterType=buku">
            <div class="category-card">
                <i class="fa-solid fa-book fa-2xl"></i>
                <h3>Books</h3>
                <p>Explore all genres of books</p>
            </div>
        </a>
        <a href="http://localhost:8080/PERPUSTERBUKA/searchCatalogue?searchTerm=&filterType=dvd">
            <div class="category-card">
                <i class="fa-solid fa-compact-disc fa-2xl"></i>
                <h3>DVD</h3>
                <p>Movies, musics, softwares, and more</p>
            </div>
        </a>
        <a href="http://localhost:8080/PERPUSTERBUKA/searchCatalogue?searchTerm=&filterType=majalah">
            <div class="category-card">
                <i class="fa-solid fa-book-open fa-2xl"></i>
                <h3>Magazine</h3>
                <p>Get the most popular magazines here</p>
            </div>
        </a>
        <a href="http://localhost:8080/PERPUSTERBUKA/searchCatalogue?searchTerm=&filterType=jurnal">
            <div class="category-card">
                <i class="fa-solid fa-copy fa-2xl"></i>
                <h3>Journal</h3>
                <p>Center of high credible source</p>
            </div>
        </a>
    </section>

    <section class="trending-section">
    <div class="section-header">
        <h2>Trending Items</h2>
    </div>
    <div class="catalogue-grid">
        <%
            TrendingController trendingController = new TrendingController();
            List<TrendingItem> trendingItems = trendingController.getTrendingItems();

            // Debugging output
            if (trendingItems == null) {
                out.println("<p style='color:red;'>Debug: trendingItems is null.</p>");
            } else if (trendingItems.isEmpty()) {
                out.println("<p style='color:red;'>Debug: No items found in trendingItems.</p>");
            } else {
                out.println("<p style='color:green;'>Debug: Found " + trendingItems.size() + " items.</p>");
            }

            if (trendingItems != null && !trendingItems.isEmpty()) {
                for (TrendingItem item : trendingItems) {
                    // Debugging untuk setiap item
                    out.println("<p style='color:blue;'>Debug: Item ID=" + item.getIdItem() + ", Judul=" + item.getJudul() + ", Gambar URL=" + item.getGambarUrl() + "</p>");
        %>
                    <div class="item-card">
                        <!-- Bagian gambar -->
                        <div class="image-container">
                            <% 
                                String imageUrl = item.getGambarUrl();
                                if (imageUrl == null || imageUrl.isEmpty()) {
                                    imageUrl = request.getContextPath() + "/images/default-image.png"; // Gambar default jika URL kosong
                                }
                            %>
                            <img src="<%= imageUrl %>" alt="<%= item.getJudul() %>" class="item-image">
                            <div class="status-badge <%= item.getStok() > 0 ? "available" : "out-of-stock" %>">
                                <%= item.getStok() > 0 ? "Tersedia" : "Stok Habis" %>
                            </div>
                        </div>

                        <!-- Informasi item -->
                        <div class="item-info">
                            <h3 class="item-title"><%= item.getJudul() %></h3>
                            <div class="item-meta">
                                <span><i class="fas fa-user"></i> <%= item.getDetail() %></span>
                                <span><i class="fas fa-chart-line"></i> <%= item.getJumlahPeminjaman() %> peminjaman</span>
                                <span><i class="fas fa-boxes"></i> Stok: <%= item.getStok() %></span>
                            </div>

                            <!-- Tombol pinjam -->
                            <form action="<%= request.getContextPath() %>/processBorrow" method="post">
                                <input type="hidden" name="idItem" value="<%= item.getIdItem() %>">
                                <% 
                                    boolean isAvailable = item.getStok() > 0;
                                    String buttonClass = isAvailable ? "available" : "out-of-stock";
                                    String buttonText = isAvailable ? "Pinjam Sekarang" : "Stok Habis";
                                    String buttonIcon = isAvailable ? "fa-hand-holding" : "fa-times-circle";
                                %>
                                <button type="submit"
                                        class="borrow-button <%= buttonClass %>"
                                        <% if (!isAvailable) { %> disabled <% } %>>
                                    <i class="fas <%= buttonIcon %>"></i>
                                    <%= buttonText %>
                                </button>
                            </form>
                        </div>
                    </div>
        <% 
                }
            } else { 
        %>
                <!-- Pesan jika tidak ada item -->
                <div class="no-items">
                    <p>Tidak ada item trending saat ini</p>
                </div>
        <% 
            } 
        %>
    </div>
</section>



</body>
</html>

