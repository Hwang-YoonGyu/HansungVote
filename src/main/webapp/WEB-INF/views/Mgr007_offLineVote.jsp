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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.0.0/crypto-js.min.js"></script>
    <script type="text/javascript" src="/resources/js/rsa.js"></script>
    <script type="text/javascript" src="/resources/js/jsbn.js"></script>
    <script type="text/javascript" src="/resources/js/prng4.js"></script>
    <script type="text/javascript" src="/resources/js/rng.js"></script>


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
                        <span style="font-size: 30px;">오프라인 투표 업데이트</span>


                        <hr class="mt-4">


                        <div class="mb-3 rounded" style="background-color: hsl(228, 26%, 96%);
                            padding-top: 10px; padding-bottom: 60px;">

                            <div class="input-group flex-nowrap">
                                <span class="input-group-text">학번</span>
                                <input name="stuId" id="stdId" type="text" class="form-control" placeholder="ex) 1971123"
                                       aria-label="stdId"
                                       aria-describedby="addon-wrapping">
                            </div>

                            <div class="input-group flex-nowrap" style="padding-top: 20px;">
                                <span class="input-group-text">이름</span>
                                <input name="name" id="name" type="text" class="form-control" placeholder="ex) 홍길동"
                                       aria-label="name"
                                       aria-describedby="addon-wrapping">
                            </div>

                        </div>
                        <div class="d-grid gap-2 col-3 mx-auto">
                            <button class="btn btn-primary float-end" onclick="check()">업로드 하기</button>
                        </div>
                    <input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
                    <input type="hidden" id="RSAExponent" value="${RSAExponent}"/>
                </div>

            </div>
        </div>

    </div>


</main>

<script>
    function check() {
        var rsa = new RSAKey();
        rsa.setPublic(document.getElementById('RSAModulus').value,document.getElementById('RSAExponent').value);
        var stuId = document.getElementById("stdId").value;
        var name = document.getElementById("name").value;

        var result = confirm(
            "(정보를 정확히 확인해주세요)\n" +

            "오프라인 투표 완료 처리 하시겠습니까? ");
        if (result == true) {
            var form = document.createElement("form");
            form.setAttribute("charset", "UTF-8");
            form.setAttribute("method", "Post");  //Post 방식
            form.setAttribute("action", "/mgr/addVoted"); //요청 보낼 주소

            var input1 = document.createElement('input');
            input1.type = 'hidden';
            input1.name = 'stuId';
            input1.value = rsa.encrypt(stuId);
            var input2 = document.createElement('input');
            input2.type = 'hidden';
            input2.name = 'name';
            input2.value = rsa.encrypt(name);


            form.appendChild(input1);
            form.appendChild(input2);

            document.body.appendChild(form);
            form.submit();
        }
        else {
            alert("취소되었습니다.");
            return;
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