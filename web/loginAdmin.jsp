<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Open Library</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .container { max-width: 400px; padding: 2rem; background: white; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); }
        h2 { text-align: center; margin-bottom: 1rem; color: #333; }
        .input-group { margin-bottom: 1rem; }
        .input-group input { width: 100%; padding: 10px; border-radius: 5px; border: 1px solid #ddd; }
        button { width: 100%; padding: 10px; background-color: #4267B2; color: white; border-radius: 5px; border: none; cursor: pointer; }
        button:hover { background-color: #344e86; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login Anggota Karyawan</h2>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
            <div style="color:red;text-align:center;margin-bottom:10px;"><%= errorMessage %></div>
        <% } %>
        <form action="loginAnggotaKaryawan" method="post">
            <div class="input-group">
                <input type="text" name="username" placeholder="Username" required>
            </div>
            <div class="input-group">
                <input type="password" name="password" placeholder="Password" required>
            </div>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>
