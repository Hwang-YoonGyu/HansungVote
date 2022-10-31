본인확인 서비스 호출전 데이터 입력 샘플 페이지
<%
  response.setHeader("Pragma","no-cache");			// HTTP1.0 캐쉬 방지
  response.setDateHeader("Expires",0);				// proxy 서버의 캐쉬 방지
  response.setHeader("Pragma", "no-store");			// HTTP1.1 캐쉬 방지
  if(request.getProtocol().equals("HTTP/1.1"))
    response.setHeader("Cache-Control", "no-cache"); // HTTP1.1 캐쉬 방지
%>
<%@ page  contentType = "text/html;charset=ksc5601"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.text.SimpleDateFormat" %>
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
</head>

<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 marginheight=0 marginwidth=0>
<center>
  <br><br><br>
  <span class="style1">KMC 본인확인서비스 테스트</span>
  <br><br>

  <form name="reqForm" method="post" action="/sample2">

    <table cellpadding=1 cellspacing=1>
      <tr>
        <td align=center><font color="red">*</font> 회원사ID</td>
        <td align=left><input type="text" name="cpId" id="cpId" size='41' maxlength ='10' value = ""></td>
      </tr>
      <tr>
        <td align=center><font color="red">*</font> URL코드</td>
        <td align=left><input type="text" name="urlCode" id="urlCode" size='41' maxlength ='6' value=""></td>
      </tr>
      <tr>
        <td align=center><font color="red">*</font> 요청번호</td>
        <td align=left><input type="text" name="certNum" id="certNum" size='41' maxlength ='40' value='<%=reqNum%>'></td>
      </tr>
      <tr>
        <td align=center><font color="red">*</font> 요청일시</td>
        <% // 현재시각 세팅(YYYYMMDDHI24MISS) %>
        <td align=left><input type="text" name="date" size="41" maxlength ='14' value="<%=day%>"></td>
      </tr>
      <tr>
        <td align=center><font color="red">*</font>본인확인방법</td>
        <td align=left>
          <select name="certMet" id="certMet" style="width:300">
            <option value="M" selected>본인확인방법 선택</option>
          </select>
        </td>
      </tr>
      <tr>
        <td align=center><font color="red">*</font> 결과수신URL</td>
        <td align=left><input type="text" name="tr_url" size="41" value="/sample3"></td>
      </tr>
      <tr>
        <td align=center>추가DATA정보</td>
        <td align=left><input type="text" name="plusInfo"  size="41" maxlength ='320' value=""></td>
      </tr>
      <tr>
        <td align=center>IFrame사용여부</td>
        <td align=left>
          <select name="tr_add" style="width:300">
            <option value="N">미사용</option>
            <option value="Y">사용</option>
          </select>
        </td>
      </tr>
    </table>

    <br><br>
    <input type="submit" value = "KMC 본인확인서비스 테스트">
    <br><br>
    이 Sample화면은 KMC 본인확인서비스 테스트를 위해 제공하고 있는 화면입니다.<br><br>
    <font color="red">*</font> 필수 입력 항목입니다!
  </form>
</center>
</body>
</html>