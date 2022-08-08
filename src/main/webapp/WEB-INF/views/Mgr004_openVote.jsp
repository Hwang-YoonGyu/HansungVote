<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
            min-height: 2000px;
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
                    <form action="/manager/modifyElection" method="post" class="row g-3" id="formId">
                        <span style="font-size: 30px;">투표 개설 및 수정</span>


                        <hr class="mt-4">


                        <div class="mb-3 rounded" style="background-color: hsl(228, 26%, 96%);
                            padding-top: 10px; padding-bottom: 20px;">


                            <div class="container">
                                <div class="row">
                                    <div class="col-2">선거이름</div>
                                    <div class="col-10">
                                        <div class="input-group mb-3">
                                            <input id="electionName" name="electionName" value="" type="text" class="form-control" placeholder="선거이름을 입력해주세요."
                                                   aria-label="voteName" aria-describedby="voteNamebutton">
                                        </div>
                                    </div>
                                </div>

                                <hr class="mt-4">
                                <div class="row">
                                    <div class="col-2">후보자 등록</div>
                                    <div class="col-10">
                                        <div class="btn-group" role="group" aria-label="Basic example">
                                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                                <button width="100" height="100" id="addcandidate" class="btn btn-primary btn-sm" type="button" onclick="addRow()"> +
                                                </button>
                                            </div>
                                            &nbsp
                                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                                <button width="100" height="100" id="subcandidate" class="btn btn-primary btn-sm" type="button" onclick="deleteRow()"> -
                                                 </button>
                                            </div>
                                        </div>
                                        <table class="table table-bordered border-white-50 "
                                               style="text-align: center;  ">
                                            <thead>
                                            <tr >
                                                <th class="rounded-end" width="400" scope="col" style="background-color:hsl(0, 0%, 41%); color: white;">후보자
                                                    이름
                                                </th>
                                                <th class="rounded-start" width="400" scope="col" style="background-color:hsl(0, 0%, 41%) ; color: white;">후보자
                                                    포스터
                                                </th>
                                            </tr>

                                            </thead>

                                            <tbody id="addrow">

                                            </tbody>
                                        </table>

                                    </div>
                                </div>

                                <hr class="mt-4">
                                <div class="row">
                                    <div class="col-2">투표 시작 시간</div>
                                    <div class="col-10">
                                        <input type="date" id="startDate" name="startDate"><input type="time" id="startTime" name="startTime">
                                    </div>
                                </div>

                                <hr class="mt-4">
                                <div class="row">
                                    <div class="col-2">투표 종료 시간</div>
                                    <div class="col-10">
                                        <input type="date" id="endDate" name="endDate"><input type="time" id="endTime" name="endTime">
                                    </div>
                                </div>

                                <hr class="mt-4">
                                <div class="row">
                                    <div class="col-2" style="border-right: 1px solid gray; text-align: center;">
                                        크리에이티브인문예술대학
                                        <div style="margin-top:50px;">전체선택
                                            <input type='checkbox' name="Pbox" value="전체선택"
                                                   onclick='selectAll(this, "P")'/>
                                        </div>
                                    </div>
                                    <div class="col-10">

                                        <div class="btn-group" role="group"
                                             aria-label="Basic checkbox toggle button group">
                                            <input type="checkbox" class="btn-check" id="Pbtncheck1" name="P" value="P011"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Pbtncheck1">영미문학문화트랙</label>

                                            <input type="checkbox" class="btn-check" id="Pbtncheck2" name="P" value="P012"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Pbtncheck2">영미언어정보트랙</label>

                                            <input type="checkbox" class="btn-check" id="Pbtncheck3" name="P" value="P013"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Pbtncheck3">한국어교육트랙</label>


                                            <input type="checkbox" class="btn-check" id="Pbtncheck4" name="P" value="P014"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Pbtncheck4">문학문화콘텐츠트랙</label>

                                            <input type="checkbox" class="btn-check" id="Pbtncheck5" name="P" value="P015"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Pbtncheck5">글로컬역사트랙</label>

                                            <input type="checkbox" class="btn-check" id="Pbtncheck6" name="P" value="P016"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Pbtncheck6">역사문화콘텐츠트랙</label>

                                            <input type="checkbox" class="btn-check" id="Pbtncheck7" name="P" value="P017"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Pbtncheck7">도서관정보문화트랙</label>

                                            <input type="checkbox" class="btn-check" id="Pbtncheck8" name="P" value="P018"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Pbtncheck8">디지털인문정보학트랙</label>

                                            <input type="checkbox" class="btn-check" id="Pbtncheck9" name="P" value="P021"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Pbtncheck9">동양화전공</label>

                                            <input type="checkbox" class="btn-check" id="Pbtncheck10" name="P" value="P022"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Pbtncheck10">서양화전공</label>

                                            <input type="checkbox" class="btn-check" id="Pbtncheck11" name="P" value="P023"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Pbtncheck11">한국무용전공</label>

                                            <input type="checkbox" class="btn-check" id="Pbtncheck12" name="P" value="P024"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Pbtncheck12">현대무용전공</label>

                                            <input type="checkbox" class="btn-check" id="Pbtncheck13" name="P" value="P025"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Pbtncheck13">발레전공</label>

                                            <input type="checkbox" class="btn-check" id="Pbtncheck14" name="P" value="P026"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Pbtncheck14">이민&다문화트랙</label>

                                        </div>
                                    </div>

                                </div>


                                <hr class="mt-4">
                                <div class="row">
                                    <div class="col-2" style="border-right: 1px solid gray; text-align: center;">
                                        미래융합사회과학대학
                                        <div style="margin-top:50px;">전체선택
                                            <input type='checkbox' name="Rbox" value="전체선택"
                                                   onclick='selectAll(this, "R")'/>
                                        </div>
                                    </div>
                                    <div class="col-10">

                                        <div class="btn-group" role="group"
                                             aria-label="Basic checkbox toggle button group">
                                            <input type="checkbox" class="btn-check" id="Rbtncheck1" name="R" value="R011"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Rbtncheck1">국제무역트랙</label>

                                            <input type="checkbox" class="btn-check" id="Rbtncheck2" name="R" value="R012"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Rbtncheck2">글로벌비즈니스트랙</label>

                                            <input type="checkbox" class="btn-check" id="Rbtncheck3" name="R" value="R013"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Rbtncheck3">기업&경제분석트랙</label>


                                            <input type="checkbox" class="btn-check" id="Rbtncheck4" name="R" value="R014"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Rbtncheck4">금융&데이터분석트랙</label>

                                            <input type="checkbox" class="btn-check" id="Rbtncheck5" name="R" value="R015"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Rbtncheck5">공공행정트랙</label>

                                            <input type="checkbox" class="btn-check" id="Rbtncheck6" name="R" value="R016"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Rbtncheck6">법&정책트랙</label>

                                            <input type="checkbox" class="btn-check" id="Rbtncheck7" name="R" value="R017"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Rbtncheck7">부동산트랙</label>

                                            <input type="checkbox" class="btn-check" id="Rbtncheck8" name="R" value="R018"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Rbtncheck8">스마트도시&교통계획트랙</label>

                                            <input type="checkbox" class="btn-check" id="Rbtncheck9" name="R" value="R019"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Rbtncheck9">기업경영트랙</label>

                                            <input type="checkbox" class="btn-check" id="Rbtncheck10" name="R" value="R01A"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Rbtncheck10">벤처경영트랙</label>

                                            <input type="checkbox" class="btn-check" id="Rbtncheck11" name="R" value="R01B"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Rbtncheck11">회계&재무경영트랙</label>


                                        </div>
                                    </div>

                                </div>


                                <hr class="mt-4">
                                <div class="row">
                                    <div class="col-2" style="border-right: 1px solid gray; text-align: center;">
                                        디자인대학
                                        <div style="margin-top:50px;">전체선택
                                            <input type='checkbox' name="Tbox" value="전체선택"
                                                   onclick='selectAll(this, "T")'/>
                                        </div>
                                    </div>
                                    <div class="col-10">

                                        <div class="btn-group" role="group"
                                             aria-label="Basic checkbox toggle button group">
                                            <input type="checkbox" class="btn-check" id="Tbtncheck1" name="T" value="T011"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Tbtncheck1">패션마케팅트랙</label>

                                            <input type="checkbox" class="btn-check" id="Tbtncheck2" name="T" value="T012"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Tbtncheck2">패션디자인트랙</label>

                                            <input type="checkbox" class="btn-check" id="Tbtncheck3" name="T" value="T013"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Tbtncheck3">패션크리에이티브디렉션트랙</label>

                                            <input type="checkbox" class="btn-check" id="Tbtncheck4" name="T" value="T021"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Tbtncheck4">뉴미디어광고&커뮤니케이션디자인트랙</label>

                                            <input type="checkbox" class="btn-check" id="Tbtncheck5" name="T" value="T022"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Tbtncheck5">영상&애니메이션디자인트랙</label>

                                            <input type="checkbox" class="btn-check" id="Tbtncheck6" name="T" value="T023"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Tbtncheck6">제품&서비스디자인트랙</label>

                                            <input type="checkbox" class="btn-check" id="Tbtncheck7" name="T" value="T024"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Tbtncheck7">브랜드&패키지디자인트랙</label>

                                            <input type="checkbox" class="btn-check" id="Tbtncheck8" name="T" value="T025"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Tbtncheck8">인테리어디자인트랙</label>

                                            <input type="checkbox" class="btn-check" id="Tbtncheck9" name="T" value="T026"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Tbtncheck9">VMD&전시디자인트랙</label>

                                            <input type="checkbox" class="btn-check" id="Tbtncheck10" name="T" value="T027"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Tbtncheck10">게임그래픽디자인트랙</label>

                                            <input type="checkbox" class="btn-check" id="Tbtncheck11" name="T" value="T030"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Tbtncheck11">뷰티디자인매니지먼트학과</label>

                                        </div>
                                    </div>

                                </div>


                                <hr class="mt-4">
                                <div class="row">
                                    <div class="col-2" style="border-right: 1px solid gray; text-align: center;">
                                        IT공과대학
                                        <div style="margin-top:50px;">전체선택
                                            <input type='checkbox' name="Vbox" value="전체선택"
                                                   onclick='selectAll(this,"V")'/>
                                        </div>
                                    </div>
                                    <div class="col-10">

                                        <div class="btn-group" role="group"
                                             aria-label="Basic checkbox toggle button group">
                                            <input type="checkbox" class="btn-check" id="Vbtncheck1" name="V" value="V021"
                                                   autocomplete="off" >
                                            <label class="btn btn-outline-primary"
                                                   for="Vbtncheck1">모바일소프트웨어트랙</label>

                                            <input type="checkbox" class="btn-check" id="Vbtncheck2" name="V" value="V022"
                                                   autocomplete="off" >
                                            <label class="btn btn-outline-primary" for="Vbtncheck2">빅데이터트랙</label>

                                            <input type="checkbox" class="btn-check" id="Vbtncheck3" name="V" value="V023"
                                                   autocomplete="off" >
                                            <label class="btn btn-outline-primary"
                                                   for="Vbtncheck3">디지털콘텐츠&가상현실트랙</label>


                                            <input type="checkbox" class="btn-check" id="Vbtncheck4" name="V" value="V024"
                                                   autocomplete="off" >
                                            <label class="btn btn-outline-primary" for="Vbtncheck4">웹공학트랙</label>

                                            <input type="checkbox" class="btn-check" id="Vbtncheck5" name="V" value="V031"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Vbtncheck5">전자트랙</label>

                                            <input type="checkbox" class="btn-check" id="Vbtncheck6" name="V" value="V032"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Vbtncheck6">정보시스템트랙</label>

                                            <input type="checkbox" class="btn-check" id="Vbtncheck7" name="V" value="V033"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Vbtncheck7">기계설계트랙</label>

                                            <input type="checkbox" class="btn-check" id="Vbtncheck8" name="V" value="V034"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Vbtncheck8">기계자동화트랙</label>

                                            <input type="checkbox" class="btn-check" id="Vbtncheck9" name="V" value="V041"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Vbtncheck9">지능시스템트랙</label>

                                            <input type="checkbox" class="btn-check" id="Vbtncheck10" name="V" value="V042"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Vbtncheck10">사물인터넷트랙</label>

                                            <input type="checkbox" class="btn-check" id="Vbtncheck11" name="V" value="V043"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Vbtncheck11">사이버보언트랙</label>

                                            <input type="checkbox" class="btn-check" id="Vbtncheck12" name="V" value="V044"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Vbtncheck12">ICT융합엔터테인먼트트랙</label>

                                            <input type="checkbox" class="btn-check" id="Vbtncheck13" name="V" value="V051"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Vbtncheck13">시스템경영공학트랙</label>

                                            <input type="checkbox" class="btn-check" id="Vbtncheck14" name="V" value="V052"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary"
                                                   for="Vbtncheck14">생산물류시스템트랙</label>

                                            <input type="checkbox" class="btn-check" id="Vbtncheck15" name="V" value="V053"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Vbtncheck15">컨설팅트랙</label>

                                            <input type="checkbox" class="btn-check" id="Vbtncheck16" name="V" value="V054"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="Vbtncheck16">산업공학트랙</label>
                                        </div>
                                    </div>
                                </div>
                                <hr class="mt-4">
                                <div class="row">
                                    <div class="col-2" style="border-right: 1px solid gray; text-align: center;">
                                        창의융합대학
                                        <div style="margin-top:50px;">전체선택
                                            <input type='checkbox' name="Ybox" value="전체선택"
                                                   onclick='selectAll(this,"Y")'/>
                                        </div>
                                    </div>
                                    <div class="col-10">
                                        <div class="btn-group" role="group"
                                             aria-label="Basic checkbox toggle button group">
                                            <input type="checkbox" class="btn-check" id="Ybtncheck1" autocomplete="off" name="Y" value="Y021" >
                                            <label class="btn btn-outline-primary"
                                                   for="Ybtncheck1">문학문화콘텐츠학과</label>

                                            <input type="checkbox" class="btn-check" id="Ybtncheck2" autocomplete="off" name="Y" value="Y031">
                                            <label class="btn btn-outline-primary" for="Ybtncheck2">AI응용학과</label>
                                        </div>
                                    </div>
                                </div>
                                <hr class="mt-4">
                                <div class="row">
                                    <div class="col-2" style="border-right: 1px solid gray; text-align: center;">
                                        모든 트랙 선택
                                    </div>
                                    <div class="col-10">

                                        <div class="btn-group" role="group"
                                             aria-label="Basic checkbox toggle button group">
                                            <input type="checkbox" class="btn-check" id="btncheck1"  onclick="selectAllTrack(this)"
                                                   autocomplete="off">
                                            <label class="btn btn-outline-primary" for="btncheck1">모든 트랙 선택</label>
                                        </div>
                                    </div>
                                    <hr class="mt-4">
                                </div>
                                <div class="d-grid gap-2 col-3 mx-auto">
                                    <a class="btn btn-primary" tabindex="-1" role="button" onclick="submitElection()"
                                       aria-disabled="true">투표 개설하기</a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    </div>
    </div>


</main>


<script>
    function addRow(candidate, image) {
        var Row;
        Row = document.all("addrow").insertRow();

        var candidateName = Row.insertCell();
        candidateName.innerHTML = "<input type='text' id='candidateName"+cadidateCount+"' name='row_name' size='30' value='"+ candidate+"'/>";
        var candidatePicture = Row.insertCell();
        candidatePicture.innerHTML = "<input type='file' class='real-upload' accept='image/!*' id='candidatePic"+cadidateCount+"' name='row_pic' size='10' value='"+ image+"'/>";
        cadidateCount++;
    }

    function deleteRow() {
        var table = document.getElementById('addrow');

        if (table.rows.length < 1) return;
        table.deleteRow(table.rows.length - 1);
        cadidateCount--;

    }

    function selectAll(selectAll, departcode) {
        const checkboxes = document.getElementsByName(departcode);

        checkboxes.forEach((checkbox) => {
            checkbox.checked = selectAll.checked;
        })
    }

    function selectAllTrack(c) {
        selectAll(c, "P");
        selectAll(c, "R");
        selectAll(c, "T");
        selectAll(c, "V");
        selectAll(c, "Y");
    }

    function checkDepartment(departcode) {
        const checkboxes = document.getElementsByName(departcode);

        var count = 0;
        checkboxes.forEach((checkbox) => {
            if (checkbox.checked) {
                count++;
            }
        })

        return count;
    }

    function findCheckValue(departcode) {
        const checkboxes = document.getElementsByName(departcode);

        var findValue = "";
        checkboxes.forEach((checkbox) => {
            if (checkbox.checked) {
                findValue = checkbox.value;
            }
        })

        return findValue;
    }

    function submitElection() {
        var targetDepartment ="";
        var vCount = checkDepartment("V");
        var tCount = checkDepartment("T");
        var rCount = checkDepartment("R");
        var pCount = checkDepartment("P");
        var yCount = checkDepartment("Y");

        if (vCount >=16 && tCount >=11 && rCount >=11 && pCount >=14 && yCount >=2) {
            targetDepartment="전교생";
        }
        else {
            var collegeCount = 0;
            if (vCount >= 16) {
                targetDepartment = "V";
                collegeCount++;
            } else if (vCount > 1 && vCount < 16) {
                alert("선거는 전교생, 단과대학생, 단일트랙학생들을 대상으로만 개설할 수 있습니다 \n\n대상을 다시 확인해 주세요.");
                return;
            } else if (vCount == 1) {
                targetDepartment = findCheckValue("V");
            }

            if (tCount >= 11) {
                targetDepartment = "T";
                collegeCount++;
            } else if (tCount > 1 && tCount < 11) {
                alert("선거는 전교생, 단과대학생, 단일트랙학생들을 대상으로만 개설할 수 있습니다 \n\n대상을 다시 확인해 주세요.");
                return;
            } else if (tCount == 1) {
                targetDepartment = findCheckValue("T");
            }

            if (rCount >= 11) {
                targetDepartment = "R";
                collegeCount++;
            } else if (rCount > 1 && rCount < 11) {
                alert("선거는 전교생, 단과대학생, 단일트랙학생들을 대상으로만 개설할 수 있습니다 \n\n대상을 다시 확인해 주세요.");
                return;
            } else if (rCount == 1) {
                targetDepartment = findCheckValue("R");
            }

            if (pCount >= 14) {
                targetDepartment = "P";
                collegeCount++;
            } else if (pCount > 1 && pCount < 14) {
                alert("선거는 전교생, 단과대학생, 단일트랙학생들을 대상으로만 개설할 수 있습니다 \n\n대상을 다시 확인해 주세요.");
                return;
            } else if (pCount == 1) {
                targetDepartment = findCheckValue("P");
            }

            if (yCount >= 2) {
                targetDepartment = "Y";
                collegeCount++;
            } else if (yCount == 1) {
                targetDepartment = findCheckValue("Y");
            }

            if (collegeCount > 1) {
                alert("선거는 전교생, 단과대학생, 단일트랙학생들을 대상으로만 개설할 수 있습니다 \n\n대상을 다시 확인해 주세요.");
                return;
            }

            if (targetDepartment == "") {
                alert("선거 대상이 지정되지 않았습니다. \n\n대상을 다시 확인해 주세요.");
                return;
            }
        }



        if (cadidateCount == 0) {
            alert("후보가 존재하지 않습니다.");
            return;
        }

        var result = confirm(
            "선거이름 : " + electionName.value +
            "\n최종 후보수 : " + cadidateCount +
            "\n선거 대상 : " + targetDepartment +
            "\n선거 개설을 진행하시겠습니까?"
        );
        if (result==true) {


            var form = document.getElementById("formId");

            var input1 = document.createElement('input');
            input1.type = 'hidden';
            input1.name = 'candidateCount';
            input1.value = cadidateCount;
            var input2 = document.createElement('input');
            input2.type = 'hidden';
            input2.name = 'department';
            input2.value = targetDepartment;




            form.appendChild(input1);
            form.appendChild(input2);
            form.submit();

        }

    }
    var cadidateCount = 0;





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