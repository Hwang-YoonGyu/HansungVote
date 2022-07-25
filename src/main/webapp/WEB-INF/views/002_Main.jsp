<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>loginPage</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://www.markuptag.com/bootstrap/5/css/bootstrap.min.css">


    <style>
        header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;

            height: 100px;
            background-color: white;

        }

        main {
            background-color: white;
            min-height: 500px;
        }

        footer {
            position: absolute;
            background-color: hsl(228, 26%, 96%);
            bottom: 0;
            width: 100%;
            height: 100px;

        }

        body {
            margin-bottom: 0;

        }

        div {
            display: block;
            margin: auto;
            position: relative;
        }
        /* .voteimg {
            width: 30%;
            margin: 10px;
           

            
        } */
        .wrapper{

            display: block;
            justify-content: center;
            align-items: center;
            

        }
    </style>



</head>

<body>

    <header style="border-bottom: 1px solid hsl(0, 0%, 56%);">
        <img src="resources/img/Logo.png" style="height: 100px; border-bottom: 1px solid hsl(0, 0%, 56%);">

    </header>

    <main>
        <div class="wrapper" style="margin-top: 250px;">

            <a href="#"><img class="rounded float-start" src="resources/img/voteimg1.png" style="width: 35%; margin-left: 200px;" onmouseenter="zoomIn(event)"
                onmouseleave="zoomOut(event)" alt="ì¨ë¼ì¸ í¬í ë°ë¡ê°ê¸°"></a>
            <a href="#"><img class="rounded float-end" src="resources/img/voteimg2.png"  style="width: 35%; margin-right: 200px;"onmouseenter="zoomIn(event)"
                onmouseleave="zoomOut(event)" alt="ì¤ë¬¸ì¡°ì¬ ë°ë¡ê°ê¸°"></a>

        </div>
    </main>


    <footer>
        <div>
            <p style="text-align:center; color: hsl(0, 0%, 34%); padding: 2.5rem;">@2022 Team HansungVote</p>
        </div>
    </footer>
    <script>
         function zoomIn(event) {
    event.target.style.transform = "scale(1.2)";
    event.target.style.zIndex = 1;
    event.target.style.transition = "all 0.4s";
  }

  function zoomOut(event) {
    event.target.style.transform = "scale(1)";
    event.target.style.zIndex = 0;
    event.target.style.transition = "all 0.4s";
  }
      </script>
</body>

</html>