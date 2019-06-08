<%--
  Created by IntelliJ IDEA.
  User: 梦之恋~易霜
  Date: 2019/5/23
  Time: 10:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Basic Layout - jQuery EasyUI Demo</title>
    <link rel="stylesheet" type="text/css" href="/static/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/static/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="/static/demo/demo.css">
    <script type="text/javascript" src="/static/jquery.min.js"></script>
    <script type="text/javascript" src="/static/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/static/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/static/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
<input id="pname" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:300px">
<select id="cid" class="easyui-combotree easyui-textbox" style="width:200px;"
        data-options="url:'/bawei/getTree',required:true"></select>
<input type="radio" id="n" name="psex" value="男">男
<input type="radio" id="v" name="psex" value="女">女
<%--    <c:forEach items="${goods}" var="g">--%>
<%--        ${g.psex}<input type="checkbox"  value="${g.psex}"id="psex" name="psex">男--%>
<%--        ${g.psex}<input type="checkbox"  value="${g.psex}"id="psex" name="psex">女--%>
<%--    </c:forEach>--%>


<a id="cx" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="getcx()">查询</a>
<table id="dg"></table>
<a id="sc" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pishan()">批量删除</a>
<a id="tj" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="gettj()">添加</a>
</body>
<%--添加--%>

<div id="dd" class="easyui-dialog" title="My Dialog" style="width:400px;height:300px;"
     data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true">
    <form id="ff" method="post">
        <div>
            <input id="id" class="easyui-validatebox" type="hidden" name="id" data-options="required:true"/>
        </div>
        <div>
            <label>姓名:</label>
            <input class="easyui-validatebox" type="text" id="pname1" name="pname" data-options="required:true"/>
        </div>
        <div>
            <label>性别:</label>
            <input type="radio" value="男" name="psex">男
            <input type="radio" value="女" name="psex">女
        </div>
        <div>
            <label>身份证:</label>
            <input class="easyui-validatebox" type="text" id="sfz" name="sfz" data-options="required:true"/>
        </div>
        <div>
            <label>日期 :</label>
            <input class="easyui-validatebox easyui-datebox" type="text" id="pdt" name="pdt"
                   data-options="required:true"/>
        </div>
        <div>
            <label>地区:</label><br>
            <input id="cc1" class="easyui-combobox" data-options="
                valueField: 'id',
                textField: 'text',
                url: '/bawei/getCity?pid=0',
                onSelect: function(rec){
                    var url = '/bawei/getCity?pid='+rec.id;
                        $('#cc2').combobox('clear');
                        $('#cc3').combobox('clear');
                        $('#cc2').combobox('reload',url);
                }" name="sheng"/>
            <br>
            <input id="cc2" class="easyui-combobox" data-options="
                valueField: 'id',
                textField: 'text',
                onSelect: function(rec){
                    var url = '/bawei/getCity?pid='+rec.id;
                        $('#cc3').combobox('clear');
                        $('#cc3').combobox('reload', url);
                }" name="shi"/>
            <br>
            <input id="cc3" name="cid" class="easyui-combobox" data-options="valueField:'id',textField:'text'"/>
        </div>

        <div>
            <label>详细住址:</label>
            <input class="easyui-validatebox" type="text" id="addr" name="addr" data-options="required:true"/>
        </div>

    </form>
    <a id="bc" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="getbc()">保存</a>
</div>
<script>
    //表格
    $('#dg').datagrid({
        url: '/bawei/getlist',
        pagination: true,
        pageNumber: 1,
        pageSize: 3,
        pageList: [3, 6, 10],
        //onClickRow: selectRow,
        columns: [[
            {field: 'id', title: '编号', width: 100, checkbox: true},
            {field: 'pname', title: '姓名', width: 100},
            {field: 'psex', title: '性别', width: 100},
            {field: 'sfz', title: '身份证', width: 100},
            {field: 'cityName', title: '城市', width: 200},
            {field: 'pdt', title: '出生日期', width: 100},
            {
                field: 'caozuo', title: '操作', width: 200, formatter: function (value, row, index) {
                    return "<button onclick='xiugai(" + index + ")'>编辑</button>" +
                        "<button onclick='look(" + index + ")'>详情</button>" +
                        "<button onclick='deleteById(" + index + ")'>删除</button>";
                }
            }
        ]]
    });


    //模糊查询
    function getcx() {
        var pname = $('#pname').textbox('getValue');
        var cid = $('#cid').textbox('getValue');
        var psex = $("input[name='psex']:checked").val();

        $('#dg').datagrid('load', {
            pname: pname,
            cid: cid,

        });
    }


    //
    // //批量删除
    //     function deleteBatch() {
    //         var rows = $("#dg").datagrid("getSelections");
    //         var ids= Array();
    //         rows.forEach(function (value) {
    //             ids.push(value.id)
    //         })
    //         $.messager.confirm('确认', '您确认想要删除记录吗？', function (r) {
    //             if (r) {
    //                 $.post(
    //                     "/bawei/pishan", {ids:ids}, function (data) {
    //                         $("#dg").datagrid("reload")
    //                     }
    //                 );
    //             }
    //         });
    //
    //     }

    //批删
    function pishan() {
        $.messager.confirm('确认', '您确认想要删除记录吗？', function (r) {
            if (r) {
                var rows = $("#dg").datagrid("getSelections");
                var pids = Array();
                rows.forEach(function (value) {
                    pids.push(value.id);
                })
                $.post(
                    "/bawei/pishan", {ids: pids},
                    function (data) {
                        alert("删除成功");
                        $('#dg').datagrid('reload');
                    }
                )
            }
        });
    }


    //        删除
    function deleteById(index) {
        $.messager.confirm('确认', '您确认想要删除记录吗？', function (r) {
            if (r) {
                $('#dg').datagrid("selectRow", index);
                var row = $("#dg").datagrid("getSelected")
                $.post(
                    "/bawei/deleteById", {id: row.id}, function (data) {
                        $("#dg").datagrid("reload")
                    }
                );
            }
        });
    }


    //添加
    function gettj() {
        $('#dd').window('open');  // open a window
        $('#ff').form('reset')//重置表单
        $('#id').val("0")
    }

    //保存
    function getbc() {
        var url = "/bawei/update";
        if ($("#id").val() == 0) {
            url = "/bawei/add";
        }
        ;
        $("#ff").form('submit', {
            url: url,
            onSubmit: function () {
            },
            success: function (data) {
                $("#dg").datagrid("reload");
                $("#dd").window("close")
            }
        });
    }

    //修改
    function xiugai(index) {
        $('#dd').window('open');  // open a window
        $('#dg').datagrid('selectRow', index);
        var row = $('#dg').datagrid('getSelected', index);
        $('#ff').form('load', row);//form表单回显
        $('#ff').form('load', {
            pid: row.xian
        });//form表单回显
    }

    //详情
    function look(index) {
        $('#dd').window('open');  // open a window
        $('#dg').datagrid('selectRow', index);
        var row = $('#dg').datagrid('getSelected', index);
        $('#ff').form('load', row);//form表单回显
        $('#ff').form('load', {
            pid: row.xian
        });//form表单回显
    }


</script>
</html>
