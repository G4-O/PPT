<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Open Library</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            display: flex;
            height: 100vh;
            background-color: #f8f9fa;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background-color: #343a40;
            color: white;
            display: flex;
            flex-direction: column;
            padding-top: 20px;
        }

        .sidebar h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            display: block;
        }

        .sidebar a:hover {
            background-color: #495057;
        }

        .sidebar a.active {
            background-color: #007bff;
        }

        /* Main Content */
        .main-content {
            flex-grow: 1;
            padding: 20px;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
        }

        .navbar h1 {
            font-size: 1.5rem;
        }

        .navbar .user-info {
            display: flex;
            align-items: center;
        }

        .navbar .user-info i {
            margin-right: 10px;
        }

        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        table th {
            background-color: #f4f4f4;
        }

        .action-buttons a {
            margin-right: 5px;
            text-decoration: none;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
        }

        .action-buttons a.edit {
            background-color: #28a745; /* Green */
        }

        .action-buttons a.delete {
            background-color: #dc3545; /* Red */
        }

        /* Search Bar */
        .search-bar {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
        }

        .search-bar input[type="text"] {
            width: calc(100% - 150px);
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .search-bar button {
            padding: 10px 20px;
            border-radius: 5px;
            border: none;
            background-color: #007bff; /* Blue */
            color: white;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Open Library</h2>
        <a href="dashboard.jsp" class="active">Dashboard</a>
        <a href="?type=buku">Buku</a>
        <a href="?type=dvd">DVD</a>
        <a href="?type=jurnal">Jurnal</a>
        <a href="?type=majalah">Majalah</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        
        <!-- Navbar -->
        <div class="navbar">
            <h1>Dashboard</h1>
            
             <!-- User Info -->
             <div class="user-info">
                <i class="fas fa-user-circle"></i> Admin
             </div>
         </div>

         <!-- Search Bar -->
         <div class="search-bar">
             <input type="text" placeholder="Search...">
             <button>Search</button>
         </div>

         <!-- Table Section -->
         <% 
           // Ambil parameter dari URL untuk menentukan jenis data yang ditampilkan
           String type = request.getParameter("type");
           if (type != null) { 
               String title = "";
               switch (type) {
                   case "buku": title = "Data Buku"; break; 
                   case "dvd": title = "Data DVD"; break; 
                   case "jurnal": title = "Data Jurnal"; break; 
                   case "majalah": title = "Data Majalah"; break; 
               } 
         %>

         <!-- Tabel Data -->
         <h2><%= title %></h2>
         <button onclick="location.href='add.jsp?type=<%= type %>'" style="margin-bottom:15px;">Add New</button>

         <table>
             <thead>
                 <tr>
                     <th>ID</th>
                     <th>Nama Item</th>
                     <th>Kategori</th>
                     <th>Aksi</th>
                 </tr>
             </thead>
             <tbody>
                 <%-- Contoh data statis untuk sementara --%>
                 <% for (int i = 1; i <= 3; i++) { %>
                 <tr>
                     <td><%= i %></td>
                     <td>Item Contoh <%= i %></td>
                     <td><%= type.substring(0,1).toUpperCase() + type.substring(1) %></td> <!-- Capitalize type -->
                     <td class="action-buttons">
                         <a href="update.jsp?id=<%= i %>&type=<%= type %>" class="edit">Edit</a>
                         <a href="delete.jsp?id=<%= i %>&type=<%= type %>" class="delete">Delete</a>
                     </td>
                 </tr>
                 <% } %>  
             </tbody>
         </table>

         <% } else { %>

         <!-- Default Message -->
         <h2>Selamat datang di Dashboard!</h2>

         <% } %>

    </div>

</body>
</html>
