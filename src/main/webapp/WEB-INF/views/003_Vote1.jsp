<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.codingquokka.hansungenquete.domain.ElectionVO" %>
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

        /* .time_td {
            background-color: white;
        } */


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
                            <span style="font-size: 30px;"> ${username} <span style="font-size: 20px;"> 의 참여 가능 투표
                                    목록</span></span>


                        <hr class="mt-4">
                        <div class="mb-3 rounded" style="background-color: hsl(228, 26%, 96%);
                            padding-top: 10px; padding-bottom: 10px;">
                            <label class="form-label">선거 단위</label>
                            <select onchange=getIndex() class="form-select" aria-label="Default select example"
                                    id="select">
                                <c:forEach items="${electionList}" var="ElectionVO" varStatus="status">
                                    <a href=\"#\>
                                        <option id=status">${ElectionVO.electionName}</option>
                                    </a>"/>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3 rounded" style="background-color: hsl(228, 26%, 96%);
                            padding-top: 10px; padding-bottom: 60px;">
                            <p id="election_name" style="text-align: center; padding-top: 10px;">
                                ${electionList[0].electionName}
                            </p>
                            <hr class="mt-4">

                            <div class="container" style="padding-bottom: 20px; text-align:center;">
                                <div class="row">
                                    <div class="col">
                                        <img src="/resources/img/clock.png" class="img-fluid" alt="clockimg"
                                             style="width: 30px; height: 30px; background-color: transparent;">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col" style="padding-top: 10px;">
                                        투표 가능 기간
                                    </div>
                                </div>
                            </div>


                            <table class="table table-bordered border-white-50 " style="text-align: center;  ">
                                <thead>
                                <tr>
                                    <th class="rounded-start" scope="col"
                                        style="background-color:hsl(0, 0%, 41%) ; color: white;">투표 시작 시간
                                    </th>
                                    <th class="rounded-end" scope="col"
                                        style="background-color:hsl(0, 0%, 41%); color: white;">투표 종료 시간
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td style="background-color: white;">7/20 10:00</td>
                                    <td style="background-color: white;">7/21 23:00</td>

                                </tr>
                                <tr>
                                    <td style="background-color: white;">7/20 10:00</td>
                                    <td style="background-color: white;">7/21 23:00</td>
                                </tr>

                                </tbody>
                            </table>


                            <div class="container" style="padding-top: 50px; text-align:center;">
                                <div class="row">
                                    <div class="col" style="border-right: 1px solid gray;">
                                        총 유권자 수
                                    </div>
                                    <div class="col" style="border-right: 1px solid gray;">
                                        실시간 투표율
                                    </div>
                                    <div class="col">
                                        투표 종료까지
                                    </div>
                                </div>
                                <div class="row" style="padding-top: 10px;">
                                    <div class="col" style="border-right: 1px solid gray;">
                                        <img src="/resources/img/person.png" class="img-fluid" alt="personimg"
                                             style="width: 60px; height: 60px; background-color: transparent;">
                                    </div>
                                    <div class="col" style="border-right: 1px solid gray;">
                                        <img src="/resources/img/vote.png" class="img-fluid" alt="voteimg"
                                             style="width: 60px; height: 60px; background-color: transparent;">
                                    </div>
                                    <div class="col">
                                        <img src="/resources/img/bomb.png" class="img-fluid" alt="bombimg"
                                             style="width: 60px; height: 60px; background-color: transparent;">
                                    </div>
                                </div>

                                <div class="row" style="padding-top: 10px;">
                                    <div id="person" class="col" style="border-right: 1px solid gray;">
                                        ${voteRightCountList[0]}
                                    </div>
                                    <div id="vote" class="col" style="border-right: 1px solid gray;">
                                        ${votePercentageList[0]}
                                    </div>
                                    <div id="bomb" class="col">
                                        1일, 2시간
                                    </div>
                                </div>
                            </div>


                            <div class="d-grid gap-2 col-6 mx-auto" style="padding-top: 50px;">
                                <a href="/vote/voteDetail?electionName=${electionList[0].electionName}"
                                   class="btn btn-primary" tabindex="-1" role="button" id="DetailButton"
                                   aria-disabled="true">상세 페이지로</a>
                            </div>
                        </div>

                        <div class="col-12">

                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
    <script>
        function getIndex() {
            var votePercentageList = ${votePercentageList};
            var voteRightCountList = ${voteRightCountList};

            var select = document.getElementById("select");
            var index = select.selectedIndex;
            var vote = document.getElementById("vote");
            var person = document.getElementById("person");
            var electionName = document.getElementById("election_name");
            var detailButton = document.getElementById("DetailButton");


            vote.innerHTML = votePercentageList[index];
            person.innerHTML = voteRightCountList[index];
            electionName.innerHTML = select.options[index].value;
            detailButton.href = "/vote/voteDetail?electionName=" + select.options[index].value;
        }

    </script>

    <div class="fixed-bottom">
        <footer>
            <div>
                <p style="text-align:center; color: hsl(0, 0%, 34%); padding: 1rem;">@2022 Team Coding Quokka All Rights
                    Reserved</p>
            </div>
        </footer>
    </div>
</main>
</body>