<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Borrow Item - Open Library</title>
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
            display: flex;
            align-items: flex-start;
        }
        .book-card {
            width: 180px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            margin-right: 20px;
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
        form {
            flex-grow: 1;
        }
        form label {
            display: block;
            margin: 10px 0 5px;
        }
        form input[type="text"], form input[type="number"] {
            width: calc(100% - 16px);
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        form button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        form button:hover {
            background-color: #0056b3;
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

    <div class="content">
        <!-- Display Book Information -->
        <div class="book-card">
            <img src="<%= request.getAttribute("gambarUrl") %>" alt="<%= request.getAttribute("judul") %>">
            <h4><%= request.getAttribute("judul") %></h4>
            <p><%= request.getAttribute("penulis") %></p>
        </div>

        <!-- Borrow Form -->
        <form action="<%= request.getContextPath() %>/processBorrow" method="post">
            <input type="hidden" name="idItem" value="${idItem}">
            <c:if test="${empty nama}">
                <label for="nama">Nama:</label>
                <input type="text" name="nama" required>
            </c:if>
            <c:if test="${not empty nama}">
                <p>Nama: ${nama}</p>
                <input type="hidden" name="nama" value="${nama}">
            </c:if>
            <label for="durasiPinjam">Durasi Peminjaman (hari):</label>
            <input type="number" name="durasiPinjam" required>
            <button type="submit">Confirm Borrow</button>
        </form>
    </div>
</body>
</html>
