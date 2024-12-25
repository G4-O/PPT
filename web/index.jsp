<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Open Library - Your Digital Reading companion</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        /* Global Styles */
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

        /* Enhanced Header */
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

        /* Enhanced Buttons */
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

        /* Hero Section */
        .hero {
            background: linear-gradient(rgba(37, 99, 235, 0.1), rgba(37, 99, 235, 0.05));
            padding: 80px 24px;
            text-align: center;
            animation: fadeIn 1s ease-out;
        }

        .hero h1 {
            font-size: 48px;
            font-weight: 800;
            color: var(--text-color);
            margin-bottom: 24px;
            animation: slideInDown 1s ease-out;
        }

        .hero p {
            font-size: 20px;
            color: #64748b;
            max-width: 600px;
            margin: 0 auto 40px;
            animation: slideInUp 1s ease-out;
        }

        /* Enhanced Search Bar */
        .search-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 24px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1);
            animation: slideInUp 1s ease-out;
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

        /* Book Categories */
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

        .category-icon {
            font-size: 32px;
            color: var(--primary-color);
            margin-bottom: 16px;
        }

        /* Enhanced Book Cards */
        

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
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

        /* Loading Animation */
        .loading-spinner {
            width: 40px;
            height: 40px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 20px auto;
            display: none;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Responsive Design */
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
        }
        
        .trending-section {
        padding: 40px 20px;
        max-width: 1400px;
        margin: 0 auto;
    }

    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
    }

    .trending-nav {
        display: flex;
        gap: 10px;
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

    .trending-books {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 30px;
        margin-top: 20px;
    }

    .book-card {
        background: white;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        position: relative;
    }

    .book-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 12px 20px rgba(0, 0, 0, 0.15);
    }

    .book-cover {
        position: relative;
        overflow: hidden;
    }

    .book-cover img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.3s ease;
    }

    .book-overlay {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.7);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .book-card:hover .book-overlay {
        opacity: 1;
    }

    .category {
        background: var(--primary-color);
        color: white;
        padding: 5px 15px;
        border-radius: 20px;
        font-size: 14px;
        margin-bottom: 15px;
    }

    .quick-view-btn {
        background: white;
        color: var(--primary-color);
        border: none;
        padding: 10px 20px;
        border-radius: 25px;
        cursor: pointer;
        font-weight: bold;
        transition: all 0.3s ease;
    }

    .quick-view-btn:hover {
        background: var(--primary-color);
        color: white;
    }

    .book-info {
        padding: 20px;
    }

    .book-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 5px;
        color: var(--text-color);
    }

    .book-author {
        color: #666;
        margin-bottom: 10px;
    }

    .book-rating {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 15px;
    }

    .stars {
        color: #ffd700;
    }

    .rating-count {
        color: #666;
        font-size: 14px;
    }

    .book-description {
        color: #444;
        font-size: 14px;
        margin-bottom: 20px;
        line-height: 1.5;
    }

    .book-actions {
        display: flex;
        gap: 10px;
    }

    .btn-read {
        flex: 1;
        background: var(--primary-color);
        color: white;
        border: none;
        padding: 10px;
        border-radius: 25px;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .btn-read:hover {
        background: var(--secondary-color);
    }

    .btn-save {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: #f0f0f0;
        border: none;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .btn-save:hover {
        background: #e0e0e0;
        transform: scale(1.1);
    }

    @media (max-width: 768px) {
        .trending-books {
            grid-template-columns: 1fr;
        }
    }
    
    .trending-books-rev {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 32px;
            padding: 40px 24px;
            max-width: 1400px;
            margin: 0 auto;
        }

        .book-card-rev {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
        }

        .book-card-rev:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1);
        }

        .book-cover-rev {
            position: relative;
            padding-top: 140%;
            background-size: cover;
            background-position: center;
        }

        .book-info-rev {
            padding: 24px;
        }

        .book-title-rev {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .book-author-rev {
            color: #64748b;
            margin-bottom: 16px;
        }

        .book-rating-rev {
            display: flex;
            align-items: center;
            gap: 4px;
            color: #eab308;
            margin-bottom: 16px;
        }
    </style>
</head>
<body>
    <header>
        <nav class="navbar">
            <a href="#" class="navbar-brand animate__animated animate__fadeIn">
                <i class="fas fa-book-reader"></i>
                Open Library
            </a>
            <ul class="navbar-nav">
                <%
                Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
                String username = (String) session.getAttribute("loggedInUser");
                if (isLoggedIn != null && isLoggedIn) {
                %>
                    <li><a href="#" class="nav-link"><i class="fas fa-book"></i> My Books</a></li>
                    <li><a href="<%= request.getContextPath() %>/catalogue" class="nav-link"><i class="fas fa-compass"></i> Explore</a></li>
                    <li><span style="color: white;"><i class="fas fa-user"></i> <%= username %></span></li>
                    <li><a href="logout" class="btn btn-primary">Logout</a></li>
                <%
                } else {
                %>
                    <li><a href="#" class="nav-link"><i class="fas fa-book"></i> My Books</a></li>
                    <li><a href="<%= request.getContextPath() %>/catalogue" class="nav-link"><i class="fas fa-compass"></i> Explore</a></li>
                    <li><a href="login.jsp" class="btn btn-primary">Log In</a></li>
                    <li><a href="signup.jsp" class="btn btn-secondary">Sign Up</a></li>
                <%
                }
                %>
            </ul>
        </nav>
    </header>

    <section class="hero">
        <h1>Discover Your Next Great Read</h1>
        <p>Access millions of eBooks, audiobooks, magazines, and more from your device.</p>
        
        <div class="search-container">
            <div class="search-bar">
                <input type="text" class="search-input" placeholder="Search by title, author, or ISBN...">
                <button class="search-btn">
                    <i class="fas fa-search"></i>
                    Search
                </button>
            </div>
            <div class="advanced-filters" style="display: none;">
                <!-- Advanced search filters will go here -->
            </div>
        </div>
    </section>

    <section class="categories">
        <div class="category-card">
            <i class="fa-solid fa-book fa-2xl"></i>
            <h3>Books</h3>
            <p>Explore all genres of books</p>
        </div>
        <div class="category-card">
            <i class="fa-solid fa-compact-disc fa-2xl"></i>
            <h3>DVD</h3>
            <p>Movies, musics, softwares, and more</p>
        </div>
        <div class="category-card">
            <i class="fa-solid fa-book-open fa-2xl"></i>
            <h3>Magazine</h3>
            <p>Get the most popular magazines here</p>
        </div>
        <div class="category-card">
            <i class="fa-solid fa-copy fa-2xl"></i>
            <h3>Journal</h3>
            <p>Center of high credible source</p>
        </div>
    </section>

    <section class="trending-books-rev">
        <div class="book-card-rev">
            <div class="book-cover-rev" style="background-image: url('images/bookcover2.jpg')"></div>
            <div class="book-info-rev">
                <div class="book-title-rev">The Midnight Library</div>
                <div class="book-author-rev">Matt Haig</div>
                <div class="book-rating-rev">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                    <span>(4.5)</span>
                </div>
                <button class="btn btn-primary">
                    <i class="fas fa-book-open"></i>
                    Read Now
                </button>
            </div>
        </div>
        <!-- Add more book cards as needed -->
    </section>

    <div class="loading-spinner"></div>

    <script>
        // Add interactive features
        document.addEventListener('DOMContentLoaded', function() {
            // ... previous JavaScript functions remain the same ...

            // Fixed notification system
            const createNotification = (message, type) => {
                const notification = document.createElement('div');
                notification.className = `notification ${type}`;
                
                // Fixed icon selection logic
                let iconName = 'info-circle'; // default icon
                if (type === 'success') {
                    iconName = 'check-circle';
                } else if (type === 'error') {
                    iconName = 'exclamation-circle';
                }
                
                notification.innerHTML = `
                    <i class="fas fa-${iconName}"></i>
                    <span>${message}</span>
                `;

                notification.style.cssText = `
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    padding: 12px 24px;
                    background: white;
                    border-radius: 8px;
                    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    animation: slideIn 0.3s ease-out;
                    z-index: 1000;
                `;

                document.body.appendChild(notification);

                setTimeout(() => {
                    notification.style.animation = 'slideOut 0.3s ease-out';
                    setTimeout(() => notification.remove(), 300);
                }, 3000);
            };

            // Test notification function
            const notifyBtn = document.createElement('button');
            notifyBtn.textContent = 'Test Notification';
            notifyBtn.onclick = () => {
                createNotification('Test message', 'success');
            };
            // You can uncomment this to add a test button
            // document.body.appendChild(notifyBtn);
        });
    </script>
    <section class="trending-section">
    <div class="section-header">
        <h2>Trending Books</h2>
        <div class="trending-nav">
            <button class="nav-btn prev-btn"><i class="fas fa-chevron-left"></i></button>
            <button class="nav-btn next-btn"><i class="fas fa-chevron-right"></i></button>
        </div>
    </div>
    
    <div class="trending-books">
        <div class="book-card">
            <div class="book-cover">
                <img src="images/bookcover1.jpg" alt="Atomic Habits">
                <div class="book-overlay">
                    <span class="category">Self Development</span>
                    <button class="quick-view-btn">Quick View</button>
                </div>
            </div>
            <div class="book-info">
                <h3 class="book-title">Atomic Habits</h3>
                <p class="book-author">James Clear</p>
                <div class="book-rating">
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <span class="rating-count">4.8 (2.1k reviews)</span>
                </div>
                <p class="book-description">Transform your life with tiny changes that yield remarkable results.</p>
                <div class="book-actions">
                    <button class="btn-read"><i class="fas fa-book-reader"></i> Read Now</button>
                    <button class="btn-save"><i class="fas fa-bookmark"></i></button>
                </div>
            </div>
        </div>

        <div class="book-card">
            <div class="book-cover">
                <img src="images/bookcover2.jpg" alt="The Midnight Library">
                <div class="book-overlay">
                    <span class="category">Fiction</span>
                    <button class="quick-view-btn">Quick View</button>
                </div>
            </div>
            <div class="book-info">
                <h3 class="book-title">The Midnight Library</h3>
                <p class="book-author">Matt Haig</p>
                <div class="book-rating">
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <span class="rating-count">4.9 (1.8k reviews)</span>
                </div>
                <p class="book-description">Between life and death there is a library with infinite possibilities.</p>
                <div class="book-actions">
                    <button class="btn-read"><i class="fas fa-book-reader"></i> Read Now</button>
                    <button class="btn-save"><i class="fas fa-bookmark"></i></button>
                </div>
            </div>
        </div>

        <div class="book-card">
            <div class="book-cover">
                <img src="images/bookcover3.jpg" alt="Project Hail Mary">
                <div class="book-overlay">
                    <span class="category">Sci-Fi</span>
                    <button class="quick-view-btn">Quick View</button>
                </div>
            </div>
            <div class="book-info">
                <h3 class="book-title">Project Hail Mary</h3>
                <p class="book-author">Andy Weir</p>
                <div class="book-rating">
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <span class="rating-count">4.9 (1.5k reviews)</span>
                </div>
                <p class="book-description">A lone astronaut must save humanity from extinction.</p>
                <div class="book-actions">
                    <button class="btn-read"><i class="fas fa-book-reader"></i> Read Now</button>
                    <button class="btn-save"><i class="fas fa-bookmark"></i></button>
                </div>
            </div>
        </div>

        <div class="book-card">
            <div class="book-cover">
                <img src="images/bookcover4.jpg" alt="Tomorrow, and Tomorrow, and Tomorrow">
                <div class="book-overlay">
                    <span class="category">Literary Fiction</span>
                    <button class="quick-view-btn">Quick View</button>
                </div>
            </div>
            <div class="book-info">
                <h3 class="book-title">Tomorrow, and Tomorrow, and Tomorrow</h3>
                <p class="book-author">Gabrielle Zevin</p>
                <div class="book-rating">
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <span class="rating-count">4.7 (980 reviews)</span>
                </div>
                <p class="book-description">A story of love, creativity, and the power of video games.</p>
                <div class="book-actions">
                    <button class="btn-read"><i class="fas fa-book-reader"></i> Read Now</button>
                    <button class="btn-save"><i class="fas fa-bookmark"></i></button>
                </div>
            </div>
        </div>
    </div>
</section>
    <script>
document.addEventListener('DOMContentLoaded', function() {
    const bookCards = document.querySelectorAll('.book-card');
    const saveButtons = document.querySelectorAll('.btn-save');
    const quickViewButtons = document.querySelectorAll('.quick-view-btn');
    
    // Save button functionality
    saveButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const icon = this.querySelector('i');
            if (icon.classList.contains('far')) {
                icon.classList.remove('far');
                icon.classList.add('fas');
                createNotification('Book added to your library!', 'success');
            } else {
                icon.classList.remove('fas');
                icon.classList.add('far');
                createNotification('Book removed from your library!', 'info');
            }
        });
    });

    // Quick view functionality
    quickViewButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Add your quick view modal logic here
            createNotification('Quick view feature coming soon!', 'info');
        });
    });

    // Read button functionality
    const readButtons = document.querySelectorAll('.btn-read');
    readButtons.forEach(button => {
        button.addEventListener('click', function() {
            const originalText = this.innerHTML;
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
            
            setTimeout(() => {
                this.innerHTML = originalText;
                createNotification('Opening book viewer...', 'success');
            }, 1500);
        });
    });

    // Initialize bookmark icons
    saveButtons.forEach(button => {
        button.innerHTML = '<i class="far fa-bookmark"></i>';
    });
});
</script>
</body>
</html>