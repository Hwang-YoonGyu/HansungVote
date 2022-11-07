<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                        <span style="font-size: 30px;">선거 관리</span>


                        <hr class="mt-4">
                        <pre>*대상 ex) A = 단과대 (IT공과대학, 디자인대학 ...)
         A01 = 학부생 (컴퓨터공학부, 기계전자공학부 ...)
         A011 = 트랙학생 (모바일소프트웨어트랙, 빅데이터트랙 ...)
         없을시 모든학생  </pre>

                        <div class="mb-3 rounded" style="background-color: hsl(228, 26%, 96%);
                            padding-top: 10px; padding-bottom: 60px;">
                            <div>
                            </div>
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">

                                <button onclick="location.href ='/mgr/addUserDB'" class="btn btn-success"
                                        type="button" style="margin-bottom: 30px">유권자 DB 추가
                                </button>

                                <button onclick="location.href ='/mgr/modifyElection'" class="btn btn-primary"
                                        type="button" style="margin-bottom: 30px">선거,후보 추가
                                </button>

                                <button onclick="location.href ='/mgr/addVoted'" class="btn btn-warning"
                                        type="button" style="margin-bottom: 30px">오프라인 투표 추가
                                </button>


                            </div>


                            <table class="table table-bordered border-white-50 " style="text-align: center;">
                                <thead>
                                <tr>
                                    <th class="rounded-start" scope="col"
                                        style="background-color:hsl(0, 0%, 41%) ; color: white;">대상
                                    </th>
                                    <th class="rounded-start" scope="col"
                                        style="background-color:hsl(0, 0%, 41%) ; color: white;">선거이름
                                    </th>
                                    <th class="rounded-end" scope="col"
                                        style="background-color:hsl(0, 0%, 41%); color: white;">시작날짜
                                    </th>
                                    <th class="rounded-start" scope="col"
                                        style="background-color:hsl(0, 0%, 41%) ; color: white;">종료날짜
                                    </th>
                                    <th class="rounded-end" scope="col"
                                        style="background-color:hsl(0, 0%, 41%); color: white;">관리
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${electionList}" var="ElectionVO" varStatus="status">
                                    <tr>
                                        <c:set var="start"><fmt:formatDate value="${ElectionVO.startDate}"
                                                                           pattern="yyyy-MM-dd HH:mm"/></c:set>
                                        <c:set var="end"><fmt:formatDate value="${ElectionVO.endDate}"
                                                                         pattern="yyyy-MM-dd HH:mm"/></c:set>


                                        <td style="background-color: white;">${ElectionVO.department}</td>
                                        <td style="background-color: white;">${ElectionVO.electionName}</td>
                                        <td style="background-color: white;">${start}</td>
                                        <td style="background-color: white;">${end}</td>
                                        <td style="background-color: white;">
                                            <button onclick="deleteAction('${ElectionVO.electionName}')"
                                                    type="button"
                                                    class="btn btn-outline-danger btn-sm">삭제
                                            </button>
                                            <button onclick="location.href ='/mgr/showTurnOutList?electionName=${ElectionVO.electionName}'"
                                                    type="button"
                                                    class="btn btn-outline-primary btn-sm">조회
                                            </button>
                                            <button onclick="location.href ='/mgr/ballotCount?electionName=${ElectionVO.electionName}'"
                                                    type="button"
                                                    class="btn btn-outline-primary btn-sm">개표
                                            </button>
                                        </td>

                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <button onclick=userDateDelete() class="btn btn-danger"
                                        type="button" style="margin-bottom: 30px">유권자 DB 전체삭제
                                </button>
                                <button onclick=electionDataDelete() class="btn btn-danger"
                                        type="button" style="margin-bottom: 30px">선거 DB 전체삭제
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>
<script>
    function deleteAction(electionName) {
        var result = confirm(electionName + "을 삭제하시겠습니까?");
        if (result == true) {
            location.href = '/mgr/deleteElection?electionName=' + electionName;
        }
    }
    function userDateDelete() {
        var result = confirm("전체 유저 정보를 삭제하시겠습니까?");
        if (result == true) {
            location.href = '/mgr/userDataDelete';
        }
    }
    function electionDataDelete() {
        var result = confirm("전체 선거 정보를 삭제하시겠습니까?");
        if (result == true) {
            location.href = '/mgr/electionDataDelete';
        }
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
</body>