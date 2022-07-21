<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
   <form action="/hansungenquete/saveImage" enctype="multipart/form-data" method="post">
      <div>
         <label>title</label>
         <input type="text" name="title" value=""/>
         
      </div>
      <div>
         <label>content</label>
         <input type="text" name="content" value=""/>
         
      </div>
      
      
      <input type="file" name="imgFile" />
      <input type="submit" value="이미지저장"/>
      
   </form>



</body>
</html>