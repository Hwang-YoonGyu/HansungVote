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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
                    <form action="/mgr/modifyElection" enctype="multipart/form-data" method="post" class="row g-3"
                          id="formId">
                        <span style="font-size: 30px;">투표 개설 및 수정</span>


                        <hr class="mt-4">


                        <div class="mb-3 rounded" style="background-color: hsl(228, 26%, 96%);
                            padding-top: 10px; padding-bottom: 20px;">


                            <div class="container">
                                <div class="row">
                                    <div class="col-2">선거이름</div>
                                    <div class="col-10">
                                        <div class="input-group mb-3">
                                            <input id="electionName" name="electionName" value="" type="text"
                                                   class="form-control" placeholder="선거이름을 입력해주세요."
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
                                                <button style="width: 35px; height: 35px; align-content: center;"
                                                        id="addcandidate" class="btn btn-primary btn-sm" type="button"
                                                        onclick="addRow()">+
                                                </button>
                                            </div>
                                            &nbsp
                                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                                <button style="width: 35px; height: 35px;" id="subcandidate"
                                                        class="btn btn-primary btn-sm" type="button"
                                                        onclick="deleteRow()">-
                                                </button>
                                            </div>
                                        </div>
                                        <table class="table table-bordered border-white-50 "
                                               style="text-align: center;  ">
                                            <thead>
                                            <tr>
                                                <th class="rounded-end" width="400" scope="col"
                                                    style="background-color:hsl(0, 0%, 41%); color: white;">후보자
                                                    이름
                                                </th>
                                                <th class="rounded-start" width="400" scope="col"
                                                    style="background-color:hsl(0, 0%, 41%) ; color: white;">후보자
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
                                        <input type="date" id="startDate" name="startDate"><input type="time"
                                                                                                  id="startTime"
                                                                                                  name="startTime">
                                    </div>
                                </div>

                                <hr class="mt-4">
                                <div class="row">
                                    <div class="col-2">투표 종료 시간</div>
                                    <div class="col-10">
                                        <input type="date" id="endDate" name="endDate"><input type="time" id="endTime"
                                                                                              name="endTime">
                                    </div>
                                </div>
                                <div class="collegeSelect">
                                    <hr class="mt-4">
                                    <div class="col-2">선거 대상</div>
                                    <br>
                                    <div class="col-10">
                                        <select class="form-select" id="college">
                                            <option value="0">대상을 선택하세요</option>
                                            <option value="1">전체</option>
                                            <option value="2">크리에이티브인문예술대학</option>
                                            <option value="3">미래융합사회과학대학</option>
                                            <option value="4">디자인대학</option>
                                            <option value="5">IT공과대학</option>
                                            <option value="6">창의융합대학</option>
                                            <option value="7">미래플러스대학</option>
                                            <option value="8">대의원</option>
<%--                                            <option value="9">동아리</option>--%>
                                        </select>
                                    </div>
                                </div>
                                <div class="selectP" style="display: none">
                                    <hr class="mt-4">
                                    <div class="col-2">세부 대상</div>
                                    <br>
                                    <div class="col-10">
                                        <select class="form-select" id="targetP">
                                            <option value="0">세부 대상을 선택하세요</option>
                                            <option value="1" id="P" style="color: midnightblue;">크리에이티브인문예술대학 전체
                                            </option>
                                            <option value="2" id="P01" style="color: royalblue;">크리에이티브인문학부</option>
                                            <option value="3" id="P011">영미문학문화트랙</option>
                                            <option value="4" id="P012">영미언어정보트랙</option>
                                            <option value="5" id="P013">한국어교육트랙</option>
                                            <option value="6" id="P014">문학문화콘텐츠트랙</option>
                                            <option value="7" id="P015">글로컬역사트랙</option>
                                            <option value="8" id="P016">역사문화콘텐츠트랙</option>
                                            <option value="9" id="P017">도서관정보문화트랙</option>
                                            <option value="10" id="P018">디지털인문정보학트랙</option>
                                            <option value="11" id="P019">역사문화큐레이션트랙</option>
                                            <option value="12" id="P02" style="color: royalblue;">예술학부</option>
                                            <option value="13" id="P021">동양화전공</option>
                                            <option value="14" id="P022">서양화전공</option>
                                            <option value="15" id="P023">한국무용전공</option>
                                            <option value="16" id="P024">현대무용전공</option>
                                            <option value="17" id="P025">발레전공</option>
                                            <option value="18" id="P026">이민&다문화트랙</option>

                                        </select>
                                    </div>
                                </div>
                                <div class="selectR" style="display: none">
                                    <hr class="mt-4">
                                    <div class="col-2">세부 대상</div>
                                    <br>
                                    <div class="col-10">
                                        <select class="form-select" id="targetR">
                                            <option value="0">세부 대상을 선택하세요</option>
                                            <option value="1" id="R" style="color: midnightblue;">미래융합사회과학대학 전체</option>
                                            <option value="2" id="R01" style="color: royalblue;">사회과학부</option>
                                            <option value="3" id="R011">국제무역트랙</option>
                                            <option value="4" id="R012">글로벌비즈니스트랙</option>
                                            <option value="5" id="R013">기업&경제분석트랙</option>
                                            <option value="6" id="R014">금융&데이터분석트랙</option>
                                            <option value="7" id="R015">공공행정트랙</option>
                                            <option value="8" id="R016">법&정책트랙</option>
                                            <option value="9" id="R017">부동산트랙</option>
                                            <option value="10" id="R018">스마트도시&교통계획트랙</option>
                                            <option value="11" id="R019">기업경영트랙</option>
                                            <option value="12" id="R01A">벤처경영트랙</option>
                                            <option value="13" id="R01B">회계&재무경영트랙</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="selectT" style="display: none">
                                    <hr class="mt-4">
                                    <div class="col-2">세부 대상</div>
                                    <br>
                                    <div class="col-10">
                                        <select class="form-select" id="targetT">
                                            <option value="0">세부 대상을 선택하세요</option>
                                            <option value="1" id="T" style="color: midnightblue;">디자인대학 전체</option>
                                            <option value="2" id="T01" style="color: royalblue;">글로벌패션산업학부</option>
                                            <option value="3" id="T011">패션마케팅트랙</option>
                                            <option value="4" id="T012">패션디자인트랙</option>
                                            <option value="5" id="T013">기업&패션크리에이티브디렉션트랙</option>
                                            <option value="6" id="T02" style="color: royalblue;">ICT디자인학부</option>
                                            <option value="7" id="T021">뉴미디어광고&커뮤니케이션디자인트랙</option>
                                            <option value="8" id="T022">영상&애니메이션디자인트랙</option>
                                            <option value="9" id="T023">제품&서비스디자인트랙</option>
                                            <option value="10" id="T024">브랜드&패키지디자인트랙</option>
                                            <option value="11" id="T025">인테리어디자인트랙</option>
                                            <option value="12" id="T026">VMD&전시디자인트랙</option>
                                            <option value="13" id="T027">게임그래픽디자인트랙</option>
                                            <option value="14" id="T028">UI/UX디자인트랙</option>
                                            <option value="15" id="T030" style="color: royalblue;">뷰티디자인매니지먼트학과</option>
                                            <option value="16" id="T040" style="color: royalblue;">뷰티매니지먼트계약학과</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="selectV" style="display: none">
                                    <hr class="mt-4">
                                    <div class="col-2">세부 대상</div>
                                    <br>
                                    <div class="col-10">
                                        <select class="form-select" id="targetV">
                                            <option value="0">세부 대상을 선택하세요</option>
                                            <option value="1" id="V" style="color: midnightblue;">IT공과대학 전체</option>
                                            <option value="2" id="V02" style="color: royalblue;">컴퓨터공학부</option>
                                            <option value="3" id="V021">모바일소프트웨어트랙</option>
                                            <option value="4" id="V022">빅데이터트랙</option>
                                            <option value="5" id="V023">디지털콘텐츠&가상현실트랙</option>
                                            <option value="6" id="V024">웹공학트랙</option>
                                            <option value="7" id="V03" style="color: royalblue;">기계전자공학부</option>
                                            <option value="8" id="V031">전자트랙</option>
                                            <option value="9" id="V032">정보시스템트랙</option>
                                            <option value="10" id="V033">기계설계트랙</option>
                                            <option value="11" id="V034">기계자동화트랙</option>
                                            <option value="12" id="V035">시스템반도체트랙</option>
                                            <option value="13" id="V04" style="color: royalblue;">IT융합공학부</option>
                                            <option value="14" id="V041">지능시스템트랙</option>
                                            <option value="15" id="V042">사물인터넷트랙</option>
                                            <option value="16" id="V043">사이버보언트랙</option>
                                            <option value="17" id="V044">ICT융합엔터테인먼트트랙</option>
                                            <option value="18" id="V05" style="color: royalblue;">스마트경영공학부</option>
                                            <option value="19" id="V051">시스템경영공학트랙</option>
                                            <option value="20" id="V052">생산물류시스템트랙</option>
                                            <option value="21" id="V053">컨설팅트랙</option>
                                            <option value="22" id="V054">산업공학트랙</option>
                                            <option value="23" id="V055">지능형제조시스템트랙</option>
                                            <option value="24" id="V060" style="color: royalblue;">스마트팩토리컨설팅학과</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="selectY" style="display: none">
                                    <hr class="mt-4">
                                    <div class="col-2">세부 대상</div>
                                    <br>
                                    <div class="col-10">
                                        <select class="form-select" id="targetY">
                                            <option value="0">세부 대상을 선택하세요</option>
                                            <option value="1" id="Y" style="color: midnightblue;">창의융합대학 전체</option>
                                            <option value="2" id="Y010" style="color: royalblue;">상상력인재학부</option>
                                            <option value="3" id="Y021" style="color: royalblue;">문학문화콘텐츠학과</option>
                                            <option value="4" id="Y031" style="color: royalblue;">AI응용학과</option>
                                            <option value="5" id="Y041" style="color: royalblue;">융합보안학과</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="selectZ" style="display: none">
                                    <hr class="mt-4">
                                    <div class="col-2">세부 대상</div>
                                    <br>
                                    <div class="col-10">
                                        <select class="form-select" id="targetZ">
                                            <option value="0">세부 대상을 선택하세요</option>
                                            <option value="1" id="Z" style="color: midnightblue;">미래플러스대학 전체</option>
                                            <option value="2" id="Z010" style="color: royalblue;">융합행정학과</option>
                                            <option value="3" id="Z020" style="color: royalblue;">호텔외식경영학과</option>
                                            <option value="4" id="Z030" style="color: royalblue;">뷰티디자인학과</option>
                                            <option value="5" id="Z040" style="color: royalblue;">비즈니스컨설팅학과</option>
                                            <option value="6" id="Z050" style="color: royalblue;">ICT융합디자인학과</option>

                                        </select>
                                    </div>
                                    <hr class="mt-4">
                                </div>
                                <br><br>
                                <div class="d-grid gap-2 col-3 mx-auto">
                                    <a class="btn btn-primary" tabindex="-1" role="button" onclick="submitElection()"
                                       aria-disabled="true">투표 개설하기</a>
                                </div>
                                <br><br>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>


<script type="text/javascript">
    var cadidateCount = 0;
    var targetDepartment = null;
    var DisplayDepartment = "";

    function addRow(candidate, image) {
        var Row;
        Row = document.all("addrow").insertRow();

        var candidateName = Row.insertCell();
        candidateName.innerHTML = "<input type='text' placeholder='ex) 기호 n번 상상부기' name='candidateName" + cadidateCount + "' size='30' value=\'\'/>";
        var candidatePicture = Row.insertCell();
        candidatePicture.innerHTML = "<input type='file' class='real-upload' accept='image/!*' name='candidatePic" + cadidateCount + "'  size='10' value='" + image + "'/>";
        cadidateCount++;
    }

    function deleteRow() {
        var table = document.getElementById('addrow');

        if (table.rows.length < 1) return;
        table.deleteRow(table.rows.length - 1);
        cadidateCount--;

    }

    $('#college').change(function () {
        $('.selectP').hide();
        $('.selectR').hide();
        $('.selectT').hide();
        $('.selectV').hide();
        $('.selectY').hide();
        $('.selectZ').hide();
        targetDepartment = null;
        DisplayDepartment = "";

        switch ($('#college').val()) {
            case '0':
                break;
            case '1':
                targetDepartment = "";
                DisplayDepartment = "학부생 전체";
                break;
            case '2':
                $('.selectP').show();
                break;
            case '3':
                $('.selectR').show();
                break;
            case '4':
                $('.selectT').show();
                break;
            case '5':
                $('.selectV').show();
                break;
            case '6':
                $('.selectY').show();
                break;
            case '7':
                $('.selectZ').show();
                break;
            case '8':
                targetDepartment = "delegate";
                DisplayDepartment = "대의원";
                break;
            case '9':
                targetDepartment = "club";
                DisplayDepartment = "동아리 가입자";
                break;

        }
    });
    $('#targetP').change(function () {
        switch ($('#targetP').val()) {
            case '0':
                targetDepartment = null;
                DisplayDepartment = "";
                break;
            case '1':
                targetDepartment = "P";
                DisplayDepartment = "크리에이티브인문예술대학 전체";
                break;
            case '2':
                targetDepartment = "P01";
                DisplayDepartment = "크리에이티브인문학부";
                break;
            case '3':
                targetDepartment = "P011";
                DisplayDepartment = "영미문학문화트랙";
                break;
            case '4':
                targetDepartment = "P012";
                DisplayDepartment = "영미언어정보트랙";
                break;
            case '5':
                targetDepartment = "P013";
                DisplayDepartment = "한국어교육트랙";
                break;
            case '6':
                targetDepartment = "P014";
                DisplayDepartment = "문학문화콘텐츠트랙";
                break;
            case '7':
                targetDepartment = "P015";
                DisplayDepartment = "글로컬역사트랙";
                break;
            case '8':
                targetDepartment = "P016";
                DisplayDepartment = "역사문화콘텐츠트랙";
                break;
            case '9':
                targetDepartment = "P017";
                DisplayDepartment = "도서관정보문화트랙";
                break;
            case '10':
                targetDepartment = "P018";
                DisplayDepartment = "디지털인문정보학트랙";
                break;
            case '11':
                targetDepartment = "P019";
                DisplayDepartment = "역사문화큐레이션트랙";
                break;
            case '12':
                targetDepartment = "P02";
                DisplayDepartment = "예술학부";
                break;
            case '13':
                targetDepartment = "P021";
                DisplayDepartment = "동양화전공";
                break;
            case '14':
                targetDepartment = "P022";
                DisplayDepartment = "서양화전공";
                break;
            case '15':
                targetDepartment = "P023";
                DisplayDepartment = "한국무용전공";
                break;
            case '16':
                targetDepartment = "P024";
                DisplayDepartment = "현대무용전공";
                break;
            case '17':
                targetDepartment = "P025";
                DisplayDepartment = "발레전공";
                break;
            case '18':
                targetDepartment = "P026";
                DisplayDepartment = "이민&다문화트랙";
                break;

        }
    });
    $('#targetR').change(function () {

        switch ($('#targetR').val()) {
            case '0':
                targetDepartment = null;
                DisplayDepartment = "";
                break;
            case '1':
                targetDepartment = "R";
                DisplayDepartment = "미래융합사회과학대학 전체";
                break;
            case '2':
                targetDepartment = "R01";
                DisplayDepartment = "사회과학부";
                break;
            case '3':
                targetDepartment = "R011";
                DisplayDepartment = "국제무역트랙";
                break;
            case '4':
                targetDepartment = "R012";
                DisplayDepartment = "글로벌비즈니스트랙";
                break;
            case '5':
                targetDepartment = "R013";
                DisplayDepartment = "기업&경제분석트랙";
                break;
            case '6':
                targetDepartment = "R014";
                DisplayDepartment = "금융&데이터분석트랙";
                break;
            case '7':
                targetDepartment = "R015";
                DisplayDepartment = "공공행정트랙";
                break;
            case '8':
                targetDepartment = "R016";
                DisplayDepartment = "법&정책트랙";
                break;
            case '9':
                targetDepartment = "R017";
                DisplayDepartment = "부동산트랙";
                break;
            case '10':
                targetDepartment = "R018";
                DisplayDepartment = "스마트도시&교통계획트랙";
                break;
            case '11':
                targetDepartment = "R019";
                DisplayDepartment = "기업경영트랙";
                break;
            case '12':
                targetDepartment = "R01A";
                DisplayDepartment = "벤처경영트랙";
                break;
            case '13':
                targetDepartment = "R01B";
                DisplayDepartment = "회계&재무경영트랙";
                break;
        }
    });
    $('#targetT').change(function () {

        switch ($('#targetT').val()) {
            case '0':
                targetDepartment = null;
                DisplayDepartment = "";
                break;
            case '1':
                targetDepartment = "T";
                DisplayDepartment = "디자인대학 전체";
                break;
            case '2':
                targetDepartment = "T01";
                DisplayDepartment = "글로벌패션산업학부";
                break;
            case '3':
                targetDepartment = "T011";
                DisplayDepartment = "패션마케팅트랙";
                break;
            case '4':
                targetDepartment = "T012";
                DisplayDepartment = "패션디자인트랙";
                break;
            case '5':
                targetDepartment = "T013";
                DisplayDepartment = "기업&패션크리에이티브디렉션트랙";
                break;
            case '6':
                targetDepartment = "T02";
                DisplayDepartment = "ICT디자인학부";
                break;
            case '7':
                targetDepartment = "T021";
                DisplayDepartment = "뉴미디어광고&커뮤니케이션디자인트랙";
                break;
            case '8':
                targetDepartment = "T022";
                DisplayDepartment = "영상&애니메이션디자인트랙";
                break;
            case '9':
                targetDepartment = "T023";
                DisplayDepartment = "제품&서비스디자인트랙";
                break;
            case '10':
                targetDepartment = "T024";
                DisplayDepartment = "브랜드&패키지디자인트랙";
                break;
            case '11':
                targetDepartment = "T025";
                DisplayDepartment = "인테리어디자인트랙";
                break;
            case '12':
                targetDepartment = "T026";
                DisplayDepartment = "VMD&전시디자인트랙";
                break;
            case '13':
                targetDepartment = "T027";
                DisplayDepartment = "게임그래픽디자인트랙";
                break;
            case '14':
                targetDepartment = "T028";
                DisplayDepartment = "UI/UX디자인트랙";
                break;
            case '15':
                targetDepartment = "T030";
                DisplayDepartment = "뷰티디자인매니지먼트학과";
                break;
            case '16':
                targetDepartment = "T040";
                DisplayDepartment = "뷰티매니지먼트계약학과";
                break;
        }
    });
    $('#targetV').change(function () {

        switch ($('#targetV').val()) {
            case '0':
                targetDepartment = null;
                DisplayDepartment = "";
                break;
            case '1':
                targetDepartment = "V";
                DisplayDepartment = "IT공과대학 전체";
                break;
            case '2':
                targetDepartment = "V02";
                DisplayDepartment = "컴퓨터공학부";
                break;
            case '3':
                targetDepartment = "V021";
                DisplayDepartment = "모바일소프트웨어트랙";
                break;
            case '4':
                targetDepartment = "V022";
                DisplayDepartment = "빅데이터트랙";
                break;
            case '5':
                targetDepartment = "V023";
                DisplayDepartment = "디지털콘텐츠&가상현실트랙";
                break;
            case '6':
                targetDepartment = "V024";
                DisplayDepartment = "웹공학트랙";
                break;
            case '7':
                targetDepartment = "V03";
                DisplayDepartment = "기계전자공학부";
                break;
            case '8':
                targetDepartment = "V031";
                DisplayDepartment = "전자트랙";
                break;
            case '9':
                targetDepartment = "V032";
                DisplayDepartment = "정보시스템트랙";
                break;
            case '10':
                targetDepartment = "V033";
                DisplayDepartment = "기계설계트랙";
                break;
            case '11':
                targetDepartment = "V034";
                DisplayDepartment = "기계자동화트랙";
                break;
            case '12':
                targetDepartment = "V035";
                DisplayDepartment = "시스템반도체트랙";
                break;
            case '13':
                targetDepartment = "V04";
                DisplayDepartment = "IT융합공학부";
                break;
            case '14':
                targetDepartment = "V041";
                DisplayDepartment = "지능시스템트랙";
                break;
            case '15':
                targetDepartment = "V042";
                DisplayDepartment = "사물인터넷트랙";
                break;
            case '16':
                targetDepartment = "V043";
                DisplayDepartment = "사이버보언트랙";
                break;
            case '17':
                targetDepartment = "V04";
                DisplayDepartment = "ICT융합엔터테인먼트트랙";
                break;
            case '18':
                targetDepartment = "V05";
                DisplayDepartment = "스마트경영공학부";
                break;
            case '19':
                targetDepartment = "V051";
                DisplayDepartment = "시스템경영공학트랙";
                break;
            case '20':
                targetDepartment = "V052";
                DisplayDepartment = "생산물류시스템트랙";
                break;
            case '21':
                targetDepartment = "V053";
                DisplayDepartment = "컨설팅트랙";
                break;
            case '22':
                targetDepartment = "V054";
                DisplayDepartment = "산업공학트랙";
                break;
            case '23':
                targetDepartment = "V055";
                DisplayDepartment = "지능형제조시스템트랙";
                break;
            case '24':
                targetDepartment = "V060";
                DisplayDepartment = "스마트팩토리컨설팅학과";
                break;
        }
    });
    $('#targetY').change(function () {

        switch ($('#targetY').val()) {
            case '0':
                targetDepartment = null;
                DisplayDepartment = "";
                break;
            case '1':
                targetDepartment = "Y";
                DisplayDepartment = "창의융합대학 전체";
                break;
            case '2':
                targetDepartment = "Y01";
                DisplayDepartment = "상상력인재학부";
                break;
            case '3':
                targetDepartment = "Y021";
                DisplayDepartment = "문학문화콘텐츠학과";
                break;
            case '4':
                targetDepartment = "Y031";
                DisplayDepartment = "AI응용학과";
                break;
            case '5':
                targetDepartment = "Y041";
                DisplayDepartment = "융합보안학과";
                break;

        }
    });
    $('#targetZ').change(function () {

        switch ($('#targetZ').val()) {
            case '0':
                targetDepartment = null;
                DisplayDepartment = "";
                break;
            case '1':
                targetDepartment = "Z";
                DisplayDepartment = "미래플러스대학 전체";
                break;
            case '2':
                targetDepartment = "Z010";
                DisplayDepartment = "융합행정학과";
                break;
            case '3':
                targetDepartment = "Z020";
                DisplayDepartment = "호텔외식경영학과";
                break;
            case '4':
                targetDepartment = "Z030";
                DisplayDepartment = "뷰티디자인학과";
                break;
            case '5':
                targetDepartment = "Z040";
                DisplayDepartment = "비즈니스컨설팅학과";
                break;
            case '5':
                targetDepartment = "Z050";
                DisplayDepartment = "ICT융합디자인학과";
                break;

        }
    });

    function submitElection() {
        var std = document.getElementById("startDate");
        var etd = document.getElementById("endDate");
        var stt = document.getElementById("startTime");
        var ett = document.getElementById("endTime");

        if (std.value == "" || stt.value == "" || etd.value == "" || ett.value == "") { //날짜 체크, 하나라도 비워져있으면 에러
            alert("날짜가 올바르게 지정되지 않았습니다");
            return;
        }

        if (cadidateCount == 0) { //후보 숫자 체크, 0이면 에러
            alert("후보가 존재하지 않습니다.");
            return;
        }

        if (targetDepartment == null) { //대상 체크, 제대로 선택 안하면 에러
            alert("선거 대상이 선택되지 않았습니다.");
            return;
        }


        var result = confirm(
            "선거이름 : " + electionName.value +
            "\n최종 후보수 : " + cadidateCount +
            "\n선거 대상 : " + DisplayDepartment +
            "\n선거 개설을 진행하시겠습니까?"
        );
        if (result == true) {
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