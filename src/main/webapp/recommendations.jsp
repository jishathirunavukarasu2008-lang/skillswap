<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Smart Partner Recommendations - SkillSwap</title>

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

        .card {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .card h2 {
            margin-top: 0;
            color: #333;
        }

        .info {
            margin: 8px 0;
        }

        .skill {
            display: inline-block;
            padding: 8px 12px;
            background: #e8f4ff;
            color: #1769aa;
            border-radius: 20px;
            margin-top: 8px;
            font-weight: bold;
        }

        .match {
            margin-top: 15px;
            padding: 10px;
            background: #eaf7ea;
            color: #237a23;
            border-radius: 8px;
            font-weight: bold;
        }

        .button {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 18px;
            background: #333;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .button:hover {
            background: #555;
        }

        .empty {
            text-align: center;
            background: white;
            padding: 30px;
            border-radius: 12px;
            color: #666;
        }

        .back {
            text-align: center;
            margin-top: 25px;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>Smart Partner Recommendations</h1>

    <p class="subtitle">
        SkillSwap finds students who can teach you the skills you want to learn.
    </p>

    <%
        List<String[]> recommendations =
                (List<String[]>) request.getAttribute("recommendations");
    %>

    <% if (recommendations != null && !recommendations.isEmpty()) { %>

        <% for (String[] recommendation : recommendations) {

            String userId = recommendation[0];
            String fullName = recommendation[1];
            String username = recommendation[2];
            String bio = recommendation[3];
            String matchingSkill = recommendation[4];
        %>

            <div class="card">

                <h2><%= fullName %></h2>

                <div class="info">
                    <strong>Username:</strong>
                    <%= username %>
                </div>

                <div class="info">
                    <strong>Bio:</strong>
                    <%= bio != null && !bio.isEmpty()
                            ? bio
                            : "No bio available" %>
                </div>

                <div class="info">
                    <strong>They can teach you:</strong>
                </div>

                <div class="skill">
                    <%= matchingSkill %>
                </div>

                <div class="match">
                    ✓ Skill Match Found
                </div>

                <a href="exchange" class="button">
                    View Exchange Options
                </a>

            </div>

        <% } %>

    <% } else { %>

        <div class="empty">

            <h2>No recommendations yet</h2>

            <p>
                Add some skills you want to learn in
                <strong>My Skills</strong>.
            </p>

            <p>
                SkillSwap will then find students who can
                offer those skills.
            </p>

            <a href="my-skills" class="button">
                Manage My Skills
            </a>

        </div>

    <% } %>

    <div class="back">
        <a href="dashboard.jsp" class="button">
            Back to Dashboard
        </a>
    </div>

</div>

</body>
</html>
