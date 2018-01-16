<!--userlist.jsp -->
<!-- <%@ page language="java" pageEncoding="UTF-8"%>-->
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>

<head>
    <title>金盾VDP</title>
    <link href="${ctxCss}/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <!--<link href="${ctxCss}/ztree/ztree.css" rel="stylesheet" type="text/css"/>-->
    <link href="${ctxCss}/approve/flow/index.css" rel="stylesheet" type="text/css"/>
</head>
<div class="main-right">
    <!--角色列表-->
    <div class="left-bar">
        <div class="top-bar">
            <div class="top-title">审批流程配置</div>
            <div class="bar-item-box">
                <a id="bar_add_flow" class="bar-item bar-item-icon iconfont icon-btn-add margin-right-sm" title="添加"></a>
            </div>
        </div>
        <div id="left_content_box" class="left-content-box">
            <ul id="flow_list_box" class="flow-list-box">

            </ul>
        </div>
    </div>
    <!--角色列表结束-->
    <div class="right-content-box">
        <!--内容区头部-->
        <div class="right-content-top">
        </div>
        <!--内容区头部结束-->
        <div class="right-content">
            <div id="approveFlow_box" class="approveFlow_box">

            </div>
        </div>
    </div>
</div>
<script id="new_flow" type="text/html">
    <div class="wind-row">
        <label for="" class="wind-label label-required">流程名</label>
        <input type="text" class="form-input wind-normal-input" name="flowname" maxlength="20">
        <span class="flowTip error none" id="flowTip">流程名不能为空</span>
    </div>
    <div class="wind-row">
        <label for="" class="wind-label label-required">继承自</label>
        <select class="wind-input valid" name="userSelectFlow" aria-invalid="false">

        </select>
    </div>

</script>
<script id="flow_list" type="text/html">
    {{each $data item}}
    <li class="left-list" data-id="{{item.id}}">
        <span class="list-name">{{item.name}}</span>
        <i class="iconfont icon-btn-close list-del" data-id="{{item.id}}" title="删除"></i>
    </li>
    {{/each}}
</script>
<script src="${ctxJs}/plugins/zTree/jquery.ztree.core-3.5.js" type="text/javascript"></script>
<script src="${ctxJs}/plugins/zTree/jquery.ztree.excheck-3.5.js" type="text/javascript"></script>
<script src="${ctxJs}/plugins/template/template-web.js" type="text/javascript"></script>
<script src="${ctxJs}/approve/flow/index.js"></script>
<script type="text/javascript">
  var ctx = '${ctx}';
</script>