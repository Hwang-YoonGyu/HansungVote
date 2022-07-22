<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert Image</title>
</head>
<body>
   <form action="/hansungenquete/saveImage" enctype="multipart/form-data" method="post">
      <div>
         <label>선거이름</label>
         <input type="text" name="title" value=""/>
      </div>
      <div>
         <label>후보자</label>
         <input type="text" name="content" value=""/>
      </div>
      <input type="file" name="imgFile" />
      <input type="submit" value="이미지저장"/>
   </form>
</body>
</html>