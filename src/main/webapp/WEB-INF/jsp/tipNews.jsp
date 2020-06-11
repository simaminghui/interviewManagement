<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes"/>
    <title>**</title>、

    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
   <script type="text/javascript" src="../../myjs/jquery.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/editor/ueditor.all.js"> </script>
    <script type="text/javascript" charset="utf-8" src="/editor/lang/zh-cn/zh-cn.js"></script>

</head>
<body>
<form class="form-horizontal" role="form">
    <input id="id" value="${news.id}" style="display: none">
    <div class="form-group">
        <label class="col-sm-1 control-label">题目</label>
        <div class="col-sm-11">
            <input class="form-control" id="title" type="text"  placeholder="新闻题目" value="${news.title}">
        </div>
    </div>
    <div class="form-group has-success">
        <label class="col-sm-1 control-label" for="author">
            作者
        </label>
        <div class="col-sm-11">
            <input type="text" class="form-control" id="author" placeholder="新闻作者" value="${news.author}">
        </div>
    </div>
    <div class="form-group has-warning">
        <label class="col-sm-1 control-label" for="digest">
            标记
        </label>
        <div class="col-sm-11">
            <input type="text" class="form-control" id="digest" placeholder="如：学术内容" value="${news.digest}">
        </div>
    </div>
    <div class="form-group has-error">
        <label class="col-sm-1 control-label" for="content">
            新闻内容
        </label>
        <div class="col-sm-11">
            <textarea type="text"  id="content" >${news.content}</textarea>
        </div>
    </div>
    <div class="form-group has-error">
        <label class="col-sm-1 control-label" for="content">
            内容介绍
        </label>
        <div class="col-sm-11">
            <input type="text" class="form-control" id="introduce" value="${news.introduce}">
        </div>
    </div>
    <div class="row" align="center">
        <button type="button" class="btn btn-primary"
                data-toggle="button" onclick="xiuGaiNews()"> 确认修改
        </button>
    </div>
</form>


<script type="text/javascript">

    var ue = UE.getEditor('content');

    
    /**添加新闻*/
    function xiuGaiNews() {
        var id=$("#id").val();
        var title=$("#title").val();
        var author=$("#author").val();
        var digest=$("#digest").val();
        var content=UE.getEditor('content').getContent();
        var introduce=$("#introduce").val();
        if (title==''||title==null||author==''||author==null||digest==''||digest==null||content==''||content==null||introduce==''||introduce==null)
        {
            alert("必要内容不可为空");
        }
        else
        {
            $.post("/news/update",{id:id,title:title,author:author,digest:digest,content:content,introduce:introduce},function (data) {
                alert("修改成功");
            })
        }

    }

</script>
</body>
</html>