<!--userlist.jsp -->
<!-- <%@ page language="java" pageEncoding="UTF-8"%>-->
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>

<head>
    <title>金盾VDP</title>
    <link href="${ctxCss}/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxCss}/ztree/ztree.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxCss}/approve/flow/index.css" rel="stylesheet" type="text/css"/>
</head>
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
        <div class="default_bar default_bar_hover">
            <label for=""></label>
            <span>默认</span>
            <span>标准模式</span>
            <img src="${ctx}/skin/default/images/approve/arrow-top.png" class="none" alt=""/>
        </div>
        <div class="flow_line">
            <i class="iconfont icon-btn-add flow_add"></i>
        </div>
        <div class="approve_con none">
            <div class="top-bar">
                <div class="top-title">默认111</div>
                <div class="bar-item-box">
                    <a class="bar-item bar-item-icon iconfont icon-btn-delete margin-right-sm bar_delete_flow" title="删除" data-stepid=""></a>
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
                        <span class="wind-span text-ellipsis">系统内置管理员 <i class="iconfont icon-btn-close hum_del" data-guid=""></i></span>
                        <span class="wind-span text-ellipsis">系统内置管理员</span>
                        <span class="wind-span text-ellipsis">系统内置管理员</span>
                        <a class="bar-item bar-item-icon iconfont icon-btn-add margin-right-sm bar_add_hum" title="添加"></a>
                    </div>
                </div>
                <div class="wind-row cf">
                    <div class="save-button">保存</div>
                    <div class="cancel-button">取消</div>
                </div>
            </div>
        </div>
    </label>


    <label class="end" for="">
        <div class="end_bar">
            <label for=""></label>
            <span>结束</span>
        </div>
    </label>
</div>
<script id="treeLayer" type="text/html">
    <div id="treeview" class="ztree">

    </div>
</script>
<script id="humlist" type="text/html">
    {{each $data item}}
  <span class="wind-span text-ellipsis">{{item.name}}<i class="iconfont icon-btn-close hum_del" data-guid="{{item.guid}}"></i></span>

    <a class="bar-item bar-item-icon iconfont icon-btn-add margin-right-sm bar_add_hum" title="添加"></a>
</script>
<script src="${ctxJs}/plugins/zTree/jquery.ztree.core-3.5.js" type="text/javascript"></script>
<script src="${ctxJs}/plugins/zTree/jquery.ztree.excheck-3.5.js" type="text/javascript"></script>
<script src="${ctxJs}/plugins/template/template-web.js" type="text/javascript"></script>
<script src="${ctxJs}/approve/flow/detail.js"></script>
<script>
//    var flowId =
    console.log('${definition}')
    console.log('${modelList}')
</script>
