<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes"/>
    <title>**</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
<table id="studentDg" title="学生管理" class="easyui-datagrid" pagination="true"
       url="/student/list"
       toolbar="#student-toolbars"
       rownumbers="true" fitColumns="true" pageSize="30" singleSelect="true" fit="true">
    <thead>
    <tr>
        <th data-options="field:'ck',checkbox:true"></th>
        <th data-options="field:'id',width:100">学号</th>
        <th data-options="field:'cname',width:200" >姓名</th>
        <th data-options="field:'ename',width:200"></th>
        <th field="graduate" data-options="formatter:biYe,width:200">现状</th>
        <th data-options="field:'address',width:200">公司</th>
        <th field="status" data-options="formatter:xueLi,width:100">学历</th>
        <th field="image" data-options="formatter:formatImag" height="160" width="119">照片</th>
        <th data-options="field:'research',width:200">研究方向</th>
        <th data-options="field:'email',width:200">电子邮件</th>
    </tr>
    </thead>
</table>
<div id="student-toolbars">
    <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addStudent()">添加</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editStudent()">修改</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyStudent()">删除</a>
    <span>学生ID:</span>
    <input id="studentid" style="line-height:26px;border:1px solid #ccc">
    <a href="#" class="easyui-linkbutton" plain="true" onclick="studentSearch()">搜索</a>

    <a href="#" class="easyui-linkbutton"  plain="true" onclick="addimage()">上传学生照片</a>

</div>


<%--添加修改窗口--%>
<div id="studentDlg" class="easyui-dialog" style="width:500px;height:500px;padding:10px 20px"
     closed="true" buttons="#studentDlg-buttons">
    <div class="ftitle" align="center">学生编辑</div>
    <br>
    <form id="studentFm" method="post">
        <div class="fitem" >
            <label >编号:</label>
            <input name="id" class="easyui-validatebox" required="true" >
        </div>
        <div class="fitem " >
            <label>名字:</label>
            <input name="cname" class="easyui-validatebox" required="true" placeholder="姓名">
        </div>
        <div class="fitem">
            <label>名字:</label>
            <input name="ename" class="easyui-validatebox" required="true" placeholder="ENGLISH">
        </div>
        <div class="fitem">
            <label>地址:</label>
            <input name="address" class="easyui-validatebox" required="true" placeholder="现公司或学校">
        </div>
        <div class="fitem">
            <label>学历:</label>
            <input name="status" class="easyui-validatebox" required="true" placeholder="1为博士,2为硕士">
        </div>
        <div class="fitem">
            <label>是否毕业:</label>
            <input name="graduate" class="easyui-validatebox" required="true" placeholder="1为毕业,2为在读 ">
        </div>
        <div class="fitem">
            <label>研究方向:</label>
            <input name="research" class="easyui-validatebox" >
        </div>
        <div class="fitem">
            <label>电子邮件:</label>
            <input name="email" class="easyui-validatebox" >
        </div>
    </form>
</div>
<div id="studentDlg-buttons">
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="studentSave()">保存</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#studentDlg').dialog('close')">取消</a>
</div>

<%--上传图片--%>
<div id="imageDlg" class="easyui-dialog" style="width:300px;height:300px;padding:10px 20px"
     closed="true" buttons="#imageDlg-buttons">
    <div class="ftitle" align="center">上传照片</div>
    <br>
    <form  enctype="multipart/form-data" method="post" id="imageAdd">
        <input name="id" class="easyui-validatebox" required="true" style="display:none;">
        <input name="ename" class="easyui-validatebox" required="true" style="display:none;">
        <input type="file" name="uploadFile" accept="image/*" multiple="multiple"><br><br>
        <input type="button" value="上传" onclick="addImage()">
    </form>
</div>

<div id="imageDlg-buttons">
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#imageDlg').dialog('close')">取消</a>
</div>
<img src="" alt="">
<script type="text/javascript">
    function formatImag(val, row) {
        console.log(val)
        if (val)
            return "<img src='" + val + "'alt='hah' height='160' width='119'> ";
        else
            return null;
    }

    function xueLi(val, row) {
        if (val == 1)
            return "博士";
        else
            return "硕士";
    }

    function biYe(val, row) {
        if (val==1)
            return "毕业";
        else
            return "在读";
    }
    /**搜索*/
    function studentSearch() {

        $('#studentDg').datagrid('load', {
            studentID: $('#studentid').val(),
        });
    }

    var url;
    /**添加学生*/
    function addStudent() {
        $('#studentDlg').dialog('open').dialog('setTitle','添加学生');
        $('#studentFm').form('clear');
        url='/student/add'
    }

    /**删除学生*/
    function destroyStudent() {
        var row = $('#studentDg').datagrid('getSelected');
        if (row == null)
            $.messager.alert("系统提示", "请选中要删除的名单");
        else {
            $.messager.confirm("警告", "您确定删除，删除后无法更改", function (data) {
                if (data) {
                    $.post('/student/delete', {studentID: row.id}, function (data) {
                        if (data.success) {
                            $.messager.alert("系统提示", "删除成功");
                            $("#studentDg").datagrid("reload");
                        }
                    }, 'json');
                }

            })

        }
    }


    /**修改*/
    function editStudent() {

        var row = $('#studentDg').datagrid('getSelected');
        if (row) {
            $('#studentDlg').dialog('open').dialog('setTitle', '修改学生');
            $('#studentFm').form('load', row);
            url='/student/update'
        } else {
            $.messager.alert("系统提示", "请选中学生");
        }

    }


    function studentSave() {


        /**修改学生*/
        if (url=='/student/update')
        {
            $('#studentFm').form('submit', {
                url: url,
                onSubmit: function () {
                    return $(this).form('validate');
                },
                success: function (result) {
                    var result = eval('(' + result + ')');
                    if (result.success) {
                        $.messager.alert("系统提示", "修改成功！");
                        //关闭对话框
                        $("#studentDlg").dialog("close");
                        //刷新查询结果
                        $("#studentDg").datagrid("reload");
                    }
                }
            });
        }


        /**添加学生*/
        if (url=='/student/add')
        {
            $('#studentFm').form('submit',{
                url: url,
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                    var result = eval('('+result+')');
                    if (result.success){
                        $.messager.alert("系统提示","操作成功！");
                        //关闭对话框
                        $("#studentDlg").dialog("close");
                        //刷新查询结果
                        $("#studentDg").datagrid("reload");
                    }else{
                        $.messager.alert("系统提示",result.error);
                    }
                }
            });
        }

    }


    function addimage() {
        var row = $('#studentDg').datagrid('getSelected');
        if (row) {
            $('#imageAdd').form('load', row);
            $('#imageDlg').dialog('open').dialog('setTitle', '添加照片');
        } else {
            $.messager.alert("系统提示", "请选中学生");
        }
    }

    function addImage() {
        $('#imageAdd').form('submit',{
            url: '/student/image',
            onSubmit: function(){
                return $(this).form('validate');
            },
            success: function(result){
                var result = eval('('+result+')');
                if (result.success){
                    $.messager.alert("系统提示","操作成功！");

                    //关闭对话框
                    $("#imageDlg").dialog("close");
                    //刷新查询结果
                    $("#studentDg").datagrid("reload");
                }else{
                    $.messager.alert("系统提示",result.error);
                }

            }
        });

    }


</script>
</body>
</html>