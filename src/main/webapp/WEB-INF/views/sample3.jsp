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
    String rec_cert      = "";  // 결과값(암호화)
    String certNum       = "";  // certNum

    rec_cert = request.getParameter("rec_cert");
    certNum = request.getParameter("certNum");

    // 파라미터 유효성 검증
    if( rec_cert.length() == 0 || certNum.length() == 0 ){
        out.println("<script> alert('결과값 비정상');");
        return;
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
</form>
</body>
</html>