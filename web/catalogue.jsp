<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Buku" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogue - Open Library</title>
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
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .search-container {
            background: white;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
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
            transition: background-color 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .search-button:hover {
            background: var(--secondary-color);
        }

        .catalogue-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .book-card {
            background: white;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: fadeIn 0.5s ease-out;
        }

        .book-card:hover {
            transform: translateY(-0.5rem);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }

        .book-image {
            width: 100%;
            height: 300px;
            object-fit: cover;
        }

        .book-info {
            padding: 1.5rem;
        }

        .book-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin: 0 0 0.5rem 0;
        }

        .book-author {
            color: #6b7280;
            font-size: 0.875rem;
            margin-bottom: 1rem;
        }

        .book-actions {
            display: flex;
            gap: 0.5rem;
        }

        .borrow-button {
            flex: 1;
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 35px;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .borrow-button:hover {
            background: var(--secondary-color);
        }

        .save-button {
            background: #f3f4f6;
            border: none;
            padding: 0.75rem;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .save-button:hover {
            background: #e5e7eb;
        }

        .loading-spinner {
            display: none;
            width: 2.5rem;
            height: 2.5rem;
            border: 0.25rem solid #f3f4f6;
            border-top-color: var(--primary-color);
            border-radius: 50%;
            margin: 2rem auto;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(1rem); }
            to { opacity: 1; transform: translateY(0); }
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

        @keyframes slideInUp {
            from {
                transform: translateY(20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
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

        .notification {
            position: fixed;
            bottom: 1rem;
            right: 1rem;
            background: white;
            padding: 1rem;
            border-radius: 0.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            animation: slideIn 0.3s ease-out;
            z-index: 1000;
        }

        @keyframes slideIn {
            from { transform: translateX(100%); }
            to { transform: translateX(0); }
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
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
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
                    <li><a href="#" class="nav-link"><i class="fas fa-book"></i> My Books</a></li>
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
                    <i class="fas fa-search"></i>
                    Search
                </button>
            </form>
        </div>

        <div class="catalogue-grid">
    <% List<Buku> bukuList = (List<Buku>) request.getAttribute("bukuList");
       if (bukuList != null && !bukuList.isEmpty()) {
           for (Buku buku : bukuList) { %>
        <div class="book-card">
            <img src="<%= buku.getGambarUrl() %>" alt="<%= buku.getJudul() %>" class="book-image">
            <div class="book-info">
                <h3 class="book-title"><%= buku.getJudul() %></h3>
                <p class="book-author"><i class="fas fa-user"></i> <%= buku.getPenulis() %></p>
                <div class="book-actions">
                    <!-- Form untuk Borrow Now -->
                    <form action="<%= request.getContextPath() %>/borrowItem" method="post" style="display: inline-flex;">
                        <input type="hidden" name="idItem" value="<%= buku.getIdItem() %>">
                        <input type="hidden" name="itemType" value="<%= buku.getItemType() %>"> <!-- Tambahkan itemType -->
                        <button type="submit" class="borrow-button">
                            <i class="fas fa-book-reader"></i>
                            Borrow Now
                        </button>
                    </form>
                    <!-- Tombol Save -->
                    <button class="save-button" onclick="saveBook(this)">
                        <i class="far fa-bookmark"></i>
                    </button>
                </div>
            </div>
        </div>
    <%   }
       } else { %>
        <div class="no-results animate__animated animate__fadeIn">
            <p>No books available at the moment.</p>
        </div>
    <% } %>
</div>


        <div class="loading-spinner"></div>
    </div>

    <script>
        function borrowBook(bookId) {
            const button = event.target.closest('.borrow-button');
            const originalContent = button.innerHTML;
            button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            button.disabled = true;

            fetch('borrowItem', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `idItem=${bookId}&itemType=buku`
            })
            .then(response => response.json())
            .then(data => {
                showNotification(data.success ? 'Book borrowed successfully!' : 'Failed to borrow book', data.success ? 'success' : 'error');
            })
            .catch(error => {
                showNotification('An error occurred', 'error');
            })
            .finally(() => {
                button.innerHTML = originalContent;
                button.disabled = false;
            });
        }

        function saveBook(button) {
            const icon = button.querySelector('i');
            const isSaved = icon.classList.contains('fas');
            
            icon.classList.toggle('far');
            icon.classList.toggle('fas');
            
            showNotification(isSaved ? 'Removed from saved items' : 'Added to saved items', 'success');
        }

        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.className = `notification ${type}`;
            notification.innerHTML = `
                <i class="fas fa-check-circle"></i>
                ${message}
            `;
            
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.style.animation = 'slideOut 0.3s ease-out forwards';
                setTimeout(() => notification.remove(), 300);
            }, 3000);
        }

        // Add loading animation when searching
        document.querySelector('.search-form').addEventListener('submit', function() {
            document.querySelector('.loading-spinner').style.display = 'block';
        });
    </script>
</body>
</html>