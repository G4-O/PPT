<html>
<head>
    <meta charset="UTF-8">
    <title>Catalogue - Open Library</title>
    <style>
        /* CSS styling to match the provided design */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f7f7;
        }
        header {
            background-color: #007bff;
            padding: 10px 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        .navbar-brand {
            font-size: 24px;
            font-weight: bold;
            color: #fff;
            text-decoration: none;
        }
        .navbar-nav {
            display: flex;
            list-style-type: none;
            margin: 0;
            padding: 0;
        }
        .navbar-nav li {
            margin-left: 20px;
        }
        .navbar-nav a {
            color: #fff;
            text-decoration: none;
            font-size: 16px;
        }
        .navbar-nav a:hover {
            color: #d9d9d9;
        }
        
        .btn-login {
            background-color: green;
            padding: 5px 7px 5px 7px;
            border-radius: 8px;
        }
        
        .btn-signup {
            background-color: blueviolet;
            padding: 5px 7px 5px 7px;
            border-radius: 8px;
        }
        
        .content {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .search-bar {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
        }
        .search-bar input[type="text"] {
            width: 300px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .search-bar button {
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            margin-left: 10px;
            border-radius: 4px;
        }
        .search-bar button:hover {
            background-color: #0056b3;
        }
        .search-bar .advanced-search {
            margin-left: 20px;
            color: #007bff;
            cursor: pointer;
        }
        .search-bar .advanced-search:hover {
            text-decoration: underline;
        }
        .book-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .book-card {
            width: 180px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
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
        .book-card button {
            margin-top: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
        }
        .book-card button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <header>
        <nav class="navbar">
            <a href="index.jsp" class="navbar-brand">Open Library</a>
            <ul class="navbar-nav">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="catalogue.jsp">Catalogue</a></li>
                <li><a href="login.jsp" class="btn-login">Log In</a></li>
                <li><a href="signup.jsp" class="btn-signup">Sign Up</a></li>
            </ul>
        </nav>
    </header>
    
    <div class="content">
        <h2>Catalogue</h2>
        
        <div class="search-bar">
            <input type="text" placeholder="Search for books...">
            <button><i class="fas fa-search"></i> Search</button>
            <span class="advanced-search">Advanced Search</span>
        </div>
        
        <div class="book-list">
            <div class="book-card">
                <img src="control-your-mind.jpg" alt="Control Your Mind and Master Your Feelings">
                <h4>Control Your Mind and Master Your Feelings</h4>
                <p>Eric Robertson</p>
                <button>Read</button>
            </div>
            <div class="book-card">
                <img src="atomic-habits.jpg" alt="Atomic Habits">
                <h4>Atomic Habits</h4>
                <p>James Clear</p>
                <button>Preview Only</button>
            </div>
            <div class="book-card">
                <img src="twisted-lies.jpg" alt="Twisted Lies">
                <h4>Twisted Lies</h4>
                <p>Ana Huang</p>
                <button>Not in Library</button>
            </div>
            <div class="book-card">
                <img src="psychology-of-money.jpg" alt="The Psychology of Money">
                <h4>The Psychology of Money</h4>
                <p>Morgan Housel</p>
                <button>Read</button>
            </div>
            <div class="book-card">
                <img src="art-of-war.jpg" alt="The Art of War">
                <h4>The Art of War</h4>
                <p>Sun Tzu</p>
                <button>Read</button>
            </div>
            <div class="book-card">
                <img src="rich-dad-poor-dad.jpg" alt="Rich Dad Poor Dad">
                <h4>Rich Dad Poor Dad</h4>
                <p>Robert T. Kiyosaki</p>
                <button>Borrow</button>
            </div>
        </div>
    </div>
</body>
</html>