<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>My Exchanges - SkillSwap</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f1fb;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 40px auto;
        }

        h1 {
            color: #4b2e83;
        }

        .card {
            background: white;
            padding: 25px;
            margin-top: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,.08);
        }

        .pending {
            color: #b26a00;
            font-weight: bold;
        }

        .accepted {
            color: green;
            font-weight: bold;
        }

        .rejected {
            color: red;
            font-weight: bold;
        }

        button {
            border: none;
            padding: 9px 15px;
            border-radius: 6px;
            color: white;
            cursor: pointer;
            margin-right: 8px;
        }

        .accept {
            background: #2e7d32;
        }

        .reject {
            background: #c62828;
        }

        a {
            color: #5b35a5;
            font-weight: bold;
            text-decoration: none;
        }

    </style>

</head>

<body>

<div class="container">

    <h1>My Exchange Requests</h1>

    <p>
        View and manage your SkillSwap exchange requests.
    </p>


    <%

        List<String[]> exchanges =
            (List<String[]>) request.getAttribute("exchanges");

        if (exchanges != null && !exchanges.isEmpty()) {

            for (String[] exchange : exchanges) {

                String exchangeId = exchange[0];
                String otherStudent = exchange[1];
                String offeredSkill = exchange[2];
                String wantedSkill = exchange[3];
                String status = exchange[4];

    %>

        <div class="card">

            <h2>
                Exchange with <%= otherStudent %>
            </h2>

            <p>
                <strong>They offer:</strong>
                <%= wantedSkill %>
            </p>

            <p>
                <strong>You offer:</strong>
                <%= offeredSkill %>
            </p>

            <p>
                <strong>Status:</strong>

                <span class="<%= status.toLowerCase() %>">
                    <%= status %>
                </span>

            </p>


            <% if ("PENDING".equals(status)) { %>

                <form action="exchange-action" method="post">

                    <input
                        type="hidden"
                        name="exchangeId"
                        value="<%= exchangeId %>"
                    >

                    <button
                        type="submit"
                        name="action"
                        value="ACCEPT"
                        class="accept"
                    >
                        Accept
                    </button>

                    <button
                        type="submit"
                        name="action"
                        value="REJECT"
                        class="reject"
                    >
                        Reject
                    </button>

                </form>

            <% } %>

        </div>

    <%

            }

        } else {

    %>

        <div class="card">

            <p>
                No exchange requests yet.
            </p>

        </div>

    <%

        }

    %>


    <p>

        <a href="dashboard.jsp">
            ← Back to Dashboard
        </a>

    </p>

</div>

</body>

</html>