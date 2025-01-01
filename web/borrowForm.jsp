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

        /* Keeping your existing navbar styles */
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
            margin: 2rem auto;
            padding: 2rem;
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 2rem;
            animation: fadeIn 0.5s ease-out;
        }

        .book-card {
            background: var(--card-background);
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            padding: 1.5rem;
            position: sticky;
            top: 100px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }

        .book-image {
            width: 100%;
            height: auto;
            border-radius: 10px;
            margin-bottom: 1rem;
            transition: transform 0.3s ease;
        }

        .book-image:hover {
            transform: scale(1.05);
        }

        .book-details {
            background: var(--card-background);
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin: 2rem 0;
        }

        .info-item {
            background: #f8fafc;
            padding: 1.5rem;
            border-radius: 10px;
            transition: transform 0.3s ease;
        }

        .info-item:hover {
            transform: translateY(-5px);
        }

        .info-item h4 {
            color: var(--primary-color);
            margin: 0 0 0.5rem 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .info-item p {
            margin: 0;
            color: var(--text-color);
        }

        .borrow-form {
            margin-top: 2rem;
            padding: 2rem;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--primary-color);
            font-weight: 600;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            transition: border-color 0.3s ease;
            font-size: 1rem;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .stock-status {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            margin: 1rem 0;
            animation: pulse 2s infinite;
        }

        .in-stock {
            background: #dcfce7;
            color: #166534;
        }

        .low-stock {
            background: #fff7ed;
            color: #9a3412;
        }

        .submit-btn {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 1rem;
        }

        .submit-btn:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        @media (max-width: 768px) {
            .content {
                grid-template-columns: 1fr;
            }
            
            .book-card {
                position: static;
            }
        }
    </style>
</head>
<body>
    <!-- Keep existing header/navbar code -->
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
        <div class="book-card">
            <img src="<%= request.getAttribute("gambarUrl") %>" alt="<%= request.getAttribute("judul") %>" class="book-image">
            <h3><%= request.getAttribute("judul") %></h3>
            <p class="author">
                <% if (request.getAttribute("type").equals("dvd")) { %>
                    <i class="fas fa-video"></i> <%= request.getAttribute("sutradara") %>
                <% } else { %>
                    <i class="fas fa-pen"></i> <%= request.getAttribute("penulis") %>
                <% } %>
            </p>
            <div class="stock-status <%= Integer.parseInt(request.getAttribute("stok").toString()) > 5 ? "in-stock" : "low-stock" %>">
                <i class="fas fa-books"></i> 
                <%= Integer.parseInt(request.getAttribute("stok").toString()) %> copies available
            </div>
        </div>

        <div class="book-details">
            <h2><i class="fas fa-info-circle"></i> <%= request.getAttribute("typeName") %> Details</h2>
            
            <div class="info-grid">
                <div class="info-item">
                    <h4>
                        <% if (request.getAttribute("type").equals("dvd")) { %>
                            <i class="fas fa-user-edit"></i> Director
                        <% } else { %>
                            <i class="fas fa-user-edit"></i> Author
                        <% } %>
                    </h4>
                    <p>
                        <% if (request.getAttribute("type").equals("dvd")) { %>
                            <%= request.getAttribute("sutradara") %>
                        <% } else { %>
                            <%= request.getAttribute("penulis") %>
                        <% } %>
                    </p>
                </div>
                
                <div class="info-item">
                    <h4><i class="fas fa-tags"></i> Classification</h4>
                    <p><%= request.getAttribute("klasifikasi") %></p>
                </div>
                
                <div class="info-item">
                    <h4><i class="fas fa-eye"></i> Views</h4>
                    <p><%= request.getAttribute("viewCount") %></p>
                </div>
                
                <div class="info-item">
                    <h4><i class="fas fa-bookmark"></i> Field</h4>
                    <p><%= request.getAttribute("bidang") %></p>
                </div>
            </div>

            <div class="info-item" style="margin-top: 1rem;">
                <h4><i class="fas fa-align-left"></i> Description</h4>
                <p><%= request.getAttribute("deskripsi") %></p>
            </div>

            <form action="processBorrow" method="post" class="borrow-form">
                <input type="hidden" name="idItem" value="<%= request.getAttribute("idItem") %>">
                
                <div class="form-group">
                    <label for="durasiPinjam">
                        <i class="fas fa-calendar-alt"></i> 
                        Borrow Duration (days)
                    </label>
                    <input type="number" 
                           id="durasiPinjam" 
                           name="durasiPinjam" 
                           class="form-control" 
                           required 
                           min="1" 
                           max="30"
                           value="7">
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-check-circle"></i> 
                    Confirm Borrow
                </button>
            </form>
        </div>
    </div>

    <script>
        // Add smooth scrolling
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Form validation and enhancement
        const form = document.querySelector('form');
        const durasiInput = document.getElementById('durasiPinjam');

        form.addEventListener('submit', (e) => {
            e.preventDefault();
            
            const duration = parseInt(durasiInput.value);
            if (duration < 1 || duration > 30) {
                alert('Please enter a duration between 1 and 30 days');
                return;
            }

            // Add loading state to button
            const submitBtn = form.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            submitBtn.disabled = true;

            // Submit the form after a brief delay to show the loading state
            setTimeout(() => {
                form.submit();
            }, 500);
        });

        // Dynamic stock status color
        const stockStatus = document.querySelector('.stock-status');
        const stockCount = parseInt('<%= request.getAttribute("stok") %>');
        
        if (stockCount <= 3) {
            stockStatus.style.animation = 'pulse 1s infinite';
        }
    </script>
</body>
</html>