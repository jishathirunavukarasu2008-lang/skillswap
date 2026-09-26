<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%
    String[] userInfo =
            (String[]) request.getAttribute("userInfo");

    List<String[]> offeredSkills =
            (List<String[]>) request.getAttribute("offeredSkills");

    List<String[]> wantedSkills =
            (List<String[]>) request.getAttribute("wantedSkills");

    Integer acceptedExchanges =
            (Integer) request.getAttribute("acceptedExchanges");

    Integer completedSessions =
            (Integer) request.getAttribute("completedSessions");

    Integer joinedCircles =
            (Integer) request.getAttribute("joinedCircles");

    if (userInfo == null) {
        userInfo = new String[]{"", "", ""};
    }

    if (acceptedExchanges == null) {
        acceptedExchanges = 0;
    }

    if (completedSessions == null) {
        completedSessions = 0;
    }

    if (joinedCircles == null) {
        joinedCircles = 0;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>My Skill Portfolio - SkillSwap</title>

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

        .profile {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            margin-bottom: 25px;
        }

        .profile h2 {
            margin-top: 0;
        }

        .info {
            margin: 10px 0;
            color: #555;
        }

        .sections {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .card h2 {
            margin-top: 0;
        }

        .skill {
            display: inline-block;
            background: #e8f4ff;
            color: #1769aa;
            padding: 8px 14px;
            border-radius: 20px;
            margin: 5px;
            font-weight: bold;
        }

        .want {
            background: #fff3df;
            color: #a65c00;
        }

        .stats {
            margin-top: 25px;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .stat {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            text-align: center;
        }

        .stat-number {
            font-size: 38px;
            font-weight: bold;
            margin: 10px 0;
        }

        .verified {
            margin-top: 25px;
            background: #eaf7ea;
            color: #237a23;
            padding: 18px;
            border-radius: 10px;
            text-align: center;
            font-weight: bold;
        }

        .empty {
            color: #777;
        }

        .back {
            text-align: center;
            margin-top: 30px;
        }

        .button {
            display: inline-block;
            padding: 11px 20px;
            background: #333;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .button:hover {
            background: #555;
        }

        @media (max-width: 700px) {

            .sections {
                grid-template-columns: 1fr;
            }

            .stats {
                grid-template-columns: 1fr;
            }

        }

    </style>

</head>

<body>

<div class="container">

    <h1>My Skill Portfolio</h1>

    <p class="subtitle">
        Your SkillSwap learning profile and achievements.
    </p>


    <!-- Profile -->

    <div class="profile">

        <h2>
            <%= userInfo[0] %>
        </h2>

        <div class="info">
            <strong>Username:</strong>
            <%= userInfo[1] %>
        </div>

        <div class="info">

            <strong>Bio:</strong>

            <%
                if (userInfo[2] != null &&
                    !userInfo[2].trim().isEmpty()) {
            %>

                <%= userInfo[2] %>

            <%
                } else {
            %>

                No bio added yet.

            <%
                }
            %>

        </div>

    </div>


    <!-- Skills -->

    <div class="sections">


        <!-- Skills Offered -->

        <div class="card">

            <h2>Skills I Can Teach</h2>

            <%
                if (offeredSkills != null &&
                    !offeredSkills.isEmpty()) {
            %>

                <%
                    for (String[] skill : offeredSkills) {
                %>

                    <span class="skill">
                        <%= skill[0] %>
                    </span>

                <%
                    }
                %>

            <%
                } else {
            %>

                <p class="empty">
                    No teaching skills added yet.
                </p>

            <%
                }
            %>

        </div>


        <!-- Skills Wanted -->

        <div class="card">

            <h2>Skills I Want to Learn</h2>

            <%
                if (wantedSkills != null &&
                    !wantedSkills.isEmpty()) {
            %>

                <%
                    for (String[] skill : wantedSkills) {
                %>

                    <span class="skill want">
                        <%= skill[0] %>
                    </span>

                <%
                    }
                %>

            <%
                } else {
            %>

                <p class="empty">
                    No learning goals added yet.
                </p>

            <%
                }
            %>

        </div>

    </div>


    <!-- Statistics -->

    <div class="stats">


        <div class="stat">

            <h3>Accepted Exchanges</h3>

            <div class="stat-number">
                <%= acceptedExchanges %>
            </div>

            <p>
                Successful skill exchanges
            </p>

        </div>


        <div class="stat">

            <h3>Completed Sessions</h3>

            <div class="stat-number">
                <%= completedSessions %>
            </div>

            <p>
                Learning sessions completed
            </p>

        </div>


        <div class="stat">

            <h3>Joined Circles</h3>

            <div class="stat-number">
                <%= joinedCircles %>
            </div>

            <p>
                Collaborative learning groups
            </p>

        </div>

    </div>


    <!-- Verification -->

    <div class="verified">

        ✓ SkillSwap Member Activity Verified

        <br>

        <small>
            Verification is based on recorded SkillSwap
            exchanges, sessions and learning activity.
        </small>

    </div>


    <div class="back">

        <a href="dashboard.jsp" class="button">
            Back to Dashboard
        </a>

    </div>

</div>

</body>

</html>