<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.skillswap.model.User" %>

<%
    User user = (User) session.getAttribute("loggedInUser");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SkillSwap Dashboard</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f1fb;
            color: #222;
        }

        .navbar {
            background: #4b2e83;
            color: white;
            padding: 18px 40px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
        }

        .user-area {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .logout {
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            border: 1px solid white;
            border-radius: 6px;
        }

        .logout:hover {
            background: white;
            color: #4b2e83;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 40px auto;
        }

        .welcome {
            margin-bottom: 30px;
        }

        .welcome h1 {
            color: #4b2e83;
            margin-bottom: 8px;
        }

        .welcome p {
            color: #666;
            font-size: 16px;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 15px;

            box-shadow: 0 4px 15px rgba(0,0,0,.08);

            border-top: 5px solid #6c3fc5;
        }

        .card h2 {
            color: #4b2e83;
            margin-top: 0;
            margin-bottom: 12px;
        }

        .card p {
            color: #666;
            line-height: 1.6;
            min-height: 50px;
        }

        .button {
            display: inline-block;
            margin-top: 15px;
            padding: 11px 18px;

            background: #5b35a5;
            color: white;

            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        .button:hover {
            background: #472986;
        }

        .footer {
            text-align: center;
            margin-top: 50px;
            padding: 20px;
            color: #777;
        }

        @media (max-width: 700px) {

            .cards {
                grid-template-columns: 1fr;
            }

            .navbar {
                padding: 15px 20px;
            }

            .container {
                width: 92%;
            }

        }

    </style>

</head>

<body>


<!-- NAVBAR -->

<div class="navbar">

    <div class="logo">
        SkillSwap
    </div>

    <div class="user-area">

        <span>
            Welcome, <%= user.getFullName() %>
        </span>

        <a href="logout" class="logout">
            Logout
        </a>

    </div>

</div>


<!-- MAIN CONTENT -->

<div class="container">


    <!-- WELCOME -->

    <div class="welcome">

        <h1>
            Your SkillSwap Workspace
        </h1>

        <p>
            Exchange knowledge, connect with learners,
            and learn new skills through collaboration.
        </p>

    </div>


    <!-- ALL 4 DASHBOARD CARDS -->

    <div class="cards">


        <!-- 1. MY SKILLS -->

        <div class="card">

            <h2>
                My Skills
            </h2>

            <p>
                Add the skills you can teach and
                the skills you want to learn.
            </p>

            <a href="my-skills" class="button">
                Manage My Skills
            </a>

        </div>


        <!-- 2. SKILL EXCHANGE -->

        <div class="card">

            <h2>
                Skill Exchange
            </h2>

            <p>
                Find learners and exchange
                knowledge without money.
            </p>

            <a href="exchange" class="button">
                Find Exchanges
            </a>
            <br>

<a href="my-exchanges" class="button">
    My Exchange Requests
</a>

        </div>
        <!-- 3. LEARNING SESSIONS -->

<div class="card">

    <h2>
        Learning Sessions
    </h2>

    <p>
        Schedule and track your learning
        sessions with your exchange partner.
    </p>

    <a href="sessions" class="button">
        Open Learning Sessions
    </a>

</div>
<div class="card">
    <h2>Smart Partner Recommendations</h2>

    <p>
        Find students who can teach you the skills you want to learn.
    </p>

    <a href="recommendations" class="button">
        Find Recommended Partners
    </a>
</div>
<div class="card">
    <h2>Learning Progress Analytics</h2>

    <p>
        Track your exchanges, learning sessions,
        completed sessions, and learning progress.
    </p>

    <a href="progress" class="button">
        View My Progress
    </a>
</div>
<div class="card">
    <h2>Verified Skill Portfolio</h2>

    <p>
        View your skills, learning goals,
        exchanges, completed sessions, and
        SkillSwap achievements.
    </p>

    <a href="portfolio" class="button">
        View My Portfolio
    </a>
</div>



        <!-- 3. SKILLSWAP RESCUE -->

        <div class="card">

            <h2>
                SkillSwap Rescue
            </h2>

            <p>
                Recover disrupted exchanges by
                finding another partner or group.
            </p>

            <a href="rescue" class="button">
    Open Rescue
</a>

        </div>


        <!-- 4. SKILLSWAP CIRCLES -->

        <div class="card">

            <h2>
                SkillSwap Circles
            </h2>

            <p>
                Learn together with small
                collaborative groups and shared
                learning goals.
            </p>

            <a href="circles" class="button">
    Explore Circles
</a>
        </div>


    </div>

</div>


<!-- FOOTER -->

<div class="footer">

    SkillSwap &copy; 2026 |
    Peer-to-Peer Collaborative Learning Platform

</div>


</body>

</html>