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

        /* Keep existing navbar styles */
        
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
        
        .content {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 2rem;
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 2rem;
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .book-card {
            background-color: var(--card-background);
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: sticky;
            top: 100px;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
        }

        .book-image {
            width: 180px;
            height: 270px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            margin-bottom: 1.5rem;
            transition: transform 0.3s ease;
        }

        .book-image:hover {
            transform: scale(1.05);
        }

        .book-info {
            background: white;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .book-info h2 {
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            font-size: 1.8rem;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .info-item {
            background: #f8fafc;
            padding: 1rem;
            border-radius: 8px;
            transition: transform 0.2s ease;
        }

        .info-item:hover {
            transform: translateY(-2px);
        }

        .info-item h4 {
            color: var(--secondary-color);
            margin: 0 0 0.5rem 0;
        }

        .description {
            background: #f8fafc;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }

        .borrow-form {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--secondary-color);
            font-weight: 600;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            transition: border-color 0.2s ease;
            font-size: 1rem;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--accent-color);
        }

        .duration-slider {
            width: 100%;
            margin-top: 1rem;
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
            font-size: 1.1rem;
        }

        .submit-btn:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(42, 82, 152, 0.3);
        }

        .stock-status {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            margin-top: 1rem;
        }

        .in-stock {
            background: #dcfce7;
            color: #166534;
        }

        .low-stock {
            background: #fef9c3;
            color: #854d0e;
        }

        @media (max-width: 768px) {
            .content {
                grid-template-columns: 1fr;
            }
            
            .book-card {
                position: static;
                margin-bottom: 2rem;
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
            <p class="author"><%= request.getAttribute("penulis") %></p>
            <div class="stock-status <%= Integer.parseInt(request.getAttribute("stok").toString()) > 5 ? "in-stock" : "low-stock" %>">
                <i class="fas fa-books"></i> 
                <%= Integer.parseInt(request.getAttribute("stok").toString()) %> copies available
            </div>
        </div>

        <div class="book-info">
            <h2>Book Details</h2>
            <div class="info-grid">
                <div class="info-item">
                    <h4><i class="fas fa-user-edit"></i> Author</h4>
                    <p><%= request.getAttribute("penulis") %></p>
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

            <div class="description">
                <h4><i class="fas fa-info-circle"></i> Description</h4>
                <p><%= request.getAttribute("deskripsi") %></p>
            </div>

            <form action="<%= request.getContextPath() %>/processBorrow" method="post" class="borrow-form">
                <input type="hidden" name="idItem" value="${idItem}">
                
                <div class="form-group">
                    <label for="durasiPinjam">Borrowing Duration (days)</label>
                    <input type="range" id="durasiPinjam" name="durasiPinjam" min="1" max="30" value="7" class="duration-slider" oninput="updateDurationValue(this.value)">
                    <p id="durationValue">7 days</p>
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-book-reader"></i> Confirm Borrowing
                </button>
            </form>
        </div>
    </div>

    <script>
        function updateDurationValue(val) {
            document.getElementById('durationValue').textContent = val + ' days';
        }

        // Add smooth scroll behavior
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Add form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const duration = document.getElementById('durasiPinjam').value;
            if (duration < 1 || duration > 30) {
                e.preventDefault();
                alert('Please select a duration between 1 and 30 days');
            }
        });

        // Add loading animation on form submit
        document.querySelector('.submit-btn').addEventListener('click', function() {
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
        });
    </script>
</body>
</html>