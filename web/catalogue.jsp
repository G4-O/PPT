<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Buku" %>
<%@ page import="model.Peminjaman" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogue - Open Library</title>
    <!-- Add Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Add animate.css for animations -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1e40af;
            --background-color: #f8fafc;
            --card-background: #ffffff;
            --text-color: #1f2937;
            --border-radius: 12px;
        }

        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--background-color);
            color: var(--text-color);
            transition: background-color 0.3s ease;
        }

        /* Dark mode styles */
        body.dark-mode {
            --background-color: #1a1a1a;
            --card-background: #2d2d2d;
            --text-color: #ffffff;
        }

        header {
            background-color: var(--primary-color);
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .navbar-brand {
            font-size: 28px;
            font-weight: bold;
            color: #fff;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .navbar-brand i {
            font-size: 24px;
        }

        .navbar-nav {
            display: flex;
            list-style-type: none;
            margin: 0;
            padding: 0;
            gap: 20px;
        }

        .navbar-nav a {
            color: #fff;
            text-decoration: none;
            font-size: 16px;
            padding: 8px 16px;
            border-radius: var(--border-radius);
            transition: background-color 0.3s ease;
        }

        .navbar-nav a:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .content {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .page-title {
            font-size: 32px;
            margin-bottom: 30px;
            color: var(--text-color);
            text-align: center;
        }

        .search-bar {
            background-color: var(--card-background);
            padding: 20px;
            border-radius: var(--border-radius);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
            align-items: center;
        }

        .search-bar form {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            justify-content: center;
            width: 100%;
            max-width: 800px;
        }

        .search-bar input[type="text"] {
            flex: 1;
            min-width: 200px;
            padding: 12px 20px;
            border: 2px solid #e5e7eb;
            border-radius: var(--border-radius);
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        .search-bar input[type="text"]:focus {
            outline: none;
            border-color: var(--primary-color);
        }

        .search-bar select {
            padding: 12px 20px;
            border: 2px solid #e5e7eb;
            border-radius: var(--border-radius);
            font-size: 16px;
            background-color: var(--card-background);
            cursor: pointer;
        }

        .search-bar button {
            padding: 12px 24px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: var(--border-radius);
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .search-bar button:hover {
            background-color: var(--secondary-color);
        }

        .book-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
            padding: 20px 0;
        }

        .book-card {
            background-color: var(--card-background);
            border-radius: var(--border-radius);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.1);
        }

        .book-card img {
            width: 160px;
            height: 240px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 15px;
            transition: transform 0.3s ease;
        }

        .book-card:hover img {
            transform: scale(1.05);
        }

        .book-card h4 {
            margin: 15px 0 10px 0;
            font-size: 18px;
            color: var(--text-color);
            line-height: 1.4;
        }

        .book-card p {
            margin: 0 0 15px 0;
            font-size: 14px;
            color: #666;
        }

        .book-card .status {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #22c55e;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
        }

        .book-card .status.unavailable {
            background-color: #ef4444;
        }

        .book-card button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: var(--border-radius);
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .book-card button:hover {
            background-color: var(--secondary-color);
        }

        .book-card button:disabled {
            background-color: #9ca3af;
            cursor: not-allowed;
        }

        /* Dark mode toggle */
        .dark-mode-toggle {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease;
        }

        .dark-mode-toggle:hover {
            background-color: var(--secondary-color);
        }

        /* Loading animation */
        .loading {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1000;
        }

        .loading.active {
            display: block;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .navbar-nav {
                flex-direction: column;
                gap: 10px;
            }

            .book-list {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            }
        }

        /* No results message */
        .no-results {
            text-align: center;
            padding: 40px;
            font-size: 18px;
            color: #666;
        }

        /* Filters section */
        .filters {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .filter-btn {
            padding: 8px 16px;
            background-color: var(--card-background);
            border: 2px solid #e5e7eb;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-btn.active {
            background-color: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }

        /* Toast notifications */
        .toast {
            position: fixed;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #22c55e;
            color: white;
            padding: 12px 24px;
            border-radius: var(--border-radius);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            display: none;
        }

        .toast.error {
            background-color: #ef4444;
        }

        .toast.show {
            display: block;
            animation: slideUp 0.3s ease forwards;
        }

        @keyframes slideUp {
            from {
                transform: translate(-50%, 100%);
                opacity: 0;
            }
            to {
                transform: translate(-50%, 0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <header>
        <nav class="navbar">
            <a href="index.jsp" class="navbar-brand">
                <i class="fas fa-book-open"></i>
                Open Library
            </a>
            <ul class="navbar-nav">
                <% Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
                   String username = (String) session.getAttribute("loggedInUser");
                   if (isLoggedIn != null && isLoggedIn) { %>
                    <li><a href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
                    <li><a href="mybooks.jsp"><i class="fas fa-book"></i> My Books</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogue"><i class="fas fa-search"></i> Catalogue</a></li>
                    <li><span class="username"><i class="fas fa-user"></i> <%= username %></span></li>
                    <li><a href="logout" class="btn-logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                <% } else { %>
                    <li><a href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogue"><i class="fas fa-search"></i> Catalogue</a></li>
                    <li><a href="login.jsp" class="btn-login"><i class="fas fa-sign-in-alt"></i> Log In</a></li>
                    <li><a href="signup.jsp" class="btn-signup"><i class="fas fa-user-plus"></i> Sign Up</a></li>
                <% } %>
            </ul>
        </nav>
    </header>
    
    <div class="content">
        <h1 class="page-title animate__animated animate__fadeIn">Discover Your Next Read</h1>
        
        <!-- Search and Filter Form -->
        <div class="search-bar animate__animated animate__fadeInUp">
            <form action="searchCatalogue" method="get" id="searchForm">
                <input type="text" name="searchTerm" placeholder="Search by title, author, or ISBN..." id="searchInput">
                <select name="filterType" id="filterType">
                    <option value="all">All Types</option>
                    <option value="buku">Books</option>
                    <option value="dvd">DVDs</option>
                    <option value="majalah">Magazines</option>
                    <option value="jurnal">Journals</option>
                </select>
                <button type="submit">
                    <i class="fas fa-search"></i>
                    Search
                </button>
            </form>
        </div>

        <!-- Filter buttons -->
        <div class="filters animate__animated animate__fadeInUp" style="animation-delay: 0.2s">
            <button class="filter-btn active" data-filter="all">All</button>
            <button class="filter-btn" data-filter="available">Available Now</button>
            <button class="filter-btn" data-filter="popular">Most Popular</button>
            <button class="filter-btn" data-filter="new">New Arrivals</button>
        </div>
        
        <div class="book-list">
            <% 
            List<Buku> bukuList = (List<Buku>) request.getAttribute("bukuList");
            List<Peminjaman> peminjamanList = (List<Peminjaman>) request.getAttribute("peminjamanList");
            if (bukuList != null && !bukuList.isEmpty()) {
                for (Buku buku : bukuList) { 
                    boolean isAvailable = true;
                    if (peminjamanList != null) {
                        isAvailable = buku.isAvailable(peminjamanList);
                    }
            %>
            <div class="book-card animate__animated animate__fadeIn">
                <span class="status <%= isAvailable ? "" : "unavailable" %>">
                    <%= isAvailable ? "Available" : "Borrowed" %>
                </span>
                <img src="<%= buku.getGambarUrl() %>" alt="<%= buku.getJudul() %>" loading="lazy">
                <h4><%= buku.getJudul() %></h4>
                <p class="author"><i class="fas fa-user-edit"></i> <%= buku.getPenulis() %></p>
                <p class="year"><i class="fas fa-calendar"></i> <%= buku.getTahunTerbit() %></p>
                <form action="borrowItem" method="post" class="borrow-form">
                    <input type="hidden" name="idItem" value="<%= buku.getIdItem() %>">
                    <input type="hidden" name="itemType" value="<%= buku.getItemType() %>">
                    <button type="submit" <%= isAvailable ? "" : "disabled" %>>
                        <i class="fas fa-book-reader"></i>
                        <%= isAvailable ? "Borrow Now" : "Not Available" %>
                    </button>
                </form>
            </div>
            <%   }
               } else { %>
            <div class="no-results animate__animated animate__fadeIn">
                <i class="fas fa-search" style="font-size: 48px; color: #ccc; margin-bottom: 20px;"></i>
                <p>No books found matching your criteria.</p>
                <p>Try adjusting your search terms or filters.</p>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Loading animation -->
    <div class="loading">
        <i class="fas fa-spinner fa-spin fa-3x"></i>
    </div>

    <!-- Dark mode toggle -->
    <button class="dark-mode-toggle" id="darkModeToggle">
        <i class="fas fa-moon"></i>
    </button>

    <!-- Toast notification -->
    <div class="toast" id="toast"></div>

    <!-- Add JavaScript -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Dark mode toggle
            const darkModeToggle = document.getElementById('darkModeToggle');
            const body = document.body;
            const icon = darkModeToggle.querySelector('i');

            // Check for saved dark mode preference
            if (localStorage.getItem('darkMode') === 'enabled') {
                body.classList.add('dark-mode');
                icon.classList.replace('fa-moon', 'fa-sun');
            }

            darkModeToggle.addEventListener('click', () => {
                body.classList.toggle('dark-mode');
                const isDarkMode = body.classList.contains('dark-mode');
                localStorage.setItem('darkMode', isDarkMode ? 'enabled' : 'disabled');
                
                if (isDarkMode) {
                    icon.classList.replace('fa-moon', 'fa-sun');
                } else {
                    icon.classList.replace('fa-sun', 'fa-moon');
                }
            });

            // Filter buttons
            const filterButtons = document.querySelectorAll('.filter-btn');
            const bookCards = document.querySelectorAll('.book-card');

            filterButtons.forEach(button => {
                button.addEventListener('click', () => {
                    // Remove active class from all buttons
                    filterButtons.forEach(btn => btn.classList.remove('active'));
                    // Add active class to clicked button
                    button.classList.add('active');

                    const filter = button.dataset.filter;
                    
                    // Show loading animation
                    const loading = document.querySelector('.loading');
                    loading.classList.add('active');

                    // Simulate loading delay
                    setTimeout(() => {
                        filterBooks(filter);
                        loading.classList.remove('active');
                    }, 500);
                });
            });

            function filterBooks(filter) {
                bookCards.forEach(card => {
                    switch(filter) {
                        case 'available':
                            card.style.display = card.querySelector('.status').classList.contains('unavailable') ? 'none' : '';
                            break;
                        case 'popular':
                            // Add logic for popular books
                            break;
                        case 'new':
                            // Add logic for new arrivals
                            break;
                        default:
                            card.style.display = '';
                    }
                });
            }

            // Search form handling
            const searchForm = document.getElementById('searchForm');
            const searchInput = document.getElementById('searchInput');

            searchForm.addEventListener('submit', (e) => {
                e.preventDefault();
                
                const loading = document.querySelector('.loading');
                loading.classList.add('active');

                // Simulate search delay
                setTimeout(() => {
                    searchForm.submit();
                }, 500);
            });

            // Borrow form handling
            const borrowForms = document.querySelectorAll('.borrow-form');

            borrowForms.forEach(form => {
                form.addEventListener('submit', async (e) => {
                    e.preventDefault();

                    if (!isLoggedIn) {
                        showToast('Please log in to borrow books', 'error');
                        setTimeout(() => {
                            window.location.href = 'login.jsp';
                        }, 2000);
                        return;
                    }

                    try {
                        const response = await fetch(form.action, {
                            method: 'POST',
                            body: new FormData(form)
                        });

                        const data = await response.json();

                        if (data.success) {
                            showToast('Book borrowed successfully!');
                            const card = form.closest('.book-card');
                            const status = card.querySelector('.status');
                            const button = form.querySelector('button');
                            
                            status.classList.add('unavailable');
                            status.textContent = 'Borrowed';
                            button.disabled = true;
                            button.innerHTML = '<i class="fas fa-book-reader"></i> Not Available';
                        } else {
                            showToast(data.message || 'Failed to borrow book', 'error');
                        }
                    } catch (error) {
                        showToast('An error occurred', 'error');
                    }
                });
            });

            // Toast notification function
            function showToast(message, type = 'success') {
                const toast = document.getElementById('toast');
                toast.textContent = message;
                toast.className = `toast ${type} show`;

                setTimeout(() => {
                    toast.classList.remove('show');
                }, 3000);
            }

            // Lazy loading for images
            if ('IntersectionObserver' in window) {
                const imageObserver = new IntersectionObserver((entries, observer) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            const img = entry.target;
                            img.src = img.dataset.src;
                            observer.unobserve(img);
                        }
                    });
                });

                document.querySelectorAll('img[data-src]').forEach(img => {
                    imageObserver.observe(img);
                });
            }
        });
    </script>
</body>
</html>