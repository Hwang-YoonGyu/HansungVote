데이터 암호화 및 KMC 본인확인서비스 호출 샘플 페이지
<%
    response.setHeader("Pragma", "no-cache" );
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-store");
    response.setHeader("Cache-Control", "no-cache" );
%>
<%@ page  contentType = "text/html;charset=ksc5601"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.util.regex.*" %>
<%@ page import = "java.text.*" %>
<%@ page import="com.icert.comm.secu.IcertSecuManager" %>
<%
    String tr_cert		= "";
    String cpId			= request.getParameter("cpId");			// 회원사ID
    String urlCode		= request.getParameter("urlCode");		// URL 코드
    String certNum		= request.getParameter("certNum");		// 요청번호
    String date			= request.getParameter("date");			// 요청일시
    String certMet		= request.getParameter("certMet");		// 본인확인방법
    String plusInfo		= request.getParameter("plusInfo");		// 추가DATA정보
    String extendVar	= "0000000000000000";					// 확장변수

    String tr_url       = request.getParameter("tr_url");      // 본인인증 결과수신 POPUP URL
    String tr_add	   = request.getParameter("tr_add");	     //KMC 본인확인서비스 팝업 Iframe 호출 연동 작업 2016.09.06 kmcweb4
%>

<%!
    // 파라미터 유효성 검증 --------------------------------------------
    boolean b = true;
    String regex = "";
    String regex1 = "";

    public Boolean paramChk(String patn, String param){
        Pattern pattern = Pattern.compile(patn);
        Matcher matcher = pattern.matcher(param);
        b = matcher.matches();
        return b;
    }
%>
<%
    /*
    regex = "[A-Z]*";
    regex1 = "[0-9]*";
    if( cpId.length() == 8 ){
        String engcpId = cpId.substring(0,4);
        String numcpId = cpId.substring(4,8);
        if( !paramChk(regex, engcpId) || !paramChk(regex1, numcpId) ){
            out.println("<script> alert('회원사ID 비정상');");
            out.println("history.back(); </script>");
        }
    } else {
        out.println("<script> alert('회원사ID 비정상');");
        out.println("history.back(); </script>");
    }
    */

	/*
	regex = "[0-9]*";
	if( urlCode.length() != 6 || !paramChk(regex, urlCode) ){
		out.println("<script> alert('URL코드 비정상');");
		out.println("history.back(); </script>");
	}
	*/

	/*
	if( certNum.length() == 0 || certNum.length() > 40){
		out.println("<script> alert('요청번호를 입력하세요.');");
		out.println("history.back(); </script>");
	}
	*/

	/*
	regex = "[0-9]*";
	if( date.length() != 14 || !paramChk(regex, date) ){
		out.println("<script> alert('요청일시 비정상');");
		out.println("history.back(); </script>");
	}
	*/

	/*
	regex = "[A-Z]*";
	if( certMet.length() != 1 || !paramChk(regex, certMet) ){
		out.println("<script> alert('본인확인방법 비정상');");
		out.println("history.back(); </script>");
	}
	*/

	/*
	if( tr_url.length() == 0 ){
		out.println("<script> alert('결과수신 URL 비정상');");
		out.println("history.back(); </script>");
	}
	*/

	/*
	regex = "[A-Z]*";
	if( tr_add.length() != 0 ){
		if( tr_add.length() != 1 || !paramChk(regex, tr_add) ){
			out.println("<script> alert('IFrame사용여부 비정상');");
			out.println("history.back(); </script>");
		}
	}
	*/

    // END 파라미터 유효성 검증 --------------------------------------------

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
    <title>KMC 본인확인서비스 테스트</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <meta name="robots" content="noindex">
    <style>
        <!--
        body,p,ol,ul,td
        {
            font-family: 굴림;
            font-size: 12px;
        }

        a:link { size:9px;color:#000000;text-decoration: none; line-height: 12px}
        a:visited { size:9px;color:#555555;text-decoration: none; line-height: 12px}
        a:hover { color:#ff9900;text-decoration: none; line-height: 12px}

        .style1 {
            color: #6b902a;
            font-weight: bold;
        }
        .style2 {
            color: #666666
        }
        .style3 {
            color: #3b5d00;
            font-weight: bold;
        }
        -->
    </style>

    <script language=javascript>
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
</head>

<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 marginheight=0 marginwidth=0>
<center>
    <br><br><br>
    <span class="style1">KMC 본인확인서비스 요청화면 Sample입니다.</span>
    <br><br>

    <table cellpadding=1 cellspacing=1>
        <tr>
            <td align=center>회원사ID</td>
            <td align=left><%=cpId%></td>
        </tr>
        <tr>
            <td align=center>URL코드</td>
            <td align=left><%=urlCode%></td>
        </tr>
        <tr>
            <td align=center>요청번호</td>
            <td align=left><%=certNum%></td>
        </tr>
        <tr>
            <td align=center>요청일시</td>
            <td align=left><%=date%></td>
        </tr>
        <tr>
            <td align=center>본인확인방법</td>
            <td align=left><%=certMet%></td>
        </tr>
        <tr>
            <td align=center>추가DATA정보</td>
            <td align=left><%=plusInfo%></td>
        </tr>
        <tr>
            <td align=center>&nbsp</td>
            <td align=left>&nbsp</td>
        </tr>
        <tr width=100>
            <td align=center>요청정보(암호화)</td>
            <td align=left><%=tr_cert.substring(0,50)%>...</td>
        </tr>
        <tr>
            <td align=center>결과수신URL</td>
            <td align=left><%=tr_url%></td>
        </tr>
        <tr>
            <td align=center>IFrame사용여부</td>
            <td align=left><%=tr_add%></td>
        </tr>
    </table>

    <br><br>
    <form name="reqKMCISForm" method="post">
        <input type="hidden" name="tr_cert"   value = "<%=tr_cert%>">
        <input type="hidden" name="tr_url"    value = "<%=tr_url%>">
        <input type="hidden" name="tr_add"    value = "<%=tr_add%>">
        <input type="submit" value="KMC 본인확인서비스" onclick="javascript:openKMCISWindow();">
    </form>

    <br>
    이 Sample화면은 KMC 본인확인서비스 요청화면 개발 시 참고가 되도록 제공하고 있는 화면입니다.
</center>
</body>
</html>