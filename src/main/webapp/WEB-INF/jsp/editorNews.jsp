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
<table id="newsDg" title="学生管理" class="easyui-datagrid" pagination="true"
       url="/news/list"
       toolbar="#news-toolbars"
       rownumbers="true" fitColumns="true" pageSize="30" singleSelect="true" fit="true">
    <thead>
    <tr>
        <th data-options="field:'ck',checkbox:true"></th>
        <th data-options="field:'id',width:100">编号</th>
        <th field="title" data-options="formatter:formatTitle,width:250" >题目</th>
        <th data-options="field:'author',width:200">作者</th>
        <th field="introduce" data-options="formatter:formatIntroduce,width:250">介绍</th>
    </tr>
    </thead>
</table>
<div id="news-toolbars">

    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editNews()">修改</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyNews()">删除</a>
</div>
<script type="text/javascript">
    /**题目换行*/
    function formatTitle(value, row, index) {
        return '<div style="width=250px;word-break:break-all;word-wrap:break-word;white-space:pre-wrap;">' + value + '</div>';
    }
    /**介绍换行*/
    function formatIntroduce(value, row, index) {
        return '<div style="width=250px;word-break:break-all;word-wrap:break-word;white-space:pre-wrap;">' + value + '</div>';
    }


    /**删除新闻*/
    /**删除学生*/
    function destroyNews() {
        var row = $('#newsDg').datagrid('getSelected');
        if (row == null)
            $.messager.alert("系统提示", "请选中要删除的新闻");
        else {
            $.messager.confirm("警告", "您确定删除，删除后无法更改", function (data) {
                if (data) {
                    $.post('/news/delete', {id: row.id}, function (data) {
                        if (data.success) {
                            $.messager.alert("系统提示", "删除成功");
                            $("#newsDg").datagrid("reload");
                        }
                    }, 'json');
                }

            })

        }
    }



    /**修改*/
    function editNews() {

        var row = $('#newsDg').datagrid('getSelected');
        if (row) {
            location.href="http://localhost:8077/news/"+row.id;
        } else {
            $.messager.alert("系统提示", "请选中新闻");
        }

    }
</script>

</body>
</html>