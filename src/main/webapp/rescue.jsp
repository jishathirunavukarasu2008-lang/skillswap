<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>SkillSwap Rescue</title>

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
            max-width: 1000px;
            margin: 40px auto;
        }

        h1 {
            color: #4b2e83;
        }

        .intro {
            color: #666;
            margin-bottom: 25px;
        }

        .panel {
            background: white;
            padding: 25px;
            margin-bottom: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,.08);
        }

        .exchange {
            border: 1px solid #ddd;
            padding: 20px;
            margin-top: 15px;
            border-radius: 10px;
        }

        .exchange h3 {
            color: #4b2e83;
            margin-top: 0;
        }

        textarea {
            width: 100%;
            min-height: 90px;
            padding: 10px;
            margin-top: 8px;
            border: 1px solid #ccc;
            border-radius: 7px;
            resize: vertical;
        }

        button {
            margin-top: 12px;
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

        .request {
            border-left: 5px solid #6c3fc5;
            background: #faf8ff;
            padding: 18px;
            margin-top: 15px;
            border-radius: 8px;
        }

        .open {
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

    <h1>SkillSwap Rescue</h1>

    <p class="intro">
        If an exchange is disrupted, you can create a rescue request
        and look for another way to continue your learning.
    </p>


    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");

        if ("1".equals(success)) {
    %>

        <p class="success">
            Rescue request created successfully!
        </p>

    <%
        }

        if ("1".equals(error)) {
    %>

        <p class="error">
            Unable to create rescue request.
        </p>

    <%
        }

        if ("empty".equals(error)) {
    %>

        <p class="error">
            Please enter a reason for the rescue request.
        </p>

    <%
        }

        List<String[]> acceptedExchanges =
                (List<String[]>) request.getAttribute(
                        "acceptedExchanges"
                );
    %>


    <!-- CREATE RESCUE REQUEST -->

    <div class="panel">

        <h2>Request Rescue</h2>

        <p>
            Select an accepted exchange that has been disrupted.
        </p>


        <%

            if (acceptedExchanges != null &&
                !acceptedExchanges.isEmpty()) {

                for (String[] exchange :
                        acceptedExchanges) {

                    String exchangeId = exchange[0];

        %>

                    <div class="exchange">

                        <h3>
                            Exchange #<%= exchangeId %>
                        </h3>

                        <p>
                            Status:
                            <strong>
                                <%= exchange[3] %>
                            </strong>
                        </p>

                        <form action="rescue" method="post">

                            <input
                                type="hidden"
                                name="exchangeId"
                                value="<%= exchangeId %>"
                            >

                            <label>
                                <strong>
                                    Why do you need Rescue?
                                </strong>
                            </label>

                            <textarea
                                name="reason"
                                placeholder="Example: My exchange partner is unavailable."
                                required
                            ></textarea>

                            <br>

                            <button type="submit">
                                Create Rescue Request
                            </button>

                        </form>

                    </div>

        <%

                }

            } else {

        %>

            <p class="warning">
                You currently have no accepted exchanges
                available for Rescue.
            </p>

            <p>
                First create an exchange and get it accepted.
            </p>

        <%

            }

        %>

    </div>


    <!-- MY RESCUE REQUESTS -->

    <div class="panel">

        <h2>My Rescue Requests</h2>

        <%

            List<String[]> rescueRequests =
                    (List<String[]>) request.getAttribute(
                            "rescueRequests"
                    );

            if (rescueRequests != null &&
                !rescueRequests.isEmpty()) {

                for (String[] rescue :
                        rescueRequests) {

        %>

                    <div class="request">

                        <p>
                            <strong>
                                Rescue #<%= rescue[0] %>
                            </strong>
                        </p>

                        <p>
                            <strong>
                                Exchange:
                            </strong>
                            #<%= rescue[1] %>
                        </p>

                        <p>
                            <strong>
                                Reason:
                            </strong>
                            <%= rescue[2] %>
                        </p>

                        <p>
                            <strong>
                                Status:
                            </strong>

                            <span class="open">
                                <%= rescue[3] %>
                            </span>

                        </p>

                        <p>
                            <strong>
                                Created:
                            </strong>
                            <%= rescue[4] %>
                        </p>

                    </div>

        <%

                }

            } else {

        %>

            <p>
                You have not created any rescue requests yet.
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