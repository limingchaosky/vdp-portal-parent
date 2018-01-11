<!-- userlist.jsp -->

<!--<%@ page language="java" pageEncoding="UTF-8"%>-->
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>

<head>
    <title>金盾VDP</title>
    <!--<link href="${ctxCss}/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css" />-->
    <link href="${ctxCss}/access/index.css" rel="stylesheet" type="text/css"/>
    <!--<link href="${ctxCss}/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />-->
    <!--<link href="${ctxCss}/workorder/pending/index.css" rel="stylesheet" type="text/css" />-->
</head>

<div class="main_right">
    <div class="top-bar">
        <div class="top-title">准入</div>
    </div>
    <div class="content-box">
        <div class="add-server-box" id="access-form">
            <form>
                <div class="item-row padding-xs">
                    <label class="wind-label">防护状态</label>
                    <div class="beauty-switch">
                        <input id="onoff" name="onoff" checked type="checkbox" value="1">
                        <label for="onoff" class="switch-icon onoff"></label>
                    </div>
                </div>
                <div class="item-row padding-xs">
                    <label class="wind-label">Mac地址</label>
                    <input class="wind-input requierd" type="text" name="nacMac" placeholder="例如：FF:FF:FF:FF:FF:FF">
                    <span class="error-text"></span>
                </div>
                <div class="item-row padding-xs">
                    <label class="wind-label">跳转地址</label>
                    <input class="wind-input requierd" type="text" name="nacUrl" placeholder="例如：http://www.neiwang.cn">
                    <span class="error-text"></span>
                </div>
                <div class="item-row padding-xs">
                    <span class="mustlabel none">*</span>
                    <label class="wind-label">准入控制网段</label>
                    <input class="wind-input requierd" type="text" name="ctrlAreas" placeholder="例如：1.1.1.1或1.1.1.1-1.1.1.9">
                    <i class="iconfont icon-btn-add add-ctrl-area"></i>
                    <span class="error-text"></span>
                    <div class="append-box ctrl-area"></div>
                </div>
                <div class="item-row padding-xs">
                    <label class="wind-label label-norequire">白名单IP</label>
                    <input class="wind-input" type="text" name="legalIps" placeholder="例如：1.1.1.1或1.1.1.1-1.1.1.9">
                    <i class="iconfont icon-btn-add add-legal-ip"></i>
                    <span class="error-text"></span>
                    <div class="append-box legal-ip"></div>
                </div>
                <div class="item-row padding-xs">
                    <label class="wind-label label-norequire">白名单端口</label>
                    <input class="wind-input" type="text" name="legalPorts" placeholder="0~65535之间的整数">
                    <i class="iconfont icon-btn-add add-legal-port"></i>
                    <span class="error-text"></span>
                    <div class="append-box legal-port"></div>
                </div>
                <div class="item-row padding-xs">
                    <label class="wind-label">WEB重定向端口</label>
                    <input class="wind-input" type="text" name="httpPorts" placeholder="0~65535之间的整数">
                    <i class="iconfont icon-btn-add add-http-port"></i>
                    <span class="error-text"></span>
                    <div class="append-box http-port"></div>
                </div>
                <!--<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>-->
                <!--<input type="hidden" name="nacServer" value=""/>-->
            </form>
        </div>
    </div>
</div>
<div class="save">
    <div class="access-save">
        <span>保存</span>
    </div>
</div>
<!--<script id="accessTem" type="text/html">-->
    <!--<form>-->
        <!--<div class="item-row padding-xs">-->
            <!--<label class="wind-label">防护状态</label>-->
            <!--<div class="beauty-switch">-->
                <!--<input id="onoff" name="onoff" {{if $data.}}checked type="checkbox" value="1">-->
                <!--<label for="onoff" class="switch-icon onoff"></label>-->
            <!--</div>-->
        <!--</div>-->
        <!--<div class="item-row padding-xs">-->
            <!--<label class="wind-label">Mac地址</label>-->
            <!--<input class="wind-input requierd" type="text" name="nacMac" placeholder="例如：FF:FF:FF:FF:FF:FF">-->
            <!--<span class="error-text"></span>-->
        <!--</div>-->
        <!--<div class="item-row padding-xs">-->
            <!--<label class="wind-label">跳转地址</label>-->
            <!--<input class="wind-input requierd" type="text" name="nacUrl" placeholder="例如：http://www.neiwang.cn">-->
            <!--<span class="error-text"></span>-->
        <!--</div>-->
        <!--<div class="item-row padding-xs">-->
            <!--<span class="mustlabel none">*</span>-->
            <!--<label class="wind-label">准入控制网段</label>-->
            <!--<input class="wind-input requierd" type="text" name="ctrlAreas-x" placeholder="例如：1.1.1.1或1.1.1.1-1.1.1.9">-->
            <!--<i class="iconfont icon-btn-add add-ctrl-area"></i>-->
            <!--<span class="error-text"></span>-->
            <!--<div class="append-box ctrl-area"></div>-->
        <!--</div>-->
        <!--<div class="item-row padding-xs">-->
            <!--<label class="wind-label label-norequire">白名单IP</label>-->
            <!--<input class="wind-input" type="text" name="legalIps-x" placeholder="例如：1.1.1.1或1.1.1.1-1.1.1.9">-->
            <!--<i class="iconfont icon-btn-add add-legal-ip"></i>-->
            <!--<span class="error-text"></span>-->
            <!--<div class="append-box legal-ip"></div>-->
        <!--</div>-->
        <!--<div class="item-row padding-xs">-->
            <!--<label class="wind-label label-norequire">白名单端口</label>-->
            <!--<input class="wind-input" type="text" name="legalPorts-x" placeholder="0~65535之间的整数">-->
            <!--<i class="iconfont icon-btn-add add-legal-port"></i>-->
            <!--<span class="error-text"></span>-->
            <!--<div class="append-box legal-port"></div>-->
        <!--</div>-->
        <!--<div class="item-row padding-xs">-->
            <!--<label class="wind-label">WEB重定向端口</label>-->
            <!--<input class="wind-input" type="text" name="httpPorts-x" placeholder="0~65535之间的整数">-->
            <!--<i class="iconfont icon-btn-add add-http-port"></i>-->
            <!--<span class="error-text"></span>-->
            <!--<div class="append-box http-port"></div>-->
        <!--</div>-->
        <!--&lt;!&ndash;<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>&ndash;&gt;-->
        <!--&lt;!&ndash;<input type="hidden" name="nacServer" value=""/>&ndash;&gt;-->
    <!--</form>-->
<!--</script>-->
<!--<script src="${ctxJs}/plugins/echarts/echarts.common.min.js"></script>-->
<script src="${ctxJs}/plugins/template/template-web.js"></script>
<!--<script src="${ctxJs}/plugins/ueditor/ueditor.config.js"></script>-->
<!--<script src="${ctxJs}/plugins/ueditor/ueditor.all.js"></script>-->
<!--<script src="${ctxJs}/plugins/jquery.PrintArea/jquery.PrintArea.js"></script>-->
<script src="${ctxJs}/plugins/validate/jquery.validate.js"></script>
<script src="${ctxJs}/validateExtent.js"></script>
<script src="${ctxJs}/plugins/bootstrap/bootstrap.min.js" type="text/javascript"></script>
<!--<script src="${ctxJs}/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>-->
<!--<script src="${ctxJs}/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>-->
<script src="${ctxJs}/public.js"></script>
<script src="${ctxJs}/access/index.js"></script>
<script>
    var accessObj = '${config}';
    console.log(accessObj);
</script>