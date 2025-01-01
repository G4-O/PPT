<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ItemPerpustakaan" %>
<%@ page import="model.Buku" %>
<%@ page import="model.DVD" %>
<%@ page import="model.Jurnal" %>
<%@ page import="model.Majalah" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Item - Open Library</title>
    <!-- Include Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Include Animate.css for animations -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --success-color: #2ecc71;
            --error-color: #e74c3c;
            --text-color: #34495e;
            --background-color: #f9f9f9;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            animation: fadeInUp 0.5s ease-out;
        }

        h1 {
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 30px;
            position: relative;
            padding-bottom: 10px;
        }

        h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background: var(--secondary-color);
            border-radius: 2px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
            transition: all 0.3s ease;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: var(--primary-color);
            font-weight: 500;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        input:focus {
            border-color: var(--secondary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }

        .form-group i {
            position: absolute;
            right: 12px;
            top: 40px;
            color: #95a5a6;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        button {
            flex: 1;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-update {
            background: var(--success-color);
            color: white;
        }

        .btn-update:hover {
            background: #27ae60;
            transform: translateY(-2px);
        }

        .btn-cancel {
            background: #95a5a6;
            color: white;
        }

        .btn-cancel:hover {
            background: #7f8c8d;
            transform: translateY(-2px);
        }

        .preview-image {
            width: 200px;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            margin: 10px 0;
            display: none;
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Validation styles */
        input:invalid {
            border-color: var(--error-color);
        }

        .error-message {
            color: var(--error-color);
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }

        /* Loading indicator */
        .loading {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.8);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .loading-spinner {
            border: 4px solid #f3f3f3;
            border-top: 4px solid var(--secondary-color);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <%
        String type = (String) request.getAttribute("type");
        ItemPerpustakaan item = (ItemPerpustakaan) request.getAttribute("item");

        if (item == null) {
            response.sendRedirect("dashboardItem?type=" + type + "&error=Data tidak ditemukan");
            return;
        }
    %>

    <div class="container animate__animated animate__fadeIn">
        <h1>Edit <%= type != null ? type.toUpperCase() : "" %></h1>

        <form id="editForm" action="updateItem" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="type" value="<%= type %>">
            <input type="hidden" name="idItem" value="<%= item.getIdItem() %>">

            <% if ("buku".equals(type)) {
                Buku buku = (Buku) item; %>
                <div class="form-group">
                    <label for="judul"><i class="fas fa-book"></i> Judul</label>
                    <input type="text" id="judul" name="judul" value="<%= buku.getJudul() %>" required>
                    <div class="error-message">Judul tidak boleh kosong</div>
                </div>
                
                <div class="form-group">
                    <label for="penulis"><i class="fas fa-user-edit"></i> Penulis</label>
                    <input type="text" id="penulis" name="penulis" value="<%= buku.getPenulis() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="tahunTerbit"><i class="fas fa-calendar-alt"></i> Tahun Terbit</label>
                    <input type="number" id="tahunTerbit" name="tahunTerbit" value="<%= buku.getTahunTerbit() %>" required>
                </div>

            <% } else if ("dvd".equals(type)) {
                DVD dvd = (DVD) item; %>
                <!-- Similar structure for DVD fields -->
                <div class="form-group">
                    <label for="judul"><i class="fas fa-film"></i> Judul</label>
                    <input type="text" id="judul" name="judul" value="<%= dvd.getJudul() %>" required>
                </div>
                <div class="form-group">
                    <label for="judul"><i class="fas fa-film"></i> Sutradara</label>
                    <input type="text" id="sutradara" name="sutradara" value="<%= dvd.getSutradara()%>" required>
                </div>
                <div class="form-group">
                    <label for="judul"><i class="fas fa-film"></i> Durasi (menit)</label>
                    <input type="number" id="durasi" name="durasi" value="<%= dvd.getDurasi()%>" required>
                </div>
                <!-- Add other DVD fields -->

            <% } else if ("jurnal".equals(type)) {
                Jurnal jurnal = (Jurnal) item; %>
                <!-- Similar structure for Jurnal fields -->
                <div class="form-group">
                    <label for="judul"><i class="fas fa-newspaper"></i> Judul</label>
                    <input type="text" id="judul" name="judul" value="<%= jurnal.getJudul() %>" required>
                </div>
                <div class="form-group">
                    <label for="judul"><i class="fas fa-newspaper"></i> Penulis</label>
                    <input type="text" id="penulis" name="penulis" value="<%= jurnal.getPenulis()%>" required>
                </div>
                <div class="form-group">
                    <label for="judul"><i class="fas fa-newspaper"></i> Bidang</label>
                    <input type="text" id="bidang" name="bidang" value="<%= jurnal.getBidang()%>" required>
                </div>
                <!-- Add other Jurnal fields -->

            <% } else if ("majalah".equals(type)) {
                Majalah majalah = (Majalah) item; %>
                <!-- Similar structure for Majalah fields -->
                <div class="form-group">
                    <label for="judul"><i class="fas fa-magazine"></i> Judul</label>
                    <input type="text" id="judul" name="judul" value="<%= majalah.getJudul() %>" required>
                </div>
                <div class="form-group">
                    <label for="judul"><i class="fas fa-magazine"></i> Edisi</label>
                    <input type="number" id="judul" name="judul" value="<%= majalah.getEdisi() %>" required>
                </div>
                <!-- Add other Majalah fields -->
            <% } %>

            <div class="form-group">
                <label for="gambarUrl"><i class="fas fa-image"></i> URL Gambar</label>
                <input type="url" id="gambarUrl" name="gambarUrl" value="<%= item.getGambarUrl() %>" 
                       onchange="previewImage(this.value)" required>
                <img id="imagePreview" class="preview-image" alt="Preview">
            </div>

            <div class="form-group">
                <label for="stok"><i class="fas fa-box"></i> Stok</label>
                <input type="number" id="stok" name="stok" value="<%= item.getStok() %>" min="0" required>
            </div>

            <div class="button-group">
                <button type="submit" class="btn-update">
                    <i class="fas fa-save"></i> Update
                </button>
                <button type="button" class="btn-cancel" onclick="confirmCancel()">
                    <i class="fas fa-times"></i> Batal
                </button>
            </div>
        </form>
    </div>

    <div class="loading">
        <div class="loading-spinner"></div>
    </div>

    <script>
        function previewImage(url) {
            const preview = document.getElementById('imagePreview');
            preview.style.display = 'block';
            preview.src = url;
            preview.onerror = function() {
                preview.style.display = 'none';
                alert('URL gambar tidak valid');
            };
        }

        function validateForm() {
            const form = document.getElementById('editForm');
            const inputs = form.querySelectorAll('input[required]');
            let isValid = true;

            inputs.forEach(input => {
                if (!input.value.trim()) {
                    isValid = false;
                    input.classList.add('invalid');
                    const errorDiv = input.nextElementSibling;
                    if (errorDiv && errorDiv.classList.contains('error-message')) {
                        errorDiv.style.display = 'block';
                    }
                } else {
                    input.classList.remove('invalid');
                    const errorDiv = input.nextElementSibling;
                    if (errorDiv && errorDiv.classList.contains('error-message')) {
                        errorDiv.style.display = 'none';
                    }
                }
            });

            if (isValid) {
                document.querySelector('.loading').style.display = 'flex';
            }

            return isValid;
        }

        function confirmCancel() {
            if (confirm('Apakah Anda yakin ingin membatalkan perubahan?')) {
                window.location.href = 'dashboardItem?type=<%= type %>';
            }
        }

        // Add input animations
        document.querySelectorAll('input').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('animate__animated', 'animate__pulse');
            });

            input.addEventListener('blur', function() {
                this.parentElement.classList.remove('animate__animated', 'animate__pulse');
            });
        });
    </script>
</body>
</html>