<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <link rel="shortcut icon" type="image/x-icon" href="/resources/img/codingquokka.png">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://www.markuptag.com/bootstrap/5/css/bootstrap.min.css">
    <title>한성대학교 온라인 투표 시스템</title>
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
                    <span style="font-size: 20px;">개인정보 제공 동의서</span>
                </div>
                <div class="login-form bg-white mt-4 p-4 rounded">
                    안녕하십니까. 한성대학교 중앙선거관리위원회입니다.<br>
                    이번 22년도 학생자치기구 총선거는 온라인과 오프라인을 병행하여 진행됩니다.<br>
                    <br>
                    온라인: HansungVote / 오프라인: 미래관 앞 선거 부스<br>
                    온라인 선거 제공 : 코딩하는 쿼카<br>

                    일시: 2022년 11월 23일 ~ 24일 25일(예비일)<br>
                    시간: 오전 9시 ~ 오후 9시<br>
                    <br>
                    온라인 투표(HansungVote)는 아래 개인정보 처리방침에 동의하시면 가능합니다.<br>
                    <br>
                    중앙선거관리위원회 개인정보 처리방침<br>
                    중앙선거관리위원회는 「개인정보 보호법」 제30조에 따라 정보주체의 개인정보 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을
                    정하여 운영하고 있습니다.<br>
                    이 개인정보 처리방침은 ｢개인정보보호법｣, ｢선거관리위원회 개인정보 보호에 관한 규칙｣ 등 개인정보 보호규정에 의하여 운영되고 있으며, ｢개인정보보호법｣ 제32조에 따라 등록대상이
                    되는 개인정보파일에 대하여 <br>
                    적용되므로 선거관리위원회 선거관리, 선거운동본부 사무관리 및 그 밖에 이에 준하는 선거관리위원회의 업무와 관련된 사항을 기록한 개인정보파일 등은 본 방침의 적용에서 제외됩니다.<br>
                    <br>
                    이 방침은 중앙선거관리위원회에서 운영하는 온라인투표시스템에 적용되며, 본 처리방침은 수시로 내용이 변경될 수 있으니 정기적으로 방문하여 확인하시기 바랍니다.<br>
                    <br>
                    개인정보법 등 관련 법규에 의거하여 상기 본인은<br>
                    위와 같이 개인정보와 고유식별정보 수집 및 이용에 동의합니다.<br>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="login-form bg-white mt-4 p-4 rounded">
                    <div class="checkT">
                        <p>
                            <input type="checkbox" id="check" name="checkbox_check" class="checks"/> 위의 약관에 동의 합니다.<br/>
                        </p>
                    </div>

                    <div class="btn">
                        <form action="/agreePop" method="post">
                            <input type="submit" id="btn" value="온라인 투표 하러가기" class="btn btn-primary float-end" disabled="disabled"/>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<script>
    $('.checkT input[type="checkbox"]').click(function () {
        let tmp = $(this).prop('checked');
        let tt = $("[name='checkbox_check']:checked").length;

        if (tmp == true || tt > 0) {
            $("#btn").prop("disabled", false);
        } else {
            $("#btn").prop("disabled", true);

        }
    })
</script>

</body>
</html>
