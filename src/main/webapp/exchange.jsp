<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Skill Exchange - SkillSwap</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f1fb;
            margin: 0;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 40px auto;
        }

        h1 {
            color: #4b2e83;
        }

        .panel {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,.08);
        }

        .skill {
            border: 1px solid #ddd;
            padding: 20px;
            margin-top: 15px;
            border-radius: 10px;
            background: #fff;
        }

        .skill h3 {
            margin-top: 0;
            color: #4b2e83;
        }

        .student-info {
            background: #f8f5ff;
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
        }

        .student-info p {
            margin: 7px 0;
        }

        select {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            margin-bottom: 15px;
        }

        button {
            background: #5b35a5;
            color: white;
            border: none;
            padding: 11px 18px;
            border-radius: 7px;
            cursor: pointer;
            font-weight: bold;
        }

        button:hover {
            background: #472986;
        }

        .success {
            color: green;
            font-weight: bold;
        }

        .error {
            color: red;
            font-weight: bold;
        }

        .warning {
            color: #b26a00;
            font-weight: bold;
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

    <h1>Skill Exchange</h1>

    <p>
        Find other students and exchange skills without money.
    </p>


    <%

        String success = request.getParameter("success");
        String error = request.getParameter("error");

        if ("1".equals(success)) {

    %>

        <p class="success">
            Exchange request sent successfully!
        </p>

    <%

        }

        if ("1".equals(error)) {

    %>

        <p class="error">
            Unable to send exchange request.
        </p>

    <%

        }

        List<String[]> availableSkills =
                (List<String[]>) request.getAttribute(
                        "availableSkills"
                );

        List<String[]> myOfferedSkills =
                (List<String[]>) request.getAttribute(
                        "myOfferedSkills"
                );

    %>


    <div class="panel">

        <h2>Available Skills</h2>

        <p>
            Choose a skill offered by another student.
        </p>


        <%

            if (availableSkills != null &&
                !availableSkills.isEmpty()) {

                for (String[] skill : availableSkills) {

                    String receiverId = skill[0];

                    String wantedSkillId = skill[1];

                    String skillName = skill[2];

                    String skillType = skill[3];

                    String studentName = skill[4];

                    String username = skill[5];

                    String bio = skill[6];

        %>


                    <div class="skill">

                        <h3>
                            Skill: <%= skillName %>
                        </h3>


                        <div class="student-info">

                            <h3>
                                Student Information
                            </h3>

                            <p>
                                <strong>Name:</strong>
                                <%= studentName %>
                            </p>

                            <p>
                                <strong>Username:</strong>
                                <%= username %>
                            </p>

                            <p>
                                <strong>Bio:</strong>

                                <%= (bio == null ||
                                     bio.trim().isEmpty())
                                     ? "No bio added yet."
                                     : bio %>

                            </p>

                            <p>
                                <strong>Skill Offered:</strong>
                                <%= skillName %>
                            </p>

                        </div>


                        <p>
                            <strong>Skill Type:</strong>
                            <%= skillType %>
                        </p>


                        <%

                            if (myOfferedSkills != null &&
                                !myOfferedSkills.isEmpty()) {

                        %>


                            <form action="exchange"
                                  method="post">

                                <input
                                    type="hidden"
                                    name="receiverId"
                                    value="<%= receiverId %>"
                                >

                                <input
                                    type="hidden"
                                    name="wantedSkillId"
                                    value="<%= wantedSkillId %>"
                                >


                                <label>

                                    <strong>
                                        Select your skill to offer:
                                    </strong>

                                </label>


                                <select
                                    name="offeredSkillId"
                                    required
                                >

                                    <option value="">
                                        -- Select your skill --
                                    </option>


                                    <%

                                        for (String[] mySkill :
                                             myOfferedSkills) {

                                    %>

                                        <option
                                            value="<%= mySkill[0] %>"
                                        >

                                            <%= mySkill[1] %>

                                        </option>

                                    <%

                                        }

                                    %>

                                </select>


                                <button type="submit">

                                    Send Exchange Request

                                </button>

                            </form>


                        <%

                            } else {

                        %>


                            <p class="warning">

                                You have not added any skills
                                that you can offer yet.

                            </p>


                            <p>

                                Go to

                                <a href="my-skills">
                                    My Skills
                                </a>

                                and add an OFFER skill first.

                            </p>


                        <%

                            }

                        %>

                    </div>


        <%

                }

            } else {

        %>


            <p>
                No other students have offered skills yet.
            </p>


            <p>

                Ask another student to add an OFFER skill
                from the My Skills page.

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