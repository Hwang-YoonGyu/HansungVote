<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>loginPage</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
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
            background-color: hsl(228, 26%, 96%);
            min-height: 800px;
        }

        div {
            display: block;
            margin: auto;
            position: relative;
        }
    </style>



</head>

<body>

<header>
    <img src="resources/img/Logo.png" style="height: 100px;">
</header>

<main>
    <div class="container-fulid" style="margin-top: 100px;">
        <div class="row">
            <div class="col-md-4 offset-md-4">
                <div class="login-form bg-light mt-4 p-4">
                    <form action="/login" method="post" class="row g-3">
                        <h4>한성대학교 온라인 투표 시스템</h4>
                        <div class="col-12">
                            <label>Student ID</label>
                            <input id="userId" name="stu_id" type="text" class="form-control" placeholder="학번">
                        </div>
                        <div class="col-12">
                            <label>Password</label>
                            <input id="password" name="password" type="password" class="form-control" placeholder="비밀번호">
                        </div>

                        <div class="col-12">

                            <input type="submit" class="btn btn-primary float-end" value="log in"/>

                        </div>
                    </form>
                    <hr class="mt-4">

                </div>
            </div>
        </div>
    </div>
</main>


<footer>

</footer>
</div>

</body>

</html>