<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <title>voteSearchMgr</title>
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
            background-color: hsl(228, 26%, 96%);
            min-height: 1000px;
            margin-top: 100px;

        }

        footer {
            position: absolute;
            background-color: white;
            bottom: 0;
            width: 100%;
            height: 60px;

        }
    </style>
</head>

<body>

<header class="fixed-top" style="border-bottom: 1px solid hsl(0, 0%, 56%);">
    <img src="/resources/img/Logo.png" style="height: 100px; border-bottom: 1px solid hsl(0, 0%, 56%);">

</header>

<main>

    <div class="container">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="login-form bg-white mt-4 p-4 rounded">
                    <form action="/manager/addVoted" method="POST" class="row g-3">
                        <span style="font-size: 30px;">오프라인 투표 업데이트</span>


                        <hr class="mt-4">


                        <div class="mb-3 rounded" style="background-color: hsl(228, 26%, 96%);
                            padding-top: 10px; padding-bottom: 60px;">

                            <div class="input-group flex-nowrap">
                                <span class="input-group-text" id="stdId">학번</span>
                                <input name="stuId" type="text" class="form-control" placeholder="ex) 1971123"
                                       aria-label="stdId"
                                       aria-describedby="addon-wrapping">
                            </div>

                            <div class="input-group flex-nowrap" style="padding-top: 20px;">
                                <span class="input-group-text" id="name">이름</span>
                                <input name="name" type="text" class="form-control" placeholder="ex) 홍길동"
                                       aria-label="name"
                                       aria-describedby="addon-wrapping">
                            </div>

                        </div>
                        <div class="d-grid gap-2 col-3 mx-auto">

                            <input type="submit" class="btn btn-primary float-end" value="업로드 하기"/>
                        </div>

                    </form>

                </div>

            </div>
        </div>

    </div>


</main>

<div class="fixed-bottom">
    <footer>
        <div>
            <p style="text-align:center; color: hsl(0, 0%, 34%); padding: 1rem;">@2022 Team Coding Quokka All Rights
                Reserved</p>
        </div>
    </footer>
</div>
</body>