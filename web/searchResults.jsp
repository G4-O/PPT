<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ItemPerpustakaan" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results - Open Library</title>
    <style>
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
        .search-bar select {
            margin-left: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
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
                <%
                    Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
                    String username = (String) session.getAttribute("loggedInUser");
                    if (isLoggedIn != null && isLoggedIn) {
                %>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="#">My Books</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogue">Catalogue</a></li>
                    <li><span class="username">Welcome, <%= username %></span></li>
                    <li><a href="logout" class="btn-logout">Logout</a></li>
                <%
                    } else {
                %>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogue">Catalogue</a></li>
                    <li><a href="login.jsp" class="btn-login">Log In</a></li>
                    <li><a href="signup.jsp" class="btn-signup">Sign Up</a></li>
                <%
                    }
                %>
            </ul>
        </nav>
    </header>
    
    <div class="content">
        <h2>Search Results</h2>
        
        <div class="book-list">
            <%
                List<ItemPerpustakaan> searchResults = (List<ItemPerpustakaan>) request.getAttribute("searchResults");
                if (searchResults != null && !searchResults.isEmpty()) {
                    for (ItemPerpustakaan item : searchResults) {
            %>
            <div class="book-card">
                <img src="<%= item.getGambarUrl() %>" alt="<%= item.getJudul() %>">
                <h4><%= item.getJudul() %></h4>
                <form action="<%= request.getContextPath() %>/borrowItem" method="post">
                    <input type="hidden" name="idItem" value="<%= item.getIdItem() %>">
                    <input type="hidden" name="itemType" value="<%= item.getItemType() %>">
                    <button type="submit">Borrow Now</button>
                </form>
            </div>
            <%
                    }
                } else {
            %>
            <p>No items found.</p>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>
