<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>My Books - Open Library</title>
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
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
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
            margin: 0;
            padding: 0;
        }

        .nav-link {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }

        .nav-link i {
            font-size: 1.1em;
        }

        .content {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .content h2 {
            color: var(--primary-color);
            font-size: 2.5rem;
            margin-bottom: 2rem;
            font-weight: 700;
        }

        .borrowed-item {
            display: flex;
            gap: 20px;
            background: var(--card-background);
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 24px;
            margin-bottom: 24px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .borrowed-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.15);
        }

        .item-image {
            width: 180px;
            min-width: 180px;
            height: 250px;
        }

        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .item-details {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .item-details h3 {
            margin: 0;
            color: var(--primary-color);
            font-size: 1.5rem;
            font-weight: 700;
        }

        .item-info {
            display: grid;
            grid-template-columns: 140px 1fr;
            gap: 8px;
            align-items: center;
        }

        .label {
            font-weight: 600;
            color: var(--primary-color);
        }

        .value {
            color: var(--text-color);
        }

        .overdue {
            color: #dc2626;
            font-weight: 600;
            padding: 8px 16px;
            background-color: #fee2e2;
            border-radius: 6px;
            display: inline-block;
            margin-top: 8px;
        }
        
        .due {
            color:  #7d8000;
            font-weight: 600;
            padding: 8px 16px;
            background-color: #fbfcca;
            border-radius: 6px;
            display: inline-block;
            margin-top: 8px;
        }

        .days-remaining {
            color: #059669;
            font-weight: 600;
            padding: 8px 16px;
            background-color: #d1fae5;
            border-radius: 6px;
            display: inline-block;
            margin-top: 8px;
        }

        .empty-message {
            text-align: center;
            padding: 48px;
            background: var(--card-background);
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .empty-message p {
            font-size: 1.2rem;
            color: var(--text-color);
            margin: 0;
        }

        @media (max-width: 768px) {
            .borrowed-item {
                flex-direction: column;
            }

            .item-image {
                width: 100%;
                height: 200px;
            }

            .item-details {
                padding: 0;
            }

            .item-info {
                grid-template-columns: 1fr;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <header>
        <nav class="navbar">
            <a href="index.jsp" class="navbar-brand">
                <i class="fas fa-book-reader"></i>
                Open Library
            </a>
            <ul class="navbar-nav">
                <li><a href="index.jsp" class="nav-link"><i class="fas fa-home"></i> Home</a></li>
                <li><a href="mybooks" class="nav-link"><i class="fas fa-book"></i> My Books</a></li>
                <li><a href="${pageContext.request.contextPath}/catalogue" class="nav-link"><i class="fas fa-compass"></i> Explore</a></li>
                <li><a href="logout" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
    </header>

    <div class="content">
        <h2>My Borrowed Items</h2>
        <c:choose>
            <c:when test="${not empty borrowedItems}">
                <c:forEach var="item" items="${borrowedItems}">
                    <div class="borrowed-item">
                        <div class="item-image">
                            <img src="${empty item.imageUrl ? 'assets/images/default-book.jpg' : item.imageUrl}" 
                                 alt="${item.title}"
                                 onerror="this.src='assets/images/default-book.jpg'">
                        </div>
                        <div class="item-details">
                            <h3>${item.title}</h3>
                            <div class="item-info">
                                <span class="label">Type:</span>
                                <span class="value">${item.type}</span>

                                <span class="label">Author/Director:</span>
                                <span class="value">${item.authorOrDirector}</span>

                                <span class="label">Borrowed on:</span>
                                <span class="value">${item.borrowDate}</span>

                                <span class="label">Due date:</span>
                                <span class="value">${item.returnDate}</span>

                                <span class="label">Status:</span>
                                <c:choose>
                                    <c:when test="${item.overdue}">
                                        <span class="overdue">
                                            <i class="fas fa-exclamation-circle"></i>
                                            Overdue by ${item.overdueDays} day(s)
                                        </span>
                                    </c:when>
                                    <c:when test="${item.due == true}">
                                        <span class="due">
                                            <i class="fa-solid fa-triangle-exclamation"></i>
                                                It's Due, Please return today!
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="days-remaining">
                                            <i class="fas fa-clock"></i>
                                            ${item.daysRemaining} day(s) remaining
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-message">
                    <p><i class="fas fa-info-circle"></i> You have no borrowed items at the moment.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>