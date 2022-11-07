KMC 본인확인서비스 결과 데이터 수신 팝업 샘플 페이지
<%
    response.setHeader("Pragma","no-cache");			// HTTP1.0 캐쉬 방지
    response.setDateHeader("Expires",0);				// proxy 서버의 캐쉬 방지
    response.setHeader("Pragma", "no-store");			// HTTP1.1 캐쉬 방지
    if(request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache"); // HTTP1.1 캐쉬 방지
%>
<%@ page contentType = "text/html;charset=ksc5601"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%
    // 변수 -------------------------------------------------------------------------------------------------------------
    String rec_cert		= "";           // 결과수신DATA
    String k_certNum	= "";			// 요청번호 파라미터
    String certNum		= ""; 			// 요청번호
    String date			= "";			// 요청일시
    String CI			= "";			// 연계정보(CI)
    String DI			= "";			// 중복가입확인정보(DI)
    String mNumber		= "";			// 휴대폰번호
    String mCorp		= "";			// 이동통신사
    String birth		= "";			// 생년월일
    String gender		= "";			// 성별
    String nation		= "";			// 내국인
    String name			= "";			// 성명
    String reserve1		= "";			// 예비필드
    String reserve2		= "";			// 예비필드
    String reserve3		= "";			// 예비필드
    String reserve4		= "";			// 예비필드
    String result		= "";			// 결과값

    String certMet		= "";			// 본인확인방법
    String ip			= "";			// ip주소
    String plusInfo		= "";

    String encPara		= "";
    String encMsg1		= "";
    String encMsg2		= "";
    String msgChk		= "";

    try {
        // Parameter 수신 --------------------------------------------------------------------
        rec_cert = request.getParameter("rec_cert").trim();
        k_certNum = request.getParameter("certNum").trim();
%>
[복호화 하기전 수신값]<br><br>
rec_cert : <%=rec_cert%><br><br>
k_certNum : <%=k_certNum%><br><br>
<%
    //01. 암호화 모듈 (jar) Loading
    com.icert.comm.secu.IcertSecuManager seed    = new com.icert.comm.secu.IcertSecuManager();

    //02. 1차 복호화
    rec_cert  =  seed.getDec(rec_cert, k_certNum);

    //03. 1차 파싱
    int inf1 = rec_cert.indexOf("/",0);
    int inf2 = rec_cert.indexOf("/",inf1+1);

    encPara  = rec_cert.substring(0,inf1);         //암호화된 통합 파라미터
    encMsg1  = rec_cert.substring(inf1+1,inf2);    //암호화된 통합 파라미터의 Hash값

    //04.위변조 검증
    encMsg2  = seed.getMsg(encPara);

    if(encMsg2.equals(encMsg1)){
        msgChk="Y";
    }

    if(msgChk.equals("N")){
%>
<script language=javascript>
    alert("비정상적인 접근입니다.!!<%=msgChk%>");
</script>
<%
        return;
    }

    //05. 2차 복호화
    rec_cert  = seed.getDec(encPara, k_certNum);

    //06. 2차 파싱
    int info1  = rec_cert.indexOf("/",0);
    int info2  = rec_cert.indexOf("/",info1+1);
    int info3  = rec_cert.indexOf("/",info2+1);
    int info4  = rec_cert.indexOf("/",info3+1);
    int info5  = rec_cert.indexOf("/",info4+1);
    int info6  = rec_cert.indexOf("/",info5+1);
    int info7  = rec_cert.indexOf("/",info6+1);
    int info8  = rec_cert.indexOf("/",info7+1);
    int info9  = rec_cert.indexOf("/",info8+1);
    int info10 = rec_cert.indexOf("/",info9+1);
    int info11 = rec_cert.indexOf("/",info10+1);
    int info12 = rec_cert.indexOf("/",info11+1);
    int info13 = rec_cert.indexOf("/",info12+1);
    int info14 = rec_cert.indexOf("/",info13+1);
    int info15 = rec_cert.indexOf("/",info14+1);
    int info16 = rec_cert.indexOf("/",info15+1);
    int info17 = rec_cert.indexOf("/",info16+1);
    int info18 = rec_cert.indexOf("/",info17+1);

    certNum		= rec_cert.substring(0,info1);
    date		= rec_cert.substring(info1+1,info2);
    CI			= rec_cert.substring(info2+1,info3);
    mNumber	    = rec_cert.substring(info3+1,info4);
    mCorp		= rec_cert.substring(info4+1,info5);
    birth		= rec_cert.substring(info5+1,info6);
    gender		= rec_cert.substring(info6+1,info7);
    nation		= rec_cert.substring(info7+1,info8);
    name		= rec_cert.substring(info8+1,info9);
    result		= rec_cert.substring(info9+1,info10);
    certMet		= rec_cert.substring(info10+1,info11);
    ip			= rec_cert.substring(info11+1,info12);
    reserve1	= rec_cert.substring(info12+1,info13);
    reserve2	= rec_cert.substring(info13+1,info14);
    reserve3	= rec_cert.substring(info14+1,info15);
    reserve4	= rec_cert.substring(info15+1,info16);
    plusInfo   	= rec_cert.substring(info16+1,info17);
    DI			= rec_cert.substring(info17+1,info18);

    //07. CI, DI 복호화
    CI  = seed.getDec(CI, k_certNum);
    DI  = seed.getDec(DI, k_certNum);
    }catch(Exception ex){
        System.out.println("[KMCIS] Receive Error -"+ex.getMessage());
    }
%>

<html>
<head>
    <script language="JavaScript">

        // 결과 페이지 경로 설정
        var move_page_url = "/agreePop";

        function end() {
            var UserAgent = navigator.userAgent;

            document.form.action = move_page_url;
            var input1 = document.createElement('input');
            input1.type = 'hidden';
            input1.name = 'certPhoneNumber';
            input1.value = '<%=mNumber%>';
            document.form.appendChild(input1);

            // 모바일인 경우 (변동사항 있을 경우 추가 필요!)
            if (UserAgent.match(/iPhone|iPad|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null)
            {

                document.form.submit();
            }
            // 모바일이 아닌 경우
            else {
                document.form.target = opener.window.name;
                document.form.submit();
                self.close();
            }
            // 모바일 app 환경에 맞게 수정 End
        }
    </script>
</head>

<body onload="javascript:end()">
<form id="form" name="form" method="post">
    <input type="hidden" id="name" value="<%=name%>" />
</form>
</body>
</html>