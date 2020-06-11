<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes"/>
    <title>实验室管理</title>
    <script type="text/javascript" src="../../myjs/jquery.js"></script>
    <script type="text/javascript" src="../../myjs/jquery.easyui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../../mycss/easyui.css">
    <link rel="stylesheet" type="text/css" href="../../mycss/icon.css">
    <link rel="stylesheet" type="text/css" href="../../mycss/common.css">
    <script type="text/javascript" src="../../myjs/easyui-lang-zh_CN.js"></script>
</head>

<body>

<body class="easyui-layout">
<div data-options="region:'north',title:'',split:true" style="height:100px;"></div>
<div data-options="region:'west',title:'操作管理',split:true" style="width:200px;"  id="navmenu">
    <div class="easyui-accordion"  fit="true" >
        <div title="人员管理">
            <ul class="navmenu">
                <li class="active"><a href="#" data-url="teacher">老师信息</a></li>
                <li><a href="#" data-url="student">学生信息</a></li>
            </ul>
        </div>
        <div title="新闻">
            <ul class="navmenu">
                <li ><a href="/addNews" class="datalist-link" >发布新闻</a></li>
                <li><a href="#" data-url="editorNews">新闻编辑</a></li>
            </ul>
        </div>
        <div title="论文科研">
            <ul class="navmenu">
                <li ><a href="#" data-url="latetime">论文著作</a></li>
                <li ><a href="#" data-url="latetime">科研转化</a></li>
            </ul>
        </div>

    </div>

</div>
<div data-options="region:'center'" style="padding:5px;background:#eee;">
    <div class="easyui-tabs" fit="true" id="tt">

    </div>


</div>



</body>

<script type="text/javascript">

    $(function () {

        if ($("#tt").tabs("exists", "老师信息")) { //判断该Tab页是否已经存在
            $("#tt").tabs("select", "老师信息");
        } else {
            $("#tt").tabs("add", {
                title: "老师信息",
                href: "teacher",
                closable: true
            });
        };



        $("#navmenu").on("click","[data-url]",function (e) {
            e.preventDefault();
            var tabTitle=$(this).text();
            var tabUrl=$(this).data("url");


            if ($("#tt").tabs("exists", tabTitle)) { //判断该Tab页是否已经存在
                $("#tt").tabs("select", tabTitle);
            } else {
                $("#tt").tabs("add", {
                    title: tabTitle,
                    href: tabUrl,
                    closable: true
                });
            }
            $("#navmenu .active").removeClass("active");
            $(this).parent().addClass("active");

        });
        //解决闪屏的问题
        window.setTimeout(function () {
            $("#layout").css("visibility", "visible");
        }, 800);
    })
</script>


</body>
</html>