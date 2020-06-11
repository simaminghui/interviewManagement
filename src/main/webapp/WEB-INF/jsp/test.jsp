<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes"/>
    <title>**</title>
</head>
<body>
<form action="/student/image" enctype="multipart/form-data" method="post">
    <input type="file" name="uploadFile" accept="image/*" ><br><br>

    <input name="id" value="1">
        <input type="submit" value="上传">
</form>
</body>
</html>