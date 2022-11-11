
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <link rel="shortcut icon" type="image/x-icon" href="/resources/img/codingquokka.png">
    <title>한성대학교 온라인 투표 시스템</title>
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
            min-height: 800px;
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
    <div style="text-align: center;">
        <div class="sticky-md-top">
            <img src="/resources/img/errorbugi.png" class="rounded mx-auto d-block" alt="error"style="width:700px; height=750px">
        </div>
        <div style="text-align: left; margin-left: 520px;">
            <p class="fs-1" style="color: darkblue;">죄송합니다. 요청하신 페이지를 찾을 수 없습니다.</p>
            <p class="fs-2" style="margin-top: -20px;">서비스 이용에 불편을 드려 죄송합니다.</p>
            <p class="fs-4" style="color:dimgray; margin-top: 20px;">요청하신 페이지로 이동하지 못했습니다.</p>
            <p class="fs-4" style="color:dimgray; margin-top: -20px;">잠시 후에 다시 한번 시도해주세요.</p>
        </div>
        <button href="/" type="button" class="btn btn-outline-primary" style="text-align: center; margin-top: 100px;">로그인 페이지로 돌아가기</button>
    </div>
</main>
ß
<div class="fixed-bottom">
    <footer>
        <div>
            <p style="text-align:center; color: hsl(0, 0%, 34%); padding: 1rem;">@2022 Team Coding Quokka All Rights
                Reserved</p>
        </div>
    </footer>
</div>
</body>