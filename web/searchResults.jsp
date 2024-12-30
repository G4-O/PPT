<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ItemPerpustakaan" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results - Open Library</title>
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
            background-color: #f8f9fa;
            color: #333;
            line-height: 1.6;
        }

        header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
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

        .navbar-nav li {
            animation: fadeIn 0.5s ease-out forwards;
            opacity: 0;
        }

        .navbar-nav li:nth-child(1) { animation-delay: 0.1s; }
        .navbar-nav li:nth-child(2) { animation-delay: 0.2s; }
        .navbar-nav li:nth-child(3) { animation-delay: 0.3s; }
        .navbar-nav li:nth-child(4) { animation-delay: 0.4s; }

        /*.navbar-nav a {
            color: #fff;
            text-decoration: none;
            font-size: 16px;
            padding: 8px 15px;
            border-radius: 20px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .navbar-nav a:hover {
            background: rgba(255,255,255,0.1);
            transform: translateY(-2px);
        }*/
        
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

        .content h2 {
            color: #1e3c72;
            font-size: 32px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .search-summary {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            animation: fadeIn 0.5s ease-out;
        }

        .search-summary p {
            margin: 0;
            color: #666;
            font-size: 16px;
        }

        .filter-tags {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            flex-wrap: wrap;
        }

        .filter-tag {
            background: #e9ecef;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 14px;
            color: #495057;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .filter-tag i {
            cursor: pointer;
            color: #1e3c72;
        }

        .book-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 30px;
            padding: 20px 0;
        }

        .book-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            overflow: hidden;
            position: relative;
            animation: fadeIn 0.5s ease-out;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .book-card img {
            width: 100%;
            height: 280px;
            object-fit: cover;
            transition: all 0.3s ease;
        }

        .book-card:hover img {
            transform: scale(1.05);
        }

        .book-info {
            padding: 20px;
        }

        .book-card h4 {
            margin: 0 0 10px 0;
            font-size: 18px;
            color: #1e3c72;
        }

        .book-card p {
            margin: 0;
            color: #666;
            font-size: 14px;
        }

        .book-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
            color: #666;
            font-size: 14px;
        }

        .book-card button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .book-card button:hover {
            background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
        }

        .status-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
            background: #4CAF50;
            color: white;
        }

        .no-results {
            text-align: center;
            grid-column: 1/-1;
            padding: 50px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .no-results i {
            font-size: 48px;
            color: #ccc;
            margin-bottom: 20px;
        }
        
        .nav-btn {
            background: var(--primary-color);
            color: white;
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .nav-btn:hover {
            background: var(--secondary-color);
            transform: scale(1.1);
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

            .navbar-nav li {
                margin: 5px;
            }

            .book-list {
                grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
            }
        }
    </style>
</head>
<body>
    <header>
        <nav class="navbar">
            <a href="index.jsp" class="navbar-brand animate__animated animate__fadeIn">
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
        <h2><i class="fas fa-search"></i> Search Results</h2>

        <div class="search-summary">
            <p>Found <strong>${searchResults.size()}</strong> items matching your search</p>
            <div class="filter-tags">
                <span class="filter-tag">
                    "${param.searchTerm}"
                    <i class="fas fa-times"></i>
                </span>
                <span class="filter-tag">
                    Type: ${param.filterType}
                    <i class="fas fa-times"></i>
                </span>
            </div>
        </div>
        
        <div class="book-list">
            <% List<ItemPerpustakaan> searchResults = (List<ItemPerpustakaan>) request.getAttribute("searchResults");
               if (searchResults != null && !searchResults.isEmpty()) {
                   for (ItemPerpustakaan item : searchResults) { %>
            <div class="book-card">
                <div class="status-badge">Available</div>
                <img src="<%= item.getGambarUrl() %>" alt="<%= item.getJudul() %>">
                <div class="book-info">
                    <h4><%= item.getJudul() %></h4>
                    <div class="book-meta">
                        <span><i class="fas fa-bookmark"></i> <%= item.getItemType() %></span>
                        <span><i class="fas fa-star"></i> 4.5/5</span>
                    </div>
                    <form action="<%= request.getContextPath() %>/borrowItem" method="post">
                        <input type="hidden" name="idItem" value="<%= item.getIdItem() %>">
                        <input type="hidden" name="itemType" value="<%= item.getItemType() %>">
                        <button type="submit">
                            <i class="fas fa-hand-holding"></i>
                            Borrow Now
                        </button>
                    </form>
                </div>
            </div>
            <% }
               } else { %>
            <div class="no-results">
                <i class="fas fa-search"></i>
                <h3>No items found</h3>
                <p>Try adjusting your search terms or filters to find what you're looking for.</p>
                <a href="${pageContext.request.contextPath}/catalogue" style="color: #1e3c72; text-decoration: none; margin-top: 15px; display: inline-block;">
                    <i class="fas fa-arrow-left"></i> Back to Catalogue
                </a>
            </div>
            <% } %>
        </div>
    </div>

    
</body>
</html>