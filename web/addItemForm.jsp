<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Item - Open Library</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1e40af;
            --success-color: #059669;
            --error-color: #dc2626;
            --background-color: #f3f4f6;
            --card-background: #ffffff;
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--background-color);
            color: #1f2937;
            line-height: 1.6;
        }
        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .card {
            background: var(--card-background);
            border-radius: 1rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            padding: 2rem;
            margin-bottom: 2rem;
            opacity: 0;
            transform: translateY(20px);
            animation: fadeIn 0.6s ease forwards;
        }
        @keyframes fadeIn {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .form-header h1 {
            color: var(--primary-color);
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }
        .form-header p {
            color: #6b7280;
        }
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #374151;
        }
        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e5e7eb;
            border-radius: 0.5rem;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }
        .image-preview {
            width: 100%;
            height: 200px;
            border: 2px dashed #e5e7eb;
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 0.5rem;
            overflow: hidden;
        }
        .image-preview img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
        .btn-container {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }
        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 0.5rem;
            font-weight: 500;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: transform 0.2s ease;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
        .btn-primary {
            background: var(--primary-color);
            color: white;
        }
        .btn-secondary {
            background: #6b7280;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="form-header">
                <h1>Add New <%= request.getParameter("type") != null ? request.getParameter("type").substring(0, 1).toUpperCase() + request.getParameter("type").substring(1) : "" %></h1>
                <p>Fill in the details below to add a new item to the library collection</p>
            </div>

            <form action="addItem" method="post" id="addItemForm" onsubmit="return validateForm()">
                <input type="hidden" name="type" value="<%= request.getParameter("type") %>" />
                
                <% String type = request.getParameter("type");
                if ("buku".equals(type)) { %>
                    <!-- Form fields untuk Buku -->
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="judul">Judul</label>
                            <input type="text" class="form-control" id="judul" name="judul" required />
                        </div>
                        <div class="form-group">
                            <label for="penulis">Penulis</label>
                            <input type="text" class="form-control" id="penulis" name="penulis" required />
                        </div>
                        <div class="form-group">
                            <label for="tahunTerbit">Tahun Terbit</label>
                            <input type="number" class="form-control" id="tahunTerbit" name="tahunTerbit" min="1900" max="2024" required />
                        </div>
                        <div class="form-group">
                            <label for="publisher">Publisher</label>
                            <input type="text" class="form-control" id="publisher" name="publisher" required />
                        </div>
                        <div class="form-group">
                            <label for="klasifikasi">Klasifikasi</label>
                            <input type="text" class="form-control" id="klasifikasi" name="klasifikasi" required />
                        </div>
                        <div class="form-group">
                            <label for="bidang">Bidang</label>
                            <input type="text" class="form-control" id="bidang" name="bidang" required />
                        </div>
                    </div>
                <% } else if ("dvd".equals(type)) { %>
                    <!-- Form fields untuk DVD -->
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="judul">Judul</label>
                            <input type="text" class="form-control" id="judul" name="judul" required />
                        </div>
                        <div class="form-group">
                            <label for="sutradara">Sutradara</label>
                            <input type="text" class="form-control" id="sutradara" name="sutradara" required />
                        </div>
                        <div class="form-group">
                            <label for="durasi">Durasi (menit)</label>
                            <input type="number" class="form-control" id="durasi" name="durasi" min="1" required />
                        </div>
                        <div class="form-group">
                            <label for="klasifikasi">Klasifikasi</label>
                            <input type="text" class="form-control" id="klasifikasi" name="klasifikasi" required />
                        </div>
                        <div class="form-group">
                            <label for="bidang">Bidang</label>
                            <input type="text" class="form-control" id="bidang" name="bidang" required />
                        </div>
                    </div>
                <% } else if ("jurnal".equals(type)) { %>
                    <!-- Form fields untuk Jurnal -->
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="judul">Judul</label>
                            <input type="text" class="form-control" id="judul" name="judul" required />
                        </div>
                        <div class="form-group">
                            <label for="penulis">Penulis</label>
                            <input type="text" class="form-control" id="penulis" name="penulis" required />
                        </div>
                        <div class="form-group">
                            <label for="publisher">Publisher</label>
                            <input type="text" class="form-control" id="publisher" name="publisher" required />
                        </div>
                        <div class="form-group">
                            <label for="klasifikasi">Klasifikasi</label>
                            <input type="text" class="form-control" id="klasifikasi" name="klasifikasi" required />
                        </div>
                        <div class="form-group">
                            <label for="bidang">Bidang</label>
                            <input type="text" class="form-control" id="bidang" name="bidang" required />
                        </div>
                    </div>
                <% } else if ("majalah".equals(type)) { %>
                    <!-- Form fields untuk Majalah -->
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="judul">Judul</label>
                            <input type="text" class="form-control" id="judul" name="judul" required />
                        </div>
                        <div class="form-group">
                            <label for="edisi">Edisi</label>
                            <input type="number" class="form-control" id="edisi" name="edisi" min="1" required />
                        </div>
                        <div class="form-group">
                            <label for="penulis">Penulis</label>
                            <input type="text" class="form-control" id="penulis" name="penulis" required />
                        </div>
                        <div class="form-group">
                            <label for="publisher">Publisher</label>
                            <input type="text" class="form-control" id="publisher" name="publisher" required />
                        </div>
                        <div class="form-group">
                            <label for="klasifikasi">Klasifikasi</label>
                            <input type="text" class="form-control" id="klasifikasi" name="klasifikasi" required />
                        </div>
                        <div class="form-group">
                            <label for="bidang">Bidang</label>
                            <input type="text" class="form-control" id="bidang" name="bidang" required />
                        </div>
                    </div>
                <% } %>

                <!-- Common fields for all types -->
                <div class="form-group">
                    <label for="deskripsi">Deskripsi</label>
                    <textarea class="form-control" id="deskripsi" name="deskripsi" rows="4" required></textarea>
                </div>
                <div class="form-group">
                    <label for="gambarUrl">Gambar URL</label>
                    <input type="url" class="form-control" id="gambarUrl" name="gambarUrl" onchange="previewImage(this)" required />
                    <div class="image-preview" id="imagePreview">
                        <i class="fas fa-image fa-3x" style="color: #e5e7eb;"></i>
                    </div>
                </div>
                <div class="form-group">
                    <label for="stok">Stok</label>
                    <input type="number" class="form-control" id="stok" name="stok" min="0" required />
                </div>

                <div class="btn-container">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Save Item
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="window.location.href='dashboardItem?type=<%= type %>'">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function previewImage(input) {
            const preview = document.getElementById('imagePreview');
            const url = input.value;
            if (url) {
                const img = document.createElement('img');
                img.src = url;
                img.onerror = () => {
                    preview.innerHTML = '<i class="fas fa-image fa-3x" style="color: #e5e7eb;"></i>';
                };
                img.onload = () => {
                    preview.innerHTML = '';
                    preview.appendChild(img);
                };
            } else {
                preview.innerHTML = '<i class="fas fa-image fa-3x" style="color: #e5e7eb;"></i>';
            }
        }

        function validateForm() {
            const form = document.getElementById('addItemForm');
            if (form.checkValidity()) {
                return true;
            }
            return false;
        }

        document.querySelectorAll('.form-control').forEach(element => {
            element.addEventListener('focus', (e) => {
                e.target.style.transform = 'scale(1.02)';
            });
            element.addEventListener('blur', (e) => {
                e.target.style.transform = 'scale(1)';
            });
        });
    </script>
</body>
</html>
