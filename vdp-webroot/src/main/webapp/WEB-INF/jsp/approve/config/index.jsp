<!-- userlist.jsp -->

<!--<%@ page language="java" pageEncoding="UTF-8"%>-->
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>

<head>
    <title>金盾VDP</title>
    <link href="${ctxCss}/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <!--<link href="${ctxCss}/ztree/ztree.css" rel="stylesheet" type="text/css"/>-->
    <link href="${ctxCss}/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxCss}/dataTables/dataTablesgray.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxCss}/approve/config/index.css" rel="stylesheet" type="text/css"/>
</head>

<div class="main_right">
    <div class="top-bar">
        <div class="top-title">流程请求</div>
    </div>
    <div class="content-box">
        <ul class="titleTab" id="titleTabul">
            <li class="processset titleTabactive" data-class="process">审批中</li>
            <li class="complateset" data-class="complate">已完成</li>
        </ul>
        <div class="main-contentall">
            <div class="processcon">
                <div class="processtop">
                    <div class="left">
                        <div class="beauty-checkbox">
                            <input id="onlyProcess" name="onlyProcess" type="checkbox" class="" value="1">
                            <label for="onlyProcess" class="checkbox-icon"></label>
                        </div>
                        <span>只看需审批</span>
                    </div>
                    <div class="right bar-item-box">
                        <div class="bar-item bar-item-search wind-content">
                            <input type="text" class="wind-content-input wind-content-input-date valid" name="" readonly="" aria-invalid="false" id="timechange">
                        </div>
                        <div class="bar-item bar-item-search">
                            <input id="bar_searchstr" type="text" placeholder="提交人">
                            <i id="bar_searchstr_icon" class="iconfont icon-btn-serch"></i>
                        </div>
                    </div>

                </div>
                <div class="processshow">
                    <table id="processTable" cellspacing="0" cellpadding="0" border="0" width="100%">
                        <thead>
                        <tr>
                            <th>流程名称</th>
                            <th>审批类型</th>
                            <th>提交人</th>
                            <th>当前环节</th>
                            <th>提交时间</th>
                            <th style="text-align:center;">操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
            <!--<div class="complatecon none">-->
            <!--<div class="processtop">-->
            <!--<div class="left">-->
            <!--<a id="bar_del_process" class="bar-item bar-item-icon iconfont icon-btn-delete" title="删除流程"></a>-->
            <!--</div>-->
            <!--<div class="right bar-item-box">-->
            <!--<div class="bar-item bar-item-search wind-content">-->
            <!--<input type="text" class="wind-content-input wind-content-input-date valid" name="" readonly="" aria-invalid="false" id="timechange">-->
            <!--</div>-->
            <!--<div class="bar-item bar-item-search">-->
            <!--<input id="bar_searchstr" type="text" placeholder="提交人">-->
            <!--<i id="bar_searchstr_icon" class="iconfont icon-btn-serch"></i>-->
            <!--</div>-->
            <!--</div>-->

            <!--</div>-->
            <!--<div class="processshow">-->
            <!--<table id="processTable" cellspacing="0" cellpadding="0" border="0" width="100%">-->
            <!--<thead>-->
            <!--<tr>-->
            <!--<th>流程名称</th>-->
            <!--<th>审批类型</th>-->
            <!--<th>提交人</th>-->
            <!--<th>当前环节</th>-->
            <!--<th>提交时间</th>-->
            <!--<th style="text-align:center;">操作</th>-->
            <!--</tr>-->
            <!--</thead>-->
            <!--</table>-->
            <!--</div>-->
            <!--</div>-->

        </div>
    </div>
</div>
<div id="add_user_wind" class="none">

</div>
<script id="temp_opt_box" type="text/html">
    <div class="table-opt-box">
        <i class="iconfont icon-nav-system table-opt-icon"></i>
        <div class="opt-hover-box">
            <div class="opt-hover-row j-opt-hover-detail" data-id="{{id}}">
                <i class="iconfont icon-btn-edit text-sm"></i>
                <span class="text-sm margin-left-xs">查看详情</span>
            </div>
            <div class="opt-hover-row j-opt-hover-delete" data-id="{{id}}">
                <i class="iconfont icon-btn-delete text-sm"></i>
                <span class="text-sm margin-left-xs">删除</span>
            </div>
        </div>
    </div>
</script>
<script id="approve_wind" type="text/html">
    <div class="top">

    </div>
    <div class="flow">
        <div class="wind-row">
            <label class="wind-label flowTitle">审批流程</label>
            <div class="flowContent">
                <label class="begin" for="">
                    <div class="begin_bar">
                        <label for=""></label>
                        <span>开始</span>
                    </div>
                    <div class="flow_line">

                    </div>
                </label>
                <label class="default" for="">
                    <div class="default_bar">
                        <label for=""></label>
                        <span>开始</span>
                    </div>
                    <div class="flow_line">

                    </div>
                </label>
                <label class="end" for="">
                    <div class="end_bar">
                        <label for=""></label>
                        <span>结束</span>
                    </div>
                </label>
            </div>
        </div>
    </div>
    <div class="opinion">
        <div class="wind-row">
            <label class="wind-label">审批意见</label>
            <input id="agree" value="1" type="radio" name="approveIdea"/>
            <label for="agree" class="margin-right-xl">通过</label>
            <input id="reject" value="0" type="radio" name="approveIdea"/>
            <label for="reject">驳回</label>
        </div>
        <div class="wind-row">
            <label class="wind-label">备注</label>
            <textarea name="textarea" id="textarea"></textarea>
        </div>

    </div>
    <div class="table">
        <div class="wind-row">
            <label class="wind-label">审批历史</label>
            <div class="approveHistory">
                <table id="approveHistoryTable" cellspacing="0" cellpadding="0" border="0" width="100%">
                    <thead>
                    <tr>
                        <th>审批人</th>
                        <th>审批结果</th>
                        <th>备注</th>
                        <th>审批时间</th>
                    </tr>
                    </thead>
                </table>
            </div>

        </div>
    </div>
</script>
<script id="approve_tem_out_top" type="text/html">
    <div class="title">文件外发申请详情</div>
    <div class="content">
        <div class="left">
            <label for="" class="dig">摘要：</label><a href=""><i class="iconfont icon-btn-review"></i></a>
            <label for="">接收方信息：XXXXXX</label>
            <label for="">禁止截屏：XXXXXX</label>
            <label for="">外发原因：{{reason}}</label>
        </div>
        <div class="right">
            <label for="">申请人：{{applicantName}}</label>
            <label for="">打开次数：4次，未启动自动删除</label>
            <label for="">机器码绑定：XXXXXX</label>
            <label for="">有效日期：20171.1-20171.2</label></div>
    </div>
</script>
<script id="approve_tem_export_top" type="text/html">
    <div class="title">文件导出申请详情</div>
    <div class="content">
        <div class="left">
            <label for="" class="dig">摘要：</label><a href=""><i class="iconfont icon-btn-review"></i></a>
            <label for="">接收方信息：XXXXXX</label>
            <label for="">申请人：{{applicantName}}</label>
            <label for="">导出原因：{{reason}}</label>
        </div>
        <div class="right">
            <!--<label for="">申请人：XXXXXX</label>-->
            <!--<label for="">打开次数：4次，未启动自动删除</label>-->
            <!--<label for="">机器码绑定：XXXXXX</label>-->
            <!--<label for="">有效日期：20171.1-20171.2</label></div>-->
    </div>
</script>
<script id="temp_approve" type="text/html">
    {{if type == 1}}
    <!--1是导出-->
    <i class="iconfont icon-nav-system approve-opt-icon" title="导出" data-id="{{id}}" data-type="{{type}}" data-is="{{isa}}"></i>
    {{else if type == 0}}
    <i class="iconfont icon-menu-user approve-opt-icon" title="外发" data-id="{{id}}" data-type="{{type}}" data-is="{{isa}}"></i>
    {{/if}}
</script>
<!--<script src="${ctxJs}/plugins/echarts/echarts.common.min.js"></script>-->
<script src="${ctxJs}/plugins/dataTables/jquery.dataTables.min.js"></script>
<script src="${ctxJs}/plugins/template/template-web.js"></script>
<!--<script src="${ctxJs}/plugins/ueditor/ueditor.config.js"></script>-->
<!--<script src="${ctxJs}/plugins/ueditor/ueditor.all.js"></script>-->
<!--<script src="${ctxJs}/plugins/jquery.PrintArea/jquery.PrintArea.js"></script>-->
<script src="${ctxJs}/plugins/validate/jquery.validate.js"></script>
<script src="${ctxJs}/plugins/validate/messages_zh.js"></script>
<script src="${ctxJs}/plugins/validate/validateExtent.js"></script>
<script src="${ctxJs}/plugins/bootstrap/bootstrap.min.js" type="text/javascript"></script>
<!--<script src="${ctxJs}/plugins/zTree/jquery.ztree.core-3.5.js" type="text/javascript"></script>-->
<!--<script src="${ctxJs}/plugins/zTree/jquery.ztree.excheck-3.5.js" type="text/javascript"></script>-->
<script src="${ctxJs}/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${ctxJs}/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>

<script src="${ctxJs}/approve/config/index.js"></script>
<script>
  var ctx = "${ctx}";


</script>