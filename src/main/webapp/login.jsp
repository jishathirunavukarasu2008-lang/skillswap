
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SkillSwap | Login</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #eee8ff, #f7f5ff);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .login-container {
            width: 100%;
            max-width: 420px;
            background: white;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(50, 30, 90, 0.12);
        }

        .logo {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: #5b35a5;
            margin-bottom: 10px;
        }

        h2 {
            text-align: center;
            color: #29213d;
        }

        .subtitle {
            text-align: center;
            color: #777;
            font-size: 14px;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin: 15px 0 6px;
            font-weight: bold;
            font-size: 14px;
            color: #333;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #d8d2e5;
            border-radius: 7px;
            font-size: 14px;
        }

        input:focus {
            outline: none;
            border-color: #6b46c1;
        }

        .login-btn {
            width: 100%;
            padding: 13px;
            margin-top: 22px;
            background: #5b35a5;
            color: white;
            border: none;
            border-radius: 7px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .login-btn:hover {
            background: #452580;
        }

        .message {
            padding: 11px;
            border-radius: 6px;
            text-align: center;
            font-size: 14px;
            margin-bottom: 15px;
        }

        .error {
            background: #ffe8e8;
            color: #a52222;
        }

        .success {
            background: #e5f8eb;
            color: #176b35;
        }

        .register-link {
            text-align: center;
            margin-top: 22px;
            font-size: 14px;
            color: #666;
        }

        .register-link a {
            color: #5b35a5;
            font-weight: bold;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="login-container">

    <div class="logo">SkillSwap</div>

    <h2>Welcome Back!</h2>

    <p class="subtitle">
        Login to continue your learning journey.
    </p>

    <% if ("1".equals(request.getParameter("error"))) { %>
        <div class="message error" role="alert">
            Invalid username/email or password. Please try again.
        </div>
    <% } %>

    <% if ("1".equals(request.getParameter("registered"))) { %>
        <div class="message success" role="status">
            Registration successful! Please login.
        </div>
    <% } %>

    <form action="login" method="post">

        <label for="username">Username or Email</label>
        <input
            type="text"
            id="username"
            name="username"
            placeholder="Enter username or email"
            autocomplete="username"
            required>

        <label for="password">Password</label>
        <input
            type="password"
            id="password"
            name="password"
            placeholder="Enter your password"
            autocomplete="current-password"
            required>

        <button type="submit" class="login-btn">
            Login
        </button>

    </form>

    <div class="register-link">
        Don't have an account?
        <a href="register.jsp">Create Account</a>
    </div>

</div>

</body>
</html>