<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>vote1Page</title>
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
            height: 100px;

        }

        /* body {
            margin-bottom: 0;

        } */
        /*
        div {
            display: block;
            margin: auto;
            position: relative;
        } */
    </style>



</head>

<body>

    <header class="fixed-top" style="border-bottom: 1px solid hsl(0, 0%, 56%);">
        <img src="/resources/img/Logo.png" style="height: 100px; border-bottom: 1px solid hsl(0, 0%, 56%);">

    </header>

    <main>
        <!-- <div class="container bg-white mt-4 p-4" style="width: 50%; margin: 0 auto; padding-top: 200px;">
            <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label">홍길동의 참여 가능 투표 목록 </label>
                <hr>
            </div>
            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">선거 단위</label>
                <select class="form-select" aria-label="Default select example">
                    <option selected>투표1</option>
                    <option value="1">투표2</option>
                    <option value="2">투표3</option>
                    <option value="3">투표4</option>
                </select>
            </div>
        </div> -->


        <div class="container">
            <div class="row">
                <div class="col-md-8 offset-md-2">
                    <div class="login-form bg-white mt-4 p-4 rounded">
                        <form action="" method="" class="row g-3">
                            <span style="font-size: 30px;"> ${username}<span style="font-size: 20px;"> 의 참여 가능 투표
                                    목록</span></span>


                            <hr class="mt-4">
                            <div class="mb-3 rounded" style="background-color: hsl(228, 26%, 96%);
                            padding-top: 10px; padding-bottom: 10px;">
                                <label for="exampleFormControlTextarea1" class="form-label">선거 단위</label>
                                <select onchange="showValue(this)" class="form-select" aria-label="Default select example">
                                    <a href="#">
                                        <option selected>투표1</option>
                                    </a>
                                    <a href="#">
                                        <option value="1">투표2</option>
                                    </a>
                                    <a href="#">
                                        <option value="2">투표3</option>
                                    </a>
                                    <a href="#">
                                        <option value="3">투표4</option>
                                    </a>
                                </select>
                            </div>

                            <div class="mb-3 rounded" style="background-color: hsl(228, 26%, 96%);
                            padding-top: 10px; padding-bottom: 800px;">
                                <label for="exampleFormControlTextarea1" class="form-label" id="vote_change">-------</label>
                                <hr class="mt-4">
                            </div>

                            <div class="col-12">

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
                <p style="text-align:center; color: hsl(0, 0%, 34%); padding: 2.5rem;">@2022 Team Coding Quokka All Rights Reserved</p>
            </div>
        </footer>
    </div>

    <script>
        const showValue = (target) => {
            const text = target.options[target.selectedIndex].text;
            document.getElementById('vote_change').innerHTML =`${text}`;
        }
    </script>
</body>

</html>