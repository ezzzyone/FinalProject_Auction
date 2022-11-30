<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
<script src="http://172.30.1.10/static/openvidu/app.js"></script>
<script src="http://172.30.1.10/static/openvidu/webcomp/openvidu-webcomponent-2.24.0.js"></script>
<link rel="stylesheet" href="/static/openvidu/webcomp/openvidu-webcomponent-2.24.0.css">
<link rel="stylesheet" href="/static/openvidu/app.css">
</head>
<body>
    <!-- Form to connect to a video-session -->
    <div id="main" style="text-align: center;">
        <h1>Join a video session</h1>
        <form onsubmit="joinSession(); return false" style="padding: 80px; margin: auto">
            <p>
                <label>Session:</label>
                <input type="text" id="sessionName" value="SessionA" required>
            </p>
            <p>
                <label>User:</label>
                <input type="text" id="user" value="User1" required>
            </p>
            <p>
                <input type="submit" value="JOIN">
            </p>
        </form>
    </div>

    <!-- OpenVidu Web Component -->
    <openvidu-webcomponent style="height : 100%;"></openvidu-webcomponent>
    
    
</body>
</html>