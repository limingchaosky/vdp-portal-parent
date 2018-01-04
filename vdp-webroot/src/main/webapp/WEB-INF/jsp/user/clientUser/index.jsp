<!--<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>-->

<head>
    <title>用户</title>
    <link href="${ctxCss}/dataTables/dataTablesgray.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxCss}/ztree/ztree.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxCss}/user/clientUser/index.css" rel="stylesheet" type="text/css"/>
</head>
<div class="main-right">
    <!--左侧部门树-->
    <div class="left-bar">
        <div class="top-bar">
            <div class="top-title">用户</div>
        </div>
        <div class="left-content">
            <ul id="dept_tree" class="deptTree ztree"></ul>
        </div>
    </div>
    <!--左侧部门树结束-->
    <div class="right-content-box">
        <!--右侧顶部操作-->
        <div class="right-content-top">
            <div class="bar-item-box">
                <div class="bar-item bar-item-search">
                    <input id="bar_searchstr" type="text" placeholder="用户名/IP地址">
                    <i id="bar_searchstr_icon" class="iconfont icon-btn-serch"></i>
                </div>
                <a id="bar_add_user" class="bar-item bar-item-icon iconfont icon-btn-add" title="添加用户"></a>
                <a id="bar_policy_user" class="bar-item bar-item-icon iconfont icon-btn-edit" title="批量修改策略"></a>
                <a id="bar_import" class="bar-item bar-item-icon iconfont icon-btn-import1" title="导入"></a>
                <a id="bar_export" class="bar-item bar-item-icon iconfont icon-btn-export1" title="导出"></a>
                <a id="bar_relieve" class="bar-item bar-item-icon iconfont icon-btn-remove" title="解绑UKey"></a>
            </div>
        </div>
        <!--右侧顶部操作结束-->
        <div class="right-content">
            <!--用户表-->
            <div class="dept-table-box">
                <table id="user_table" cellspacing="0" cellpadding="0" border="0" width="100%">
                    <thead>
                    <tr>
                        <th class="text-center">
                            <div class="beauty-checkbox">
                                <input id="check_user_all" type="checkbox" class="j-check-user-all">
                                <label for="check_user_all" class="checkbox-icon"></label>
                            </div>
                        </th>
                        <th>用户名</th>
                        <th>真实姓名</th>
                        <th>终端策略</th>
                        <th>IP地址</th>
                        <th style="text-align:center;">操作</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <!--用户表结束-->
        </div>
    </div>
</div>
<!--添加用户弹窗-->
<div id="add_user_wind" class="none">
    <div class="wind-box">
        <form class="padding-normal j-add-user-form">
            <div class="wind-row cf">
                <label for="" class="wind-label label-required">用户名</label>
                <input type="text" class="form-input wind-normal-input" name="username" maxlength="20">
            </div>
            <div class="wind-row cf">
                <label for="" class="wind-label label-required">真实姓名</label>
                <input type="text" class="form-input wind-normal-input" name="truename" maxlength="20">
            </div>
            <div class="wind-row cf">
                <label for="" class="wind-label label-required">用户密码</label>
                <input type="password" id="pass" class="form-input wind-normal-input" name="password" maxlength="20">
            </div>
            <div id="level" class="pw-strength">
                <div class="pw-bar"></div>
                <div class="pw-bar-on"></div>
                <div class="pw-txt"></div>
            </div>
            <div class="wind-row cf">
                <label for="" class="wind-label label-required">确认密码</label>
                <input type="password" class="form-input wind-normal-input" name="repassword" maxlength="20">
            </div>
            <div class="wind-row cf">
                <label for="" class="wind-label label-required">所属部门</label>
                <input type="text" class="form-input wind-normal-input parent-dept" readonly name="parentdept" placeholder="请选择所属部门">
                <div class="parent-dept-tree-box none">
                    <ul class="ztree j-parent-dept-tree"></ul>
                </div>
            </div>
            <div class="wind-row cf">
                <label for="" class="wind-label label-required">采用策略</label>
                <select class="wind-input" name="selectPolicy"></select>
            </div>
            <div class="wind-row cf">
                <label for="" class="wind-label">USBKey</label>
                <select class="wind-input" name="usbKeyList"></select>
                <!--<div class="parent-dept-tree-box none">-->
                <!--<ul class="ztree j-parent-dept-tree2"></ul>-->
                <!--</div>-->
            </div>
        </form>
    </div>
</div>
<!--添加用户弹窗结束-->
<!--用户表操作模板-->
<script id="temp_opt_box" type="text/html">
    <div class="table-opt-box">
        <i class="iconfont icon-nav-system table-opt-icon"></i>
        <div class="opt-hover-box">
            <div class="opt-hover-row j-opt-hover-edit" data-id="{{id}}">
                <i class="iconfont icon-btn-edit text-sm"></i>
                <span class="text-sm margin-left-xs">编辑</span>
            </div>
            <div class="opt-hover-row j-opt-hover-delete" data-id="{{id}}">
                <i class="iconfont icon-btn-delete text-sm"></i>
                <span class="text-sm margin-left-xs">删除</span>
            </div>
            <!--<div class="opt-hover-row j-opt-hover-diypolicy" data-id="{{id}}">-->
                <!--<i class="iconfont icon-menu-user text-sm"></i>-->
                <!--<span class="text-sm margin-left-xs">个性化策略</span>-->
            <!--</div>-->
            <div class="opt-hover-row j-opt-hover-remove" data-id="{{id}}">
                <i class="iconfont icon-btn-remove text-sm"></i>
                <span class="text-sm margin-left-xs">解绑UKey</span>
            </div>
        </div>
    </div>
</script>
<script id="temp_policy" type="text/html">
    <select class="wind-input valid temp_policy" name="userSelectPolicy" aria-invalid="false">

    </select>
</script>
<!--部门表操作模板结束-->
<script src="${ctxJs}/plugins/dataTables/jquery.dataTables.min.js"></script>
<!--<script src="${ctxJs}/plugins/dataTables/ColReorderWithResize.min.js"></script>-->
<script src="${ctxJs}/plugins/zTree/jquery.ztree.core-3.5.js" type="text/javascript"></script>
<script src="${ctxJs}/plugins/zTree/jquery.ztree.excheck-3.5.js" type="text/javascript"></script>
<script src="${ctxJs}/plugins/template/template-web.js" type="text/javascript"></script>
<script src="${ctxJs}/user/clientUser/index.js"></script>
<script>
  var zNodes = JSON.parse('${zNodes}');
</script>