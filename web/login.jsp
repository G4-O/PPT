<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Open Library</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            max-width: 400px;
            width: 90%;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.15);
            backdrop-filter: blur(4px);
            transform: translateY(20px);
            opacity: 0;
            animation: slideUp 0.6s ease forwards;
        }

        @keyframes slideUp {
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .logo {
            text-align: center;
            margin-bottom: 2rem;
        }

        .logo i {
            font-size: 3rem;
            color: #4267B2;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 1.5rem;
            font-size: 1.8rem;
        }

        .input-group {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .input-group input {
            width: 100%;
            padding: 12px 40px 12px 15px;
            border: 2px solid #e1e1e1;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .input-group input:focus {
            border-color: #4267B2;
            outline: none;
            box-shadow: 0 0 0 3px rgba(66, 103, 178, 0.1);
        }

        .input-group i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }

        .password-toggle {
            cursor: pointer;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #4267B2;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        button:hover {
            background: #344e86;
            transform: translateY(-2px);
        }

        button:active {
            transform: translateY(0);
        }

        .links {
            margin-top: 1.5rem;
            text-align: center;
        }

        .links a {
            color: #4267B2;
            text-decoration: none;
            font-size: 0.9rem;
            margin: 0 10px;
            transition: color 0.3s ease;
        }

        .links a:hover {
            color: #344e86;
            text-decoration: underline;
        }

        .error-message {
            background: #ff5757;
            color: white;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 1rem;
            text-align: center;
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }

        .remember-me input[type="checkbox"] {
            margin-right: 8px;
        }

        @media (max-width: 480px) {
            .container {
                width: 95%;
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <i class="fas fa-book-reader"></i>
        </div>
        <h2>Welcome Back</h2>
        
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i>
                <%= errorMessage %>
            </div>
        <% } %>
        
        <form action="login" method="post" id="loginForm">
            <div class="input-group">
                <input type="text" name="username" placeholder="Username" required>
                <i class="fas fa-user"></i>
            </div>
            
            <div class="input-group">
                <input type="password" name="password" id="password" placeholder="Password" required>
                <i class="fas fa-eye password-toggle" id="passwordToggle"></i>
            </div>

            <div class="remember-me">
                <input type="checkbox" id="remember" name="remember">
                <label for="remember">Remember me</label>
            </div>

            <button type="submit" id="loginButton">
                <span>Login</span>
            </button>
        </form>

        <div class="links">
            <a href="forgot-password.jsp">Forgot Password?</a>
            <a href="signup.jsp">Sign Up</a>
            <a href="index.jsp">Back to Home</a>
        </div>
    </div>

    <script>
        // Password visibility toggle
        const passwordToggle = document.getElementById('passwordToggle');
        const passwordInput = document.getElementById('password');

        passwordToggle.addEventListener('click', () => {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            passwordToggle.classList.toggle('fa-eye');
            passwordToggle.classList.toggle('fa-eye-slash');
        });

        // Form submission animation
        const loginForm = document.getElementById('loginForm');
        const loginButton = document.getElementById('loginButton');

        loginForm.addEventListener('submit', (e) => {
            loginButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Logging in...';
            loginButton.style.pointerEvents = 'none';
        });

        // Input validation
        const inputs = document.querySelectorAll('input[type="text"], input[type="password"]');
        inputs.forEach(input => {
            input.addEventListener('input', () => {
                if (input.value.length > 0) {
                    input.style.borderColor = '#4267B2';
                } else {
                    input.style.borderColor = '#e1e1e1';
                }
            });
        });
    </script>
</body>
</html>