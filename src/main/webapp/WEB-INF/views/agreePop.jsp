<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <title>팝업 개'시발련</title>
    <style>

    </style>

</head>
<body>
<div style="text-align:center">
    <strong>
2022년도 학생자치기구 총선거
    </strong>
    <hr>
</div>
안녕하십니까. 중앙선거관리위원회입니다.
이번 22년도 학생자치기구 총선거는 온라인과 오프라인을 병행하여 진행됩니다.

온라인: HanSung Vote  /  오프라인: 미래관 앞 선거 부스
일시: 2022년 11월 23일 ~ 24일 25일(예비일)
시간: 오전 9시 ~ 오후 9시

온라인 투표(HanSung Vote)는 아래 개인정보 처리방침에 동의하시면 가능합니다.

중앙선거관리위원회 개인정보 처리방침
중앙선거관리위원회는 「개인정보 보호법」 제30조에 따라 정보주체의 개인정보 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을 정하여 운영하고 있습니다. 이 개인정보 처리방침은 ｢개인정보보호법｣, ｢선거관리위원회 개인정보 보호에 관한 규칙｣ 등 개인정보 보호규정에 의하여 운영되고 있으며, ｢개인정보보호법｣ 제32조에 따라 등록대상이 되는 개인정보파일에 대하여 적용되므로 선거관리위원회 선거관리, 선거운동본부 사무관리 및 그 밖에 이에 준하는 선거관리위원회의 업무와 관련된 사항을 기록한 개인정보파일 등은 본 방침의 적용에서 제외됩니다.
이 방침은 중앙선거관리위원회에서 운영하는 온라인투표시스템에 적용되며, 본 처리방침은 수시로 내용이 변경될 수 있으니 정기적으로 방문하여 확인하시기 바랍니다

개인정보법 등 관련 법규에 의거하여 상기 본인은
위와 같이 개인정보와 고유식별정보 수집 및 이용에 동의합니다.'
<div class = "checkT">
    <p>
        <input type="checkbox" id="check" name ="checkbox_check" class="checks"/> 위의 약관에 동의 합니다.<br />
    </p>
</div>

<div class = "btn">
    <p>
        <button type ="button" class="vote_button" disabled = "disabled" onclick="location.href ='main'">한성보트 투표하러가기</button>
    </p>
</div>

<script>
    $(function (){
        console.log("왔니?")
        $("#check").click(function (){
            let Check = $("#check").prop("checked");

            if(Check){
                $(".checks").prop("checked",true);
                console.log("왔니?")
            }
            else {
                $(".checks").prop("checked",false);
                console.log("왔니?")
            }
        });

        $('.checkT input[type="checkbox"]').click(function (){
            let tmp =$(this).prop('checked');
            let tt =$("[name='checkbox_check']:checked").length;

            if(tmp==true || tt>0){
                $(".btn button").css({"backgroundColor":"#0000FF","color":"#fff"}).prop("disabled",false);
            }
            else{
                $(".btn button").css({"backgroundColor":"#cbcbcb","color":"#303033"}).prop("disabled",true);

            }
        })
    });
</script>

</body>
</html>
