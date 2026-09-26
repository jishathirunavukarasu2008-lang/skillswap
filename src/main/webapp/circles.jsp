<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>SkillSwap Circles</title>

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
        textarea {
            width: 100%;
            padding: 10px;
            margin: 8px 0 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        textarea {
            min-height: 90px;
            resize: vertical;
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

        .circle {
            border: 1px solid #ddd;
            padding: 18px;
            margin: 15px 0;
            border-radius: 8px;
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

    <h1>SkillSwap Circles</h1>

    <p>
        Join small collaborative learning groups and learn together.
    </p>


    <!-- ===================================================== -->
    <!-- SUCCESS / ERROR MESSAGES -->
    <!-- ===================================================== -->

    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");

        if ("created".equals(success)) {
    %>

        <div class="message">
            Circle created successfully!
        </div>

    <%
        }

        if ("joined".equals(success)) {
    %>

        <div class="message">
            You joined the circle successfully!
        </div>

    <%
        }

        if ("alreadyjoined".equals(error)) {
    %>

        <div class="message error">
            You are already a member of this circle.
        </div>

    <%
        }

        if ("invalid".equals(error)) {
    %>

        <div class="message error">
            Please enter valid information.
        </div>

    <%
        }

        if ("1".equals(error)) {
    %>

        <div class="message error">
            Unable to process the circle request.
        </div>

    <%
        }
    %>


    <!-- ===================================================== -->
    <!-- CREATE CIRCLE -->
    <!-- ===================================================== -->

    <div class="card">

        <h2>Create a Learning Circle</h2>

        <form action="circles" method="post">

            <input type="hidden"
                   name="action"
                   value="CREATE">

            <label>
                Circle Name
            </label>

            <input type="text"
                   name="circleName"
                   placeholder="Example: Java Programming Circle"
                   required>


            <label>
                Description
            </label>

            <textarea
                    name="description"
                    placeholder="Describe what members will learn together..."
                    required></textarea>


            <button type="submit">
                Create Circle
            </button>

        </form>

    </div>


    <!-- ===================================================== -->
    <!-- AVAILABLE CIRCLES -->
    <!-- ===================================================== -->

    <div class="card">

        <h2>Available Circles</h2>

        <%
            List<String[]> allCircles =
                    (List<String[]>) request.getAttribute("allCircles");

            if (allCircles != null &&
                !allCircles.isEmpty()) {

                for (String[] circle : allCircles) {

                    String circleId = circle[0];
                    String circleName = circle[1];
                    String description = circle[2];
                    String creator = circle[3];
        %>

        <div class="circle">

            <h3>
                <%= circleName %>
            </h3>

            <p>
                <%= description %>
            </p>

            <p>
                <strong>Created by:</strong>
                <%= creator %>
            </p>

            <form action="circles" method="post">

                <input type="hidden"
                       name="action"
                       value="JOIN">

                <input type="hidden"
                       name="circleId"
                       value="<%= circleId %>">

                <button type="submit">
                    Join Circle
                </button>

            </form>

        </div>

        <%
                }

            } else {
        %>

        <p>
            No learning circles available yet.
        </p>

        <%
            }
        %>

    </div>


    <!-- ===================================================== -->
    <!-- MY CIRCLES -->
    <!-- ===================================================== -->

    <div class="card">

        <h2>My Learning Circles</h2>

        <%
            List<String[]> myCircles =
                    (List<String[]>) request.getAttribute("myCircles");

            if (myCircles != null &&
                !myCircles.isEmpty()) {

                for (String[] circle : myCircles) {

                    String circleId = circle[0];
                    String circleName = circle[1];
                    String description = circle[2];
        %>

        <div class="circle">

            <h3>
                <%= circleName %>
            </h3>

            <p>
                <%= description %>
            </p>

            <p>
                <strong>Circle ID:</strong>
                <%= circleId %>
            </p>

            <p>
                <strong>Status:</strong>
                Member
            </p>

        </div>

        <%
                }

            } else {
        %>

        <p>
            You haven't joined any learning circles yet.
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