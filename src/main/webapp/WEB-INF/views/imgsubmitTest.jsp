<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert Image</title>
</head>
<body>
   <form action="/manager/excel" enctype="multipart/form-data" method="post">
      <input type="file" name="excelFile" />
      <input type="submit" value="업로드"/>
   </form>
</body>
</html>