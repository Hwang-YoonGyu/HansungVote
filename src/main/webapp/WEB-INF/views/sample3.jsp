KMC ����Ȯ�μ��� ��� ������ ���� �˾� ���� ������
<%
    response.setHeader("Pragma","no-cache");			// HTTP1.0 ĳ�� ����
    response.setDateHeader("Expires",0);				// proxy ������ ĳ�� ����
    response.setHeader("Pragma", "no-store");			// HTTP1.1 ĳ�� ����
    if(request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache"); // HTTP1.1 ĳ�� ����
%>
<%@ page contentType = "text/html;charset=ksc5601"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%
    String rec_cert      = "";  // �����(��ȣȭ)
    String certNum       = "";  // certNum

    rec_cert = request.getParameter("rec_cert");
    certNum = request.getParameter("certNum");

    // �Ķ���� ��ȿ�� ����
    if( rec_cert.length() == 0 || certNum.length() == 0 ){
        out.println("<script> alert('����� ������');");
        return;
    }
%>

<html>
<head>
    <script language="JavaScript">

        // ��� ������ ��� ����
        var move_page_url = "/agreePop";

        function end() {
            var UserAgent = navigator.userAgent;

            document.form.action = move_page_url;

            // ������� ��� (�������� ���� ��� �߰� �ʿ�!)
            if (UserAgent.match(/iPhone|iPad|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null)
            {
                document.form.submit();
            }
            // ������� �ƴ� ���
            else {
                document.form.target = opener.window.name;
                document.form.submit();
                self.close();
            }
            // ����� app ȯ�濡 �°� ���� End
        }
    </script>
</head>

<body onload="javascript:end()">
<form id="form" name="form" method="post">
</form>
</body>
</html>