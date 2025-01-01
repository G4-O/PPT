<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Item - Open Library</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background-color: #f8f9fa;
        }
        form {
            max-width: 500px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input, textarea {
            width: 100%;
            padding: 8px;
            margin: 5px 0 15px 0;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn-container {
            margin-top: 20px;
            text-align: center;
        }
        .btn {
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin: 0 5px;
        }
        .btn-submit {
            background-color: #4CAF50;
            color: white;
        }
        .btn-cancel {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>
<body>
    <form action="addItem" method="post">
        <h1>Add Item - <%= request.getParameter("type") != null ? request.getParameter("type").toUpperCase() : "" %></h1>
        
        <input type="hidden" name="type" value="<%= request.getParameter("type") %>" />
        
        <% String type = request.getParameter("type"); 
           if ("buku".equals(type)) { %>
            <div class="form-group">
                <label for="judul">Judul:</label>
                <input type="text" id="judul" name="judul" required />
                
                <label for="penulis">Penulis:</label>
                <input type="text" id="penulis" name="penulis" required />
                
                <label for="tahunTerbit">Tahun Terbit:</label>
                <input type="number" id="tahunTerbit" name="tahunTerbit" required />
                
                <label for="deskripsi">Deskripsi:</label>
                <textarea id="deskripsi" name="deskripsi" rows="4"></textarea>
                
                <label for="klasifikasi">Klasifikasi:</label>
                <input type="text" id="klasifikasi" name="klasifikasi" />
                
                <label for="publisher">Publisher:</label>
                <input type="text" id="publisher" name="publisher" />
                
                <label for="bidang">Bidang:</label>
                <input type="text" id="bidang" name="bidang" />
                
                <label for="gambarUrl">Gambar URL:</label>
                <input type="text" id="gambarUrl" name="gambarUrl" required />
                
                <label for="stok">Stok:</label>
                <input type="number" id="stok" name="stok" required />
            </div>
        
        <% } else if ("dvd".equals(type)) { %>
            <!-- Form fields untuk DVD -->
            <!-- Sesuaikan dengan struktur yang sama -->
        <% } else if ("jurnal".equals(type)) { %>
            <!-- Form fields untuk Jurnal -->
            <!-- Sesuaikan dengan struktur yang sama -->
        <% } else if ("majalah".equals(type)) { %>
            <!-- Form fields untuk Majalah -->
            <!-- Sesuaikan dengan struktur yang sama -->
        <% } %>

        <div class="btn-container">
            <button type="submit" class="btn btn-submit">Submit</button>
            <button type="button" onclick="window.location.href='dashboardItem?type=<%= type %>'" class="btn btn-cancel">Cancel</button>
        </div>
    </form>
</body>
</html>
