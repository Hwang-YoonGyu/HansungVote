<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            height: 100%;
            min-height: 1000px;
            margin-top: 100px;
            margin-bottom: 100px;

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
                        <span style="font-size: 20px;">${candiList[0].electionName}</span>
                        <hr class="mt-4">

                        <div class="container mb-3 rounded" style="background-color: hsl(228, 26%, 96%);
                            padding-top: 10px; padding-bottom: 30px;" id ="">
                                <span class="px-3" id="candidate" style="padding-top: 10px; font-size: 30px;">
                                    후보자 목록</span>

                            <c:forEach items="${candiList}" var="CandidateVO" varStatus="status">
                                <div class="my-3" style="padding-top: 10px; text-align: center;"  >
                                    <div class="card background-color white">
                                        <div class="row card-body">
                                            <div class="col-sm my-3" style="text-align: start">
                                                <center>
                                                    <div style =' font-size : 30px ;' >
                                                        <b>${CandidateVO.candidateName}</b>
                                                    </div>
                                                <br><br>
                                                <img src="/getByteImage?candidateName=${CandidateVO.candidateName}"
                                                     style="max-width:80%; height:auto;">
                                                </center>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>


                        <div class="container" style="text-align: center; padding-top: 10px;" id="1">
                            <c:choose>
                                <c:when test="${fn:length(candiList) eq 1}">
                                    <div class="form-check form-check-inline " id="single">
                                        <input class="form-check-input" type="radio" name="inlineRadioOptions"
                                               id="${candiList[0].candidateName}" value="option1">
                                        <p class="agree">찬성</p>
                                    </div>
                                    <div class="form-check form-check-inline" style="padding-left: 50px;">
                                        <input class="form-check-input" type="radio" name="inlineRadioOptions"
                                               id="disagree" value="option2">
                                        <p class="disagree">반대</p>
                                    </div>
                                    <div class="form-check form-check-inline" style="padding-left: 50px;">
                                        <input class="form-check-input" type="radio" name="inlineRadioOptions"
                                               id="reject" value="option3">
                                        <p class="giveup">기권</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${candiList}" var="CandidateVO" varStatus="status">
                                        <div class="form-check form-check-inline " id="multiples">
                                            <input class="form-check-input" type="radio" name="inlineRadioOptions"
                                                   id="${candiList[status.index].candidateName}" value="option${status.index}">
                                            <p class="agree">${candiList[status.index].candidateName}</p>
                                        </div>
                                    </c:forEach>
                                    <div class="form-check form-check-inline ">
                                        <input class="form-check-input" type="radio" name="inlineRadioOptions"
                                               id="reject" value="option${fn:length(candiList)}">
                                        <p class="agree">기권</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>



                        </div>


                        <div class="d-grid gap-2 col-6 mx-auto">
                            <a id ="votecheckButton" href="#" class="btn btn-primary" tabindex="-1" role="button"
                               aria-disabled="true" onclick="votecheck()">투표하기</a>
                        </div>
                    </form>
                    <input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
                    <input type="hidden" id="RSAExponent" value="${RSAExponent}"/>
                </div>
            </div>
        </div>
    </div>
    </div>


</main>
<script>

    var index;
    const electionName='${candiList[0].electionName}';
    var candidateName= '${candiList[index].candidateName}';
    const radioList =document.getElementsByName("inlineRadioOptions");
    var votecheckbutton = document.getElementById("votecheckButton");

    function votecheck() {
        var rsa = new RSAKey();
        rsa.setPublic(document.getElementById('RSAModulus').value,document.getElementById('RSAExponent').value);

        var result = confirm("투표하시겠습니까?");
        if (result == true) {
            radioList.forEach((node) => {
                 if (node.checked) {

                     var form = document.createElement("form");
                     form.setAttribute("charset", "UTF-8");
                     form.setAttribute("method", "Post");  //Post 방식
                     form.setAttribute("action", "/vote/doVote"); //요청 보낼 주소

                     var input1 = document.createElement('input');
                     input1.type = 'hidden';
                     input1.name = 'ElectionName';
                     // input1.value = CryptoJS.AES.encrypt(electionName,
                     //     CryptoJS.enc.Utf8.parse(key),
                     //     {iv:CryptoJS.enc.Utf8.parse(iv),
                     //         padding: CryptoJS.pad.Pkcs7,
                     //         mode: CryptoJS.mode.CBC}
                     // ).toString();
                     input1.value = rsa.encrypt(electionName);

                     var input2 = document.createElement('input');
                     input2.type = 'hidden';
                     input2.name = 'CandidateName';
                     // input2.value = CryptoJS.AES.encrypt(node.id,
                     //     CryptoJS.enc.Utf8.parse(key),
                     //     {iv:CryptoJS.enc.Utf8.parse(iv),
                     //         padding: CryptoJS.pad.Pkcs7,
                     //         mode: CryptoJS.mode.CBC}
                     // ).toString();
                     input2.value = rsa.encrypt(node.id);

                     form.appendChild(input1);
                     form.appendChild(input2);

                     document.body.appendChild(form);
                     form.submit();
                     //votecheckbutton.href ='/vote/doVote?ElectionName=' +electionName + "&CandidateName="+ node.id ;
                 }
             })


        } else {
            alert("취소되었습니다.")

        }
    }

</script>
<div class="fixed-bottom" style="height: 60px">
    <footer style="height: 60px">
        <div style="height: 60px">
            <p style="text-align:center; color: hsl(0, 0%, 34%); padding: 1rem;">@2022 Team Coding Quokka All Rights
                Reserved</p>
        </div>
    </footer>
</div>
</body>