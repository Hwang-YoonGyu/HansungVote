<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>

<script languege="JavaScript">
   byte[] bydata = ${bydata};
   
   var base64 = Convert.ToBase64String(bydata);
   var imgSrc = String.Format("data:image/jpg;base64,{0}", base64);

</script>
<body>
   <!-- img��洹몄�� src 寃쎈��� byte�대�몄� 媛��몄�ㅻ�� 而⑦�몃·�� �몄�(/getByteImage) -->
   <img alt="" src="${imgSrc}" />
</body>


</html>