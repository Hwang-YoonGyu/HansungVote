<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert Image</title>
</head>
<body>
   <form action="/saveImage" enctype="multipart/form-data" method="post">
      <div>
         <label>선거이름</label>
         <input type="text" name="election_name" value=""/>
      </div>
      <div>
         <label>후보자이름</label>
         <input type="text" name="candidate_name" value=""/>
      </div>
      <input type="file" name="imgFile" />
      <input type="submit" value="업로드"/>
   </form>
</body>
</html>