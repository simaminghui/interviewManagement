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
<table id="teacherDg" title="老师管理" class="easyui-datagrid" pagination="true"
       url="/teacher/list"
       toolbar="#teacher-toolbars"
       rownumbers="true" fitColumns="true" pageSize="30" singleSelect="true" fit="true">
    <thead>
    <tr>
        <th data-options="field:'ck',checkbox:true"></th>
        <th data-options="field:'id'">教师编号</th>
        <th data-options="field:'cname'">姓名</th>
        <th data-options="field:'ename'"></th>
        <th data-options="field:'sex'">性别</th>
        <th data-options="field:'status'">身份</th>
        <th field="department" data-options="formatter:formatDepartment,width:150">院系</th>
        <th field="address" data-options="formatter:formatAddress,width:200" nowrap="flase">地址</th>
        <th data-options="field:'email'">邮箱</th>
        <th field="image" data-options="formatter:formatImag" height="160" width="119">照片</th>
        <th data-options="field:'postcode'">邮编</th>
        <th field="research" data-options="formatter:formatResearch,width:200" nowrap="flase">研究方向</th>
        <th field="projects" data-options="formatter:formatProject,width:200" nowrap="nowrap">经历</th>
    </tr>
    </thead>
</table>
<div id="teacher-toolbars">
    <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addTeacher()">添加</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editTeacher()">修改</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyTeacher()">删除</a>

    <a href="#" class="easyui-linkbutton"  plain="true" onclick="addTeacherImage()">上传老师照片</a>
</div>
<%--上传图片--%>
<div id="imageTeacherDlg" class="easyui-dialog" style="width:300px;height:300px;padding:10px 20px"
     closed="true" buttons="#imageTeacherDlg-buttons">
    <div class="ftitle" align="center">上传照片</div>
    <br>
    <form  enctype="multipart/form-data" method="post" id="Addimage">
        <input name="id" class="easyui-validatebox" required="true" style="display:none;">
        <input name="ename" class="easyui-validatebox" required="true" style="display:none;">
        <input type="file" name="uploadFile" accept="image/*" multiple="multiple"><br><br>
        <input type="button" value="上传" onclick="TeacherImageAdd()">
    </form>
</div>
<div id="imageTeacherDlg-buttons">
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#imageTeacherDlg').dialog('close')">取消</a>
</div>

<%--添加修改--%>
<div id="teacherDlg" class="easyui-dialog" style="width:500px;height:500px;padding:10px 20px"
     closed="true" buttons="#teacherDlg-buttons">
    <div class="ftitle" align="center">老师编辑</div>
    <br>
    <form id="teacherFm" method="post">
        <div class="fitem">
            <label>编号:</label>
            <input name="id" class="easyui-validatebox" required="true">
        </div>
        <div class="fitem">
            <label>名字:</label>
            <input name="cname" class="easyui-validatebox" required="true" placeholder="中文名字">
        </div>
        <div class="fitem">
            <label>名字:</label>
            <input name="ename" class="easyui-validatebox" required="true" placeholder="英文名字">
        </div>
        <div class="fitem">
            <label>性别:</label>
            <input name="sex" class="easyui-validatebox" required="true" placeholder="男或女">
        </div>
        <div class="fitem">
            <label>身份:</label>
            <input name="status" class="easyui-validatebox" required="true" placeholder="博导或硕导">
        </div>
        <div class="fitem">
            <label>院系:</label>
            <input name="department" class="easyui-validatebox" required="true" placeholder="如西北大学计算机院">
        </div>
        <div class="fitem">
            <label>地址:</label>
            <input name="address" class="easyui-validatebox" required="true" placeholder="填写地址">
        </div>
        <div class="fitem">
            <label>邮箱:</label>
            <input name="email" class="easyui-validatebox" required="true" placeholder="填写邮箱">
        </div>
        <div class="fitem">
            <label>邮编:</label>
            <input name="postcode" class="easyui-validatebox" required="true" placeholder="填写邮编">
        </div>
        <div class="fitem">
            <label style="margin-bottom: 10%">方向:</label>
            <textarea name="research" class="easyui-validatebox" required="true" style="height: 150px" ></textarea>
        </div>
        <div class="fitem">
            <label>经历:</label>
            <textarea name="projects" class="easyui-validatebox" required="true" style="height: 150px"></textarea>
        </div>
    </form>
</div>
<div id="teacherDlg-buttons">
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="teacherSave()">保存</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#teacherDlg').dialog('close')">取消</a>

</div>


<script type="text/javascript">
    /**经历换行*/
    function formatProject(value, row, index) {
        return '<div style="width=250px;word-break:break-all;word-wrap:break-word;white-space:pre-wrap;">' + value + '</div>';
    }

    /**方向换行*/
    function formatResearch(value, row, index) {
        return '<div style="width=250px;word-break:break-all;word-wrap:break-word;white-space:pre-wrap;">' + value + '</div>';
    }

    /**地址换行*/
    function formatAddress(value, row, index) {
        return '<div style="width=250px;word-break:break-all;word-wrap:break-word;white-space:pre-wrap;">' + value + '</div>';
    }

    /**院系换行*/
    function formatDepartment(value, row, index) {
        return '<div style="width=250px;word-break:break-all;word-wrap:break-word;white-space:pre-wrap;">' + value + '</div>';
    }

    /**得到照片*/
    function formatImag(val, row) {
        if (val)
            return "<img src='" + val + "'alt='hah' height='160' width='119'> ";
        else
            return null;
    }


    /**添加老师*/
    function addTeacher(){
        $('#teacherDlg').dialog('open').dialog('setTitle','添加老师');
        $('#teacherFm').form('clear');
        teacherUrl = '/teacher/save';
    }


    /**删除老师*/
    function destroyTeacher() {
        var row = $('#teacherDg').datagrid('getSelected');
        if (row == null)
            $.messager.alert("系统提示", "请选中要删除的名单");
        else {
            $.messager.confirm("警告", "您确定删除，删除后无法更改", function (data) {
                if (data) {
                    $.post('/teacher/delete', {id: row.id}, function (data) {
                        if (data.success) {
                            $.messager.alert("系统提示", "删除成功");
                            $("#teacherDg").datagrid("reload");
                        }
                    }, 'json');
                }

            })

        }

    }

    var teacherUrl = "";


    /**修改老师信息*/
    function editTeacher() {
        var row = $('#teacherDg').datagrid('getSelected');
        if (row) {
            $('#teacherDlg').dialog('open').dialog('setTitle', '修改教师');
            $('#teacherFm').form('load', row);
            teacherUrl = "/teacher/update";
        } else {
            $.messager.alert("系统提示", "请选中要修改的教师");
        }
    }


    function teacherSave() {

        /**添加用户*/
        if (teacherUrl == '/teacher/save') {


            $('#teacherFm').form('submit', {
                url: teacherUrl,
                onSubmit: function () {
                    return $(this).form('validate');
                },
                success: function (result) {
                    var result = eval('(' + result + ')');
                    if (result.success) {
                        $.messager.alert("系统提示", "操作成功！");
                        //关闭对话框
                        $("#teacherDlg").dialog("close");
                        //刷新查询结果
                        $("#teacherDg").datagrid("reload");
                    } else {
                        $.messager.alert("系统提示", result.error);
                    }
                }
            });
        }

        /**修改用户*/
        if (teacherUrl == '/teacher/update') {

            /**若ID 没修改则通过此方法修改*/
            $('#teacherFm').form('submit', {
                url: teacherUrl,
                onSubmit: function () {
                    return $(this).form('validate');
                },
                success: function (result) {
                    var result = eval('(' + result + ')');
                    if (result.success) {
                        $.messager.alert("系统提示", "修改成功！");
                        //关闭对话框
                        $("#teacherDlg").dialog("close");
                        //刷新查询结果
                        $("#teacherDg").datagrid("reload");
                    }
                }
            });


        }

    }



    /**打开上传的页面*/
    function addTeacherImage() {
        var row = $('#teacherDg').datagrid('getSelected');
        if (row) {
            $('#Addimage').form('load', row);
            $('#imageTeacherDlg').dialog('open').dialog('setTitle', '添加照片');
        } else {
            $.messager.alert("系统提示", "请选中老师");
        }
    }

    function TeacherImageAdd() {
        $('#Addimage').form('submit',{
            url: '/teacher/image',
            onSubmit: function(){
                return $(this).form('validate');
            },
            success: function(result){
                var result = eval('('+result+')');
                if (result.success){
                    $.messager.alert("系统提示","操作成功！");

                    //关闭对话框
                    $("#imageTeacherDlg").dialog("close");
                    //刷新查询结果
                    $("#teacherDg").datagrid("reload");
                }else{
                    $.messager.alert("系统提示",result.error);
                }

            }
        });

    }
</script>

</body>
</html>