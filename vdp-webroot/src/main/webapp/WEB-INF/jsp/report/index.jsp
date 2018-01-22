<!-- userlist.jsp -->

<!--<%@ page language="java" pageEncoding="UTF-8"%>-->
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>

<head>
    <title>金盾VDP</title>
    <link href="${ctxCss}/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxCss}/report/index.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxCss}/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
    <!--<link href="${ctxCss}/workorder/pending/index.css" rel="stylesheet" type="text/css" />-->
    <link href="${ctxCss}/dataTables/dataTablesgray.css" rel="stylesheet" type="text/css"/>
</head>

<div class="main_right">
    <div class="top-bar">
        <div class="top-title">报表</div>
        <div class="bar-item-box">
            <select id="bar_JKDWLX" class="bar-item bar-item-select">
                <option value="">全部流转类型</option>
                <option value="1">自主导出</option>
                <option value="2">自主外发</option>
                <option value="3">审批外发</option>
                <option value="4">审批导出</option>
                <option value="9">其他</option>
            </select>
            <div class="bar-item bar-item-dropdown dropdown-tree-box">
                <input id="bar_sbcs" class="dropdown-input" type="text" value="" readonly placeholder="请选择部门">
                <ul id="department_tree" class="dropdown-tree ztree"></ul>
            </div>
            <div class="bar-item bar-item-search wind-content">
                <input type="text" class="wind-content-input wind-content-input-date valid" name="azsj" readonly="" aria-invalid="false" id="timechange">
            </div>
            <div class="bar-item bar-item-search">
                <input id="bar_searchstr" type="text" placeholder="">
                <i id="bar_searchstr_icon" class="iconfont icon-btn-search1"></i>
            </div>
        </div>
    </div>
    <div class="content-box">
        <div class="cell-top">
            <div id="exportReport"></div>
        </div>
        <div class="cell-bottom">
            <div class="" id="exportList">
                <table id="exportListTable" width="100%" cellSpacing="0" cellPadding="0" border="0">
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
        </div>
    </div>
</div>

<script src="${ctxJs}/plugins/echarts/echarts.common.min.js"></script>
<!--<script src="${ctxJs}/plugins/template/template-web.js"></script>-->
<!--<script src="${ctxJs}/plugins/ueditor/ueditor.config.js"></script>-->
<!--<script src="${ctxJs}/plugins/ueditor/ueditor.all.js"></script>-->
<!--<script src="${ctxJs}/plugins/jquery.PrintArea/jquery.PrintArea.js"></script>-->
<!--<script src="${ctxJs}/plugins/validate/jquery.validate.js"></script>-->
<!--<script src="${ctxJs}/validateExtent.js"></script>-->
<script src="${ctxJs}/plugins/bootstrap/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctxJs}/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${ctxJs}/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctxJs}/report/index.js"></script>