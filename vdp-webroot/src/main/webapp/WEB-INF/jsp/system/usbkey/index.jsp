<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>

<head>
    <title>金盾VDP</title>
    <link href="${ctxCss}/dataTables/dataTablesgray.css" rel="stylesheet" type="text/css"/>
    <!--<link href="${ctxCss}/ztree/ztree.css" rel="stylesheet" type="text/css" />-->
    <link href="${ctxCss}/system/usbkey/index.css" rel="stylesheet" type="text/css"/>
</head>
<div class="main-right">
    <!--内容区头部-->
    <div class="top-bar">
        <div class="top-title">USBKey库</div>
        <div class="bar-item-box">
            <div class="bar-item bar-item-search">
                <input id="bar_searchstr" type="text" placeholder="">
                <i id="bar_searchstr_icon" class="iconfont icon-btn-search1"></i>
            </div>
            <a id="bar_add_user" class="bar-item bar-item-icon icon-add" title="添加"></a>
            <a id="bar_del_user" class="bar-item bar-item-icon icon-delete" title="删除"></a>
            <a id="bar_export_user" class="bar-item bar-item-icon icon-export" title="导出"></a>
        </div>
    </div>
    <!--内容区头部结束-->
    <!--内容区-表格-->
    <div class="content-box">
        <table id="userTable" cellspacing="0" cellpadding="0" border="0" width="100%">
            <thead>
            <tr>
                <th class="text-center">
                    <div class="beauty-checkbox">
                        <input id="check_user_all" type="checkbox" class="j-check-user-all">
                        <label for="check_user_all" class="checkbox-icon"></label>
                    </div>
                </th>
                <th>账户名称</th>
                <th>管辖部门</th>
                <th>角色</th>
                <th>真实姓名</th>
                <th>警员号</th>
                <th>电话</th>
                <th>邮箱</th>
                <th style="text-align:center;">操作</th>
            </tr>
            </thead>
        </table>
    </div>
    <!--内容区-表格结束-->
</div>
<!--添加usbkey库-->
<div id="add_user_wind" class="none">
    <div class="wind-box">
        <form class="padding-vertical-normal j-add-user-form">
            <div class="wind-row cf">
                <div class="wind-cell">
                    <label for="" class="wind-label label-required">账户名</label>
                    <input type="text" class="wind-input" tabindex="1" name="userName" maxlength="20">
                </div>
                <div class="wind-cell">
                    <label for="" class="wind-label label-required">真实姓名</label>
                    <input type="text" class="wind-input" tabindex="4" name="realName" maxlength="20">
                </div>
            </div>
            <div class="wind-row cf">
                <div class="wind-cell">
                    <label for="" class="wind-label">密码</label>
                    <input type="password" class="wind-input" tabindex="2" name="password" minlength="6" maxlength="20">
                </div>
                <div class="wind-cell">
                    <label for="" class="wind-label label-required">警员号</label>
                    <input type="text" class="wind-input" tabindex="5" name="constableNumber" maxlength="6">
                </div>
            </div>
            <div class="wind-row cf">
                <div class="wind-cell">
                    <label for="" class="wind-label">确认密码</label>
                    <input type="password" class="wind-input" tabindex="3" name="repassword" minlength="6" maxlength="20">
                </div>
                <div class="wind-cell">
                    <label for="" class="wind-label label-required">电话</label>
                    <input type="text" class="wind-input" tabindex="5" name="phone">
                </div>
            </div>
            <div class="wind-row cf">
                <div class="wind-cell">
                    <label for="" class="wind-label label-required">管理角色</label>
                    <select class="wind-input" name="roleType"></select>
                </div>
                <div class="wind-cell">
                    <label for="" class="wind-label">邮箱</label>
                    <input type="text" class="wind-input" tabindex="6" name="email" maxlength="30">
                </div>
            </div>
            <input type="hidden" class="j-user-info" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        <div class="dept-box">
            <div class="dept-title">部门权限</div>
            <div class="tree-box">
                <ul class="deptTree ztree"></ul>
            </div>
        </div>
    </div>
</div>
<!--添加usbkey库结束-->
<!--usbkey库表的操作模板-->
<script id="temp_opt_box" type="text/html">
    <div class="table-opt-box">
        <i class="icon-setting table-opt-icon"></i>
        <div class="opt-hover-box">
            <div class="opt-hover-row j-opt-hover-edit" data-id="{{id}}">
                <i class="icon-bianji"></i>
                <span class="text-sm margin-left-xs">编辑</span>
            </div>
            <div class="opt-hover-row j-opt-hover-delete" data-id="{{id}}">
                <i class="icon-shanchu"></i>
                <span class="text-sm margin-left-xs">删除</span>
            </div>
        </div>
    </div>
</script>
<!--usbkey库表的操作模板结束-->
<!-- usbkey库详情 -->
<script type="text/html" id="temp_user_info">
    <div class="padding-horizontal-xxl padding-vertical-sm">
        <div class="detail-info-box">
            <div class="cf">
                <div class="detail-info-item">
                    <label class="detail-info-label">账户名称：</label>
                    <span class="detail-info-value">{{@userName}}</span>
                </div>
                <div class="detail-info-item">
                    <label class="detail-info-label">角色：</label>
                    <span class="detail-info-value">{{@roleNmae}}</span>
                </div>
            </div>
            <div class="cf">
                <div class="detail-info-item">
                    <label class="detail-info-label">真实姓名：</label>
                    <span class="detail-info-value">{{@realName}}</span>
                </div>
                <div class="detail-info-item">
                    <label class="detail-info-label">电话：</label>
                    <span class="detail-info-value">{{@phone}}</span>
                </div>
            </div>
            <div class="cf">
                <div class="detail-info-item">
                    <label class="detail-info-label">管辖部门：</label>
                    <span class="detail-info-value">{{@department}}</span>
                </div>
                <div class="detail-info-item">
                    <label class="detail-info-label">邮箱：</label>
                    <span class="detail-info-value">{{@email}}</span>
                </div>
            </div>
        </div>
        {{if processList.length + orderList.length + groupList.length > 0}}
        <div class="flow-info-box">
            {{if processList.length>0}}
            <label class="flow-info-label">相关流程：</label>
            <div class="flow-info-value-box">
                {{each processList}}
                <div class="flow-info-value">{{$value.name}}</div>
                {{/each}}
            </div>
            {{/if}}
            {{if orderList.length>0}}
            <label class="flow-info-label">相关任务：</label>
            <div class="flow-info-value-box">
                {{each orderList}}
                <div class="flow-info-value">{{$value.uuid}}-{{$value.title}}-{{$value.name}}</div>
                {{/each}}
            </div>
            {{/if}}
            {{if groupList.length>0}}
            <label class="flow-info-label">相关组：</label>
            <div class="flow-info-value-box">
                {{each groupList}}
                <div class="flow-info-value">{{$value.name}}</div>
                {{/each}}
            </div>
            {{/if}}
        </div>
        {{/if}}
    </div>
</script>
<!-- usbkey库详情结束 -->
<script src="${ctxJs}/plugins/dataTables/jquery.dataTables.min.js"></script>
<!--<script src="${ctxJs}/plugins/dataTables/ColReorderWithResize.min.js"></script>-->
<!--<script src="${ctxJs}/plugins/zTree/jquery.ztree.core-3.5.js" type="text/javascript"></script>-->
<!--<script src="${ctxJs}/plugins/zTree/jquery.ztree.excheck-3.5.js" type="text/javascript"></script>-->
<script src="${ctxJs}/plugins/template/template-web.js" type="text/javascript"></script>
<script src="${ctxJs}/system/setting/index.js"></script>