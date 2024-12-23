<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f7f7;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        header {
            background-color: #007bff;
            width: 100%;
            padding: 10px 0;
            position: fixed;
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
        .container {
            text-align: center;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            margin-top: 80px; /* Adjust for fixed header */
        }
        h2 {
            margin-bottom: 20px;
        }
        a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        a:hover {
            color: #0056b3;
        }
    </style>
</head>
<body>
    <header>
        <nav class="navbar">
            <a href="index.jsp" class="navbar-brand">Open Library</a>
            <ul class="navbar-nav">
                <% Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
                   String username = (String) session.getAttribute("loggedInUser");
                   if (isLoggedIn != null && isLoggedIn) { %>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="#">My Books</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogue">Catalogue</a></li>
                    <li><span class="username">Welcome, <%= username %></span></li>
                    <li><a href="logout" class="btn-logout">Logout</a></li>
                <% } else { %>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogue">Catalogue</a></li>
                    <li><a href="login.jsp" class="btn-login">Log In</a></li>
                    <li><a href="signup.jsp" class="btn-signup">Sign Up</a></li>
                <% } %>
            </ul>
        </nav>
    </header>

    <div class="container">
        <h2>${message}</h2>
        <a href="/PERPUSTERBUKA/catalogue">Back to Catalogue</a>
    </div>
</body>
</html>
