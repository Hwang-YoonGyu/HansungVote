<%
    response.setHeader("Pragma", "no-cache" );
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-store");
    response.setHeader("Cache-Control", "no-cache" );
%>
<%@ page  contentType = "text/html;charset=ksc5601" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.util.regex.*" %>
<%@ page import = "java.text.*" %>
<%@ page import="com.icert.comm.secu.IcertSecuManager" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    //날짜 생성
    Calendar today = Calendar.getInstance();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
    String day = sdf.format(today.getTime());

    java.util.Random ran = new Random();
    //랜덤 문자 길이
    int numLength = 6;
    String randomStr = "";

    for (int i = 0; i < numLength; i++) {
        //0 ~ 9 랜덤 숫자 생성
        randomStr += ran.nextInt(10);
    }

    //reqNum은 최대 40byte 까지 사용 가능
    String reqNum = day + randomStr;
%>
<%
    String tr_cert		= "";
    String cpId			= "SUGT1001";			// 회원사ID
    String urlCode		= "003001";		// URL 코드
    String certNum		= reqNum;		// 요청번호
    String date			= day;			// 요청일시
    String certMet		= "M";		// 본인확인방법
    String plusInfo		= "";	// 추가DATA정보
    String extendVar	= "0000000000000000";					// 확장변수

    String tr_url       = "http://52.79.201.73/sample3";      // 본인인증 결과수신 POPUP URL
    String tr_add	   = "N";	     //KMC 본인확인서비스 팝업 Iframe 호출 연동 작업 2016.09.06 kmcweb4
%>
<%
    //01. 한국모바일인증(주) 암호화 모듈 선언
    IcertSecuManager seed = new IcertSecuManager();

    //02. 1차 암호화 (tr_cert 데이터변수 조합 후 암호화)
    String enc_tr_cert = "";
    tr_cert = cpId +"/"+ urlCode +"/"+ certNum +"/"+ date +"/"+ certMet +"///////"+ plusInfo +"/"+ extendVar;

    enc_tr_cert = seed.getEnc(tr_cert, "");

    //03. 1차 암호화 데이터에 대한 위변조 검증값 생성 (HMAC)
    String hmacMsg = "";

    hmacMsg = seed.getMsg(enc_tr_cert);

    //04. 2차 암호화 (1차 암호화 데이터, HMAC 데이터, extendVar 조합 후 암호화)
    tr_cert  = seed.getEnc(enc_tr_cert +"/"+ hmacMsg +"/"+ extendVar, "");
%>



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
                        <form method="post" name="reqKMCISForm">
                            <input type="hidden" name="tr_cert"   value = "<%=tr_cert%>">
                            <input type="hidden" name="tr_url"    value = "<%=tr_url%>">
                            <input type="hidden" name="tr_add"    value = "<%=tr_add%>">
                            <input type="submit" id="btn" value="본인인증 후 온라인 투표 하러가기" class="btn btn-primary float-end" disabled="disabled" onclick="javascript:openKMCISWindow();"/>
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
<script>
    window.name = "kmcis_web_sample";

    var KMCIS_window;

    function openKMCISWindow(){
        var UserAgent = navigator.userAgent;

        // 모바일인 경우 (변동사항 있을경우 추가 필요)
        if (UserAgent.match(/iPhone|iPad|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null)
        {
            KMCIS_window = window.open('', 'KMCISWindow');
        }
        // 모바일이 아닌 경우
        else
        {
            // 기본 팝업 size
            var jwidth	= "425";
            var jHeight	= "600";

            var UserAgent = navigator.userAgent.toLowerCase();

            if(UserAgent.indexOf("chrome") != -1){
                var jwidth	= "560";
                var jHeight	= "770";
            }else if(UserAgent.indexOf("safari") != -1){
                jwidth	= "441";
                jHeight	= "588";
            }

            KMCIS_window = window.open('', 'KMCISWindow', 'width='+jwidth+', height='+jHeight+', resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=435, top=250' );
        }

        if(KMCIS_window == null){
            alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
        }

        document.reqKMCISForm.action = 'https://www.kmcert.com/kmcis/web/kmcisReq.jsp';
        document.reqKMCISForm.target = 'KMCISWindow';
        document.reqKMCISForm.submit();
    }
</script>
</body>
</html>

