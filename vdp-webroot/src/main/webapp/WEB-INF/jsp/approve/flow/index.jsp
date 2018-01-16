<!--userlist.jsp -->
<!-- <%@ page language="java" pageEncoding="UTF-8"%>-->
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>

<head>
    <title>金盾VDP</title>
    <link href="${ctxCss}/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxCss}/ztree/ztree.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxCss}/approve/flow/index.css" rel="stylesheet" type="text/css"/>
    <!--<link href="${ctxCss}/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />-->
    <!--<link href="${ctxCss}/workorder/pending/index.css" rel="stylesheet" type="text/css" />-->
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
                <!--<li class="left-list" data-id="{{$value.id}}">-->
                    <!--<span class="list-name">测试的审批流程</span>-->
                    <!--<i class="iconfont icon-btn-close list-del" data-id="{{$value.id}}" title="删除"></i>-->
                <!--</li>-->
                <!--<li class="left-list" data-id="{{$value.id}}">-->
                    <!--<span class="list-name">测试的审批流程2</span>-->
                    <!--<i class="iconfont icon-btn-close list-del" data-id="{{$value.id}}" title="删除"></i>-->
                <!--</li>-->
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
                <div class="approve_start">
                    <label class="begin" for="">
                        <div class="begin_bar">
                            <label for=""></label>
                            <span>开始</span>
                        </div>
                        <div class="flow_line">
                            <i class="iconfont icon-btn-add flow_add"></i>
                        </div>
                    </label>
                    <label class="default" for="">
                        <div class="default_bar">
                            <label for=""></label>
                            <span>默认</span>
                            <span>标准模式</span>
                            <img src="${ctx}/skin/default/images/approve/arrow-top.png" alt=""/>
                        </div>
                        <div class="flow_line">
                            <i class="iconfont icon-btn-add flow_add"></i>
                        </div>
                        <div class="approve_con">
                            <div class="top-bar">
                                <div class="top-title">默认</div>
                                <div class="bar-item-box">
                                    <a id="bar_delete_flow" class="bar-item bar-item-icon iconfont icon-btn-delete margin-right-sm" title="添加"></a>
                                </div>
                            </div>
                            <div class="content">
                                <div class="wind-row cf">
                                    <label for="" class="wind-label-max label-required">环节名称</label>
                                    <input type="text" class="form-input wind-normal-input-max" name="stepname" maxlength="20">
                                </div>
                                <div class="wind-row cf">
                                    <label for="" class="wind-label-max label-required">审批模式</label>
                                    <div class="mode">
                                        <input id="stand" type="radio" name="mode" value="0"/>
                                        <label for="stand">标准模式</label>
                                        <div class="tips">
                                            <span>?</span>
                                            <div class="tips_con none">任何人审批通过，即可进入下一环节，若有一人拒绝，则该审批请求结束</div>
                                        </div>
                                    </div>
                                    <div class="mode">
                                        <input id="strict" type="radio" name="mode" value="1"/>
                                        <label for="strict">严格模式</label>
                                        <div class="tips">
                                            <span>?</span>
                                            <div class="tips_con none">所有人审批通过，即可进入下一环节，若有一人拒绝，则该审批请求结束</div>
                                        </div>
                                    </div>

                                </div>
                                <div class="wind-row cf">
                                    <label for="" class="wind-label-max label-required">审批人</label>
                                    <div class="approve_h">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </label>

                    <label class="default" for="">
                        <div class="default_bar">
                            <label for=""></label>
                            <span>默认</span>
                            <span>严格模式</span>
                        </div>
                        <div class="flow_line">
                            <i class="iconfont icon-btn-add flow_add"></i>
                        </div>
                        <div class="approve_con none">
                            222222222222222222
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