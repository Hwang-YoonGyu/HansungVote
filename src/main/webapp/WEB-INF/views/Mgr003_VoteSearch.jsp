<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <form action="" method="" class="row g-3">
                        <span style="font-size: 30px;">투표 진행 현황</span>


                        <hr class="mt-4">
                        <div class="mb-3 rounded" style="background-color: hsl(228, 26%, 96%);
                            padding-top: 10px; padding-bottom: 10px;">
                            <label for="exampleFormControlTextarea1" class="form-label">선거 단위</label>
                            <select onchange="showValue(this)" class="form-select"
                                    aria-label="Default select example">
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
                            padding-top: 10px; padding-bottom: 60px;">

                            <div class="mb-3 rounded" style="background-color: hsl(228, 26%, 96%);
padding-top: 10px; padding-bottom: 60px;">
                                <p id="vote_change" style="text-align: center; padding-top: 10px;">
                                    ------------------------------------------------</p>
                                <hr class="mt-4">

                                <table class="table table-bordered border-white-50 " style="text-align: center;  ">
                                    <thead>
                                    <tr>
                                        <th class="rounded-start" scope="col"
                                            style="background-color:hsl(0, 0%, 41%) ; color: white;">학번
                                        </th>
                                        <th class="rounded-end" scope="col"
                                            style="background-color:hsl(0, 0%, 41%); color: white;">이름
                                        </th>
                                        <th class="rounded-start" scope="col"
                                            style="background-color:hsl(0, 0%, 41%) ; color: white;">전화번호
                                        </th>
                                        <th class="rounded-end" scope="col"
                                            style="background-color:hsl(0, 0%, 41%); color: white;">비밀번호
                                        </th>
                                        <th class="rounded-start" scope="col"
                                            style="background-color:hsl(0, 0%, 41%) ; color: white;">투표여부
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td style="background-color: white;">1971441</td>
                                        <td style="background-color: white;">임수빈</td>
                                        <td style="background-color: white;">010-9158-4899</td>
                                        <td style="background-color: white;">1234</td>
                                        <td style="background-color: white;">X</td>
                                    </tr>

                                    </tbody>
                                </table>


                                <div class="col-12">

                                </div>
                            </div>
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