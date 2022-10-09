<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <link rel="shortcut icon" type="image/x-icon" href="/resources/img/codingquokka.png">
    <title>한성대학교 온라인 투표 시스템</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://www.markuptag.com/bootstrap/5/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.0.0/crypto-js.min.js"></script>
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
        }

        div {
            display: block;
            margin: auto;
            position: relative;
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

<header class="fixed-top">
    <img src="/resources/img/Logo.png" style="height: 100px;">
</header>

<main>
    <div class="container-fulid" style="margin-top: 100px;">
        <div class="row">
            <div class="col-md-4 offset-md-4">
                <div class="login-form bg-light mt-4 p-4">
                    <h4>한성대학교 온라인 투표 시스템</h4>
                    <div class="col-12">
                        <label>Student ID</label>
                        <input id="userId" name="stu_id" value="" type="text" class="form-control" placeholder="학번">
                    </div>
                    <div class="col-12">
                        <label>Password</label>
                        <input id="password" name="password" value="" type="password" class="form-control"
                               placeholder="비밀번호">
                    </div>

                    <div class="col-12">
                        <form id="formId" action="/login" method="post" class="row g-3">
                            <input type="button" onclick=sendPostRequest() class="btn btn-primary float-end"
                                   value="log in"/>
                        </form>
                    </div>
                    <hr class="mt-4">

                </div>
            </div>
        </div>
    </div>
</main>
<script>
    window.onpageshow = function(event){
        if(event.persisted || (window.performance && window.performance.navigation.type == 2)){
            location.href = "/";
        }
    }

    function sendPostRequest() {
        let iv = "gkstjdwkdwkd0000";
        let key = "ghkddbsrbqkrtjdwodlcksghdlatnqls";

        var form = document.getElementById('formId');
        var input1 = document.createElement('input');
        input1.type = 'hidden';
        input1.name = 'stu_id';
        input1.value = CryptoJS.AES.encrypt(document.getElementById('userId').value,
            CryptoJS.enc.Utf8.parse(key),
            {
                iv: CryptoJS.enc.Utf8.parse(iv),
                padding: CryptoJS.pad.Pkcs7,
                mode: CryptoJS.mode.CBC
            }
        ).toString();
        var input2 = document.createElement('input');
        input2.type = 'hidden';
        input2.name = 'password';
        input2.value = CryptoJS.SHA256(document.getElementById('password').value).toString();

        form.appendChild(input1);
        form.appendChild(input2);
        form.submit();
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

</html>