
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SkillSwap | Create Account</title>

    <link rel="stylesheet" href="assets/css/style.css">

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
            padding: 25px;
        }

        .register-container {
            width: 100%;
            max-width: 430px;
            background: #ffffff;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(50, 30, 90, 0.12);
        }

        .logo {
            text-align: center;
            color: #5b35a5;
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 8px;
        }

        h2 {
            text-align: center;
            color: #29213d;
            margin-bottom: 8px;
        }

        .subtitle {
            text-align: center;
            color: #777;
            font-size: 14px;
            margin-bottom: 25px;
            line-height: 1.5;
        }

        label {
            display: block;
            margin: 14px 0 6px;
            color: #333;
            font-size: 14px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #d8d2e5;
            border-radius: 7px;
            font-size: 14px;
            outline: none;
        }

        input:focus {
            border-color: #6b46c1;
            box-shadow: 0 0 4px #d2c2f5;
        }

        .register-btn {
            width: 100%;
            margin-top: 24px;
            padding: 13px;
            background: #5b35a5;
            color: white;
            border: none;
            border-radius: 7px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .register-btn:hover {
            background: #452580;
        }

        .message {
            padding: 11px;
            border-radius: 6px;
            text-align: center;
            font-size: 14px;
            margin-bottom: 15px;
        }

        .success {
            background: #e5f8eb;
            color: #176b35;
        }

        .error {
            background: #ffe8e8;
            color: #a52222;
        }

        .login-link {
            text-align: center;
            margin-top: 22px;
            font-size: 14px;
            color: #666;
        }

        .login-link a {
            color: #5b35a5;
            font-weight: bold;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .terms {
            font-size: 12px;
            color: #888;
            text-align: center;
            margin-top: 15px;
            line-height: 1.5;
        }

        @media (max-width: 480px) {
            .register-container {
                padding: 25px 20px;
            }
        }
    </style>
</head>

<body>

<div class="register-container">

    <div class="logo">SkillSwap</div>

    <h2>Create Your Account</h2>

    <p class="subtitle">
        Share your skills, learn something new,
        and grow together.
    </p>

    <% if ("1".equals(request.getParameter("success"))) { %>

        <div class="message success" role="status">
            Registration successful! You can now log in.
        </div>

    <% } else if ("1".equals(request.getParameter("error"))) { %>

        <div class="message error" role="alert">
            Registration failed. Username or email may already exist.
            Please try again.
        </div>

    <% } %>

    <form action="register" method="post">

        <label for="fullName">Full Name</label>
        <input
            type="text"
            id="fullName"
            name="fullName"
            placeholder="Enter your full name"
            maxlength="100"
            autocomplete="name"
            required>

        <label for="username">Username</label>
        <input
            type="text"
            id="username"
            name="username"
            placeholder="Choose a username"
            maxlength="50"
            autocomplete="username"
            required>

        <label for="email">Email Address</label>
        <input
            type="email"
            id="email"
            name="email"
            placeholder="Enter your email"
            maxlength="100"
            autocomplete="email"
            required>

        <label for="password">Password</label>
        <input
            type="password"
            id="password"
            name="password"
            placeholder="Create a password"
            minlength="8"
            autocomplete="new-password"
            required>

        <button type="submit" class="register-btn">
            Create Account
        </button>

    </form>

    <p class="terms">
        By creating an account, you agree to use
        SkillSwap respectfully and responsibly.
    </p>

    <div class="login-link">
        Already have an account?
        <a href="login.jsp">Login</a>
    </div>

</div>

</body>
</html>