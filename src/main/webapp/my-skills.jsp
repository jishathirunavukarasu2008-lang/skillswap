<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>My Skills - SkillSwap</title>

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

        .container {
            width: 90%;
            max-width: 900px;
            margin: 40px auto;
        }

        h1 {
            color: #4b2e83;
            margin-bottom: 10px;
        }

        .intro {
            color: #555;
            margin-bottom: 25px;
        }

        .message-success {
            color: green;
            font-weight: bold;
            margin: 15px 0;
        }

        .message-error {
            color: red;
            font-weight: bold;
            margin: 15px 0;
        }

        .panel {
            background: white;
            padding: 25px;
            margin-bottom: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .panel h2 {
            color: #4b2e83;
            margin-top: 0;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
        }

        input,
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }

        input:focus,
        select:focus {
            outline: none;
            border-color: #6c3fc5;
        }

        button {
            background: #5b35a5;
            color: white;
            border: none;
            padding: 12px 22px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
        }

        button:hover {
            background: #472986;
        }

        .skill-card {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            margin-top: 12px;
            background: #f5f3ff;
            border: 1px solid #ddd;
            border-radius: 10px;
        }

        .skill-name {
            font-size: 17px;
            font-weight: bold;
            color: #333;
        }

        .skill-type {
            padding: 6px 12px;
            border-radius: 15px;
            background: #6c3fc5;
            color: white;
            font-size: 13px;
            font-weight: bold;
        }

        .empty-message {
            color: #777;
            font-style: italic;
        }

        .navigation {
            margin-top: 25px;
        }

        .navigation a {
            text-decoration: none;
            color: #5b35a5;
            font-weight: bold;
            margin-right: 20px;
        }

        .navigation a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>My Skills</h1>

    <p class="intro">
        Hi <%= ((com.skillswap.model.User) session.getAttribute("loggedInUser")).getFullName() %>!
        Manage the skills you offer and want to learn.
    </p>


    <!-- Success / Error Messages -->

    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");

        if ("1".equals(success)) {
    %>

        <p class="message-success">
            Skill added successfully!
        </p>

    <%
        }

        if ("1".equals(error)) {
    %>

        <p class="message-error">
            You have already added this skill with this type.
        </p>

    <%
        }

        if ("invalid".equals(error)) {
    %>

        <p class="message-error">
            Please enter a valid skill name and skill type.
        </p>

    <%
        }
    %>


    <!-- Add Skill -->

    <div class="panel">

        <h2>Add a Skill</h2>

        <p>
            Choose whether you want to teach or learn this skill.
        </p>

        <form action="my-skills" method="post">

            <div class="form-group">

                <label for="skillName">
                    Skill Name
                </label>

                <input
                    type="text"
                    id="skillName"
                    name="skillName"
                    placeholder="Example: Java, Python, UI Design"
                    maxlength="100"
                    required>

            </div>


            <div class="form-group">

                <label for="skillType">
                    Skill Type
                </label>

                <select
                    id="skillType"
                    name="skillType"
                    required>

                    <option value="">
                        -- Select Skill Type --
                    </option>

                    <option value="OFFER">
                        I can teach this (OFFER)
                    </option>

                    <option value="WANT">
                        I want to learn this (WANT)
                    </option>

                </select>

            </div>


            <button type="submit">
                Add Skill
            </button>

        </form>

    </div>


    <!-- Saved Skills -->

    <div class="panel">

        <h2>My Skills List</h2>

        <%

            java.util.List<String[]> skillsList =
                (java.util.List<String[]>) request.getAttribute("skillsList");

            if (skillsList != null && !skillsList.isEmpty()) {

                for (String[] skill : skillsList) {

        %>

                    <div class="skill-card">

                        <span class="skill-name">
                            <%= skill[0] %>
                        </span>

                        <span class="skill-type">
                            <%= skill[1] %>
                        </span>

                    </div>

        <%

                }

            } else {

        %>

                <p class="empty-message">
                    No skills added yet.
                </p>

        <%

            }

        %>

    </div>


    <!-- Navigation -->

    <div class="navigation">

        <a href="dashboard.jsp">
            ← Back to Dashboard
        </a>

        <a href="logout">
            Logout
        </a>

    </div>

</div>

</body>
</html>