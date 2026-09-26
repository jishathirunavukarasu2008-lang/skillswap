<%@ page contentType="text/html; charset=UTF-8" %>

<%
    Object acceptedObj = request.getAttribute("acceptedExchanges");
    Object scheduledObj = request.getAttribute("scheduledSessions");
    Object completedObj = request.getAttribute("completedSessions");
    Object circlesObj = request.getAttribute("joinedCircles");
    Object totalObj = request.getAttribute("totalSessions");
    Object progressObj = request.getAttribute("progress");

    int acceptedExchanges = acceptedObj != null ? (Integer) acceptedObj : 0;
    int scheduledSessions = scheduledObj != null ? (Integer) scheduledObj : 0;
    int completedSessions = completedObj != null ? (Integer) completedObj : 0;
    int joinedCircles = circlesObj != null ? (Integer) circlesObj : 0;
    int totalSessions = totalObj != null ? (Integer) totalObj : 0;
    int progress = progressObj != null ? (Integer) progressObj : 0;
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Learning Progress - SkillSwap</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 40px auto;
        }

        h1 {
            text-align: center;
            color: #222;
        }

        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
        }

        .stats {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            text-align: center;
        }

        .card h2 {
            color: #333;
        }

        .number {
            font-size: 40px;
            font-weight: bold;
            margin: 15px;
        }

        .progress-card {
            background: white;
            margin-top: 25px;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            text-align: center;
        }

        .progress-number {
            font-size: 48px;
            font-weight: bold;
            margin: 20px;
        }

        .progress-bar {
            width: 100%;
            height: 25px;
            background: #ddd;
            border-radius: 20px;
            overflow: hidden;
        }

        .progress-fill {
    height: 100%;
    background: #333;
}
        .info {
            color: #666;
            margin-top: 20px;
        }

        .button {
            display: inline-block;
            margin-top: 30px;
            padding: 11px 20px;
            background: #333;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .button:hover {
            background: #555;
        }

        @media (max-width: 600px) {

            .stats {
                grid-template-columns: 1fr;
            }

        }

    </style>

</head>

<body>

<div class="container">

    <h1>Learning Progress Analytics</h1>

    <p class="subtitle">
        Track your SkillSwap learning activity and progress.
    </p>


    <div class="stats">

        <div class="card">

            <h2>Accepted Exchanges</h2>

            <div class="number">
                <%= acceptedExchanges %>
            </div>

            <p>
                Successful skill exchange connections
            </p>

        </div>


        <div class="card">

            <h2>Scheduled Sessions</h2>

            <div class="number">
                <%= scheduledSessions %>
            </div>

            <p>
                Upcoming learning sessions
            </p>

        </div>


        <div class="card">

            <h2>Completed Sessions</h2>

            <div class="number">
                <%= completedSessions %>
            </div>

            <p>
                Learning sessions completed
            </p>

        </div>


        <div class="card">

            <h2>Joined Circles</h2>

            <div class="number">
                <%= joinedCircles %>
            </div>

            <p>
                Collaborative learning groups
            </p>

        </div>

    </div>


    <div class="progress-card">

        <h2>Overall Learning Progress</h2>

        <div class="progress-number">
            <%= progress %>%
        </div>

        <div class="progress-bar">

            <div class="progress-fill"></div>

        </div>

        <p class="info">
            Completed sessions:
            <%= completedSessions %>
            /
            <%= totalSessions %>
            total sessions
        </p>

    </div>


    <a href="dashboard.jsp" class="button">
        Back to Dashboard
    </a>

</div>

</body>

</html>