<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Learning Sessions - SkillSwap</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f0ff;
            color: #222;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 40px auto;
        }

        h1 {
            color: #5b21b6;
        }

        .card {
            background: white;
            padding: 25px;
            margin: 20px 0;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.1);
        }

        input,
        select,
        textarea {
            width: 100%;
            padding: 10px;
            margin: 8px 0 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        button {
            background: #6d28d9;
            color: white;
            border: none;
            padding: 11px 18px;
            border-radius: 6px;
            cursor: pointer;
        }

        button:hover {
            background: #4c1d95;
        }

        .completed {
            color: green;
            font-weight: bold;
        }

        .scheduled {
            color: #d97706;
            font-weight: bold;
        }

        .message {
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            background: #dcfce7;
            color: #166534;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
        }

        a {
            color: #5b21b6;
            text-decoration: none;
            font-weight: bold;
        }

    </style>
</head>

<body>

<div class="container">

    <h1>Learning Sessions</h1>

    <p>
        Schedule and track your learning sessions with your exchange partner.
    </p>


    <!-- SUCCESS / ERROR MESSAGES -->

    <%
        String success = request.getParameter("success");
        String completed = request.getParameter("completed");
        String error = request.getParameter("error");

        if ("1".equals(success)) {
    %>

        <div class="message">
            Learning session scheduled successfully!
        </div>

    <%
        }

        if ("1".equals(completed)) {
    %>

        <div class="message">
            Learning session marked as completed!
        </div>

    <%
        }

        if (error != null) {
    %>

        <div class="message error">
            Unable to process the learning session.
        </div>

    <%
        }
    %>


    <!-- SCHEDULE SESSION -->

    <div class="card">

        <h2>Schedule a Learning Session</h2>

        <%
            List<String[]> exchanges =
                    (List<String[]>) request.getAttribute("myExchanges");

            boolean hasAcceptedExchange = false;

            if (exchanges != null && !exchanges.isEmpty()) {
        %>

        <form action="sessions" method="post">

            <input type="hidden"
                   name="action"
                   value="CREATE">

            <label>
                Select Accepted Exchange
            </label>

            <select name="exchangeId" required>

                <option value="">
                    -- Select Exchange --
                </option>

                <%
                    for (String[] exchange : exchanges) {

                        String exchangeId = exchange[0];
                        String otherStudent = exchange[1];
                        String offeredSkill = exchange[2];
                        String wantedSkill = exchange[3];
                        String status = exchange[4];

                        if ("ACCEPT".equals(status)) {

                            hasAcceptedExchange = true;
                %>

                <option value="<%= exchangeId %>">

                    Exchange with
                    <%= otherStudent %>
                    -
                    <%= offeredSkill %>
                    / 
                    <%= wantedSkill %>

                </option>

                <%
                        }
                    }
                %>

            </select>


            <%
                if (hasAcceptedExchange) {
            %>

            <label>
                Date
            </label>

            <input type="date"
                   name="scheduledDate"
                   required>


            <label>
                Time
            </label>

            <input type="time"
                   name="scheduledTime"
                   required>


            <label>
                Topic
            </label>

            <input type="text"
                   name="topic"
                   placeholder="Example: Java OOP Basics"
                   required>


            <label>
                Duration
            </label>

            <select name="duration">

                <option value="30">
                    30 minutes
                </option>

                <option value="60" selected>
                    60 minutes
                </option>

                <option value="90">
                    90 minutes
                </option>

                <option value="120">
                    120 minutes
                </option>

            </select>


            <button type="submit">
                Schedule Session
            </button>

            <%
                } else {
            %>

            <p>
                You don't have an accepted exchange yet.
                Accept an exchange request before scheduling a session.
            </p>

            <%
                }
            %>

        </form>

        <%
            } else {
        %>

        <p>
            You don't have any exchange requests yet.
        </p>

        <%
            }
        %>

    </div>


    <!-- MY SESSIONS -->

    <div class="card">

        <h2>My Learning Sessions</h2>

        <%
            List<String[]> sessions =
                    (List<String[]>) request.getAttribute("sessions");

            if (sessions != null && !sessions.isEmpty()) {

                for (String[] s : sessions) {

                    String sessionId = s[0];
                    String exchangeId = s[1];
                    String date = s[2];
                    String time = s[3];
                    String topic = s[4];
                    String duration = s[5];
                    String status = s[6];
                    String otherStudent = s[7];
        %>

        <div style="
            border: 1px solid #ddd;
            padding: 18px;
            margin: 15px 0;
            border-radius: 8px;
        ">

            <h3>
                <%= topic %>
            </h3>

            <p>
                <strong>Learning Partner:</strong>
                <%= otherStudent %>
            </p>

            <p>
                <strong>Date:</strong>
                <%= date %>
            </p>

            <p>
                <strong>Time:</strong>
                <%= time %>
            </p>

            <p>
                <strong>Duration:</strong>
                <%= duration %> minutes
            </p>

            <p>
                <strong>Status:</strong>

                <span class="<%= status.toLowerCase() %>">
                    <%= status %>
                </span>

            </p>


            <%
                if ("SCHEDULED".equals(status)) {
            %>

            <form action="sessions" method="post">

                <input type="hidden"
                       name="action"
                       value="COMPLETE">

                <input type="hidden"
                       name="sessionId"
                       value="<%= sessionId %>">

                <button type="submit">
                    Mark as Completed
                </button>

            </form>

            <%
                }
            %>

        </div>

        <%
                }

            } else {
        %>

        <p>
            No learning sessions scheduled yet.
        </p>

        <%
            }
        %>

    </div>


    <p>
        <a href="dashboard.jsp">
            ← Back to Dashboard
        </a>
    </p>

</div>

</body>
</html>