<!--<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>-->

<head>
    <title>角色</title>
    <link href="${ctxCss}/dataTables/dataTablesgray.css" rel="stylesheet" type="text/css" />
    <link href="${ctxCss}/ztree/ztree.css" rel="stylesheet" type="text/css" />
    <link href="${ctxCss}/user/role/index.css" rel="stylesheet" type="text/css" />
</head>
<div class="main-right">
    <!--角色列表-->
    <div class="left-bar">
        <div class="top-bar">
            <div class="top-title">角色</div>
            <div class="bar-item-box">
                <a id="bar_add_role" class="bar-item bar-item-icon icon-add margin-right-sm" title="添加"></a>
            </div>
        </div>
        <div id="left_content_box" class="left-content-box">
            <ul id="role_list_box" class="role-list-box"></ul>
        </div>
    </div>
    <!--角色列表结束-->
    <div class="right-content-box">
        <!--内容区头部-->
        <div class="right-content-top">
            <span id="role_title" class="right-content-title margin-left-xxl"></span>
        </div>
        <!--内容区头部结束-->
        <div class="right-content">
            <div id="navigation_box" class="navigation-box"></div>
            <button id="save_navigation" type="button" class="btn btn-primary margin-left-xxl margin-vertical-xxl btn-disabled">保存</button>
        </div>
    </div>
</div>

<!--添加角色与修改角色弹窗-->
<div id="add_role_wind" class="none">
    <div class="wind-box">
        <form class="padding-normal j-add-role-form">
            <div class="wind-row cf">
                <label for="" class="wind-label label-required">角色名称</label>
                <input type="text" class="form-input wind-normal-input" name="name" placeholder="不超过20个字符" maxlength="20">
            </div>
        </form>
    </div>
</div>
<!--添加角色弹窗结束-->
<!--角色列表模板-->
<script id="temp_role_list_box" type="text/html">
    {{each}}
    <li class="left-list" data-id="{{$value.id}}">
        <span class="list-name">{{$value.roleName}}</span>
        {{if $value.id > 5}}
        <i class="icon-edit list-edit" data-id="{{$value.id}}" title="编辑"></i>
        <i class="icon-error list-del" data-id="{{$value.id}}" title="删除"></i>
        {{/if}}
    </li>
    {{/each}}
</script>
<!--角色列表模板结束-->
<!--页签模板-->
<script id="temp_navigation" type="text/html">
    {{each $data dataLevel1}}
        {{if dataLevel1.nLevel==1}}
            <div class="navigation-row navigation-level1" data-id1="{{dataLevel1.id}}">
                <div class="beauty-checkbox beauty-checkbox-level1" data-id1="{{dataLevel1.id}}">
                    <input id="check_nav_{{dataLevel1.id}}" type="checkbox" class="navigation-check check-level1" data-id="{{dataLevel1.id}}" data-id1="{{dataLevel1.id}}">
                    <label for="check_nav_{{dataLevel1.id}}" class="checkbox-icon"></label>
                </div>
                <span class="navigation-icon {{dataLevel1.iconSkin}}"></span>
                <label class="navigation-label">{{dataLevel1.name}}</label>
            </div>
            {{each $data dataLevel2}}
                {{if dataLevel2.pId == dataLevel1.id}}
                <div class="navigation-row navigation-level2" data-id1="{{dataLevel1.id}}" data-id2="{{dataLevel2.id}}">
                    <div class="beauty-checkbox beauty-checkbox-level2" data-id1="{{dataLevel1.id}}" data-id2="{{dataLevel2.id}}">
                        <input id="check_nav_{{dataLevel2.id}}" type="checkbox" class="navigation-check check-level2" data-id="{{dataLevel2.id}}" data-id1="{{dataLevel1.id}}" data-id2="{{dataLevel2.id}}">
                        <label for="check_nav_{{dataLevel2.id}}" class="checkbox-icon"></label>
                    </div>
                    <label class="navigation-label">{{dataLevel2.name}}</label>
                </div>
                <div class="navigation-row navigation-level3 cf" data-id1="{{dataLevel1.id}}" data-id2="{{dataLevel2.id}}">
                    {{each $data dataLevel3}}
                        {{if dataLevel3.pId == dataLevel2.id && dataLevel3.functionType == -1}}
                        <div class="navigation-item">
                            <div class="beauty-checkbox beauty-checkbox-level3" data-id1="{{dataLevel1.id}}" data-id2="{{dataLevel2.id}}"  data-id3="{{dataLevel3.id}}">
                                <input id="check_fun_{{dataLevel3.id}}" type="checkbox" class="navigation-check check-level3" data-id="{{dataLevel3.id}}" data-id1="{{dataLevel1.id}}" data-id2="{{dataLevel2.id}}" data-id3="{{dataLevel3.id}}" data-functionType="{{dataLevel3.functionType}}">
                                <label for="check_fun_{{dataLevel3.id}}" class="checkbox-icon"></label>
                            </div>
                            <label class="navigation-label">{{dataLevel3.name}}</label>
                        </div>
                        {{/if}}
                    {{/each}}
                </div>
                <div class="navigation-row navigation-level3 cf" data-id1="{{dataLevel1.id}}" data-id2="{{dataLevel2.id}}">
                    {{each $data dataLevel3 indexLevel3}}
                        {{if dataLevel3.pId == dataLevel2.id && dataLevel3.functionType == 2}}
                        <div class="navigation-item">
                            <div class="beauty-checkbox beauty-checkbox-level3" data-id1="{{dataLevel1.id}}" data-id2="{{dataLevel2.id}}" data-id3="{{dataLevel3.id}}">
                                <input id="check_{{dataLevel3.id}}" type="checkbox" class="navigation-check check-level3" data-id="{{dataLevel3.id}}" data-id1="{{dataLevel1.id}}" data-id2="{{dataLevel2.id}}" data-id3="{{dataLevel3.id}}" data-functionType="{{dataLevel3.functionType}}">
                                <label for="check_{{dataLevel3.id}}" class="checkbox-icon"></label>
                            </div>
                            <label class="navigation-label">{{dataLevel3.name}}</label>
                        </div>
                        {{/if}}
                    {{/each}}
                </div>
                <div class="navigation-row navigation-level3 cf" data-id1="{{dataLevel1.id}}" data-id2="{{dataLevel2.id}}">
                    {{each $data dataLevel3}}
                        {{if dataLevel3.pId == dataLevel2.id && dataLevel3.functionType == 1}}
                        <div class="navigation-item">
                            <div class="beauty-checkbox beauty-checkbox-level3" data-id1="{{dataLevel1.id}}" data-id2="{{dataLevel2.id}}" data-id3="{{dataLevel3.id}}">
                                <input id="check_{{dataLevel3.id}}" type="checkbox" class="navigation-check check-level3" data-id="{{dataLevel3.id}}" data-id1="{{dataLevel1.id}}" data-id2="{{dataLevel2.id}}" data-id3="{{dataLevel3.id}}" data-functionType="{{dataLevel3.functionType}}">
                                <label for="check_{{dataLevel3.id}}" class="checkbox-icon"></label>
                            </div>
                            <label class="navigation-label">{{dataLevel3.name}}</label>
                        </div>
                        {{/if}}
                    {{/each}}
                </div>
                {{/if}}
            {{/each}}
        {{/if}}
    {{/each}}
</script>
<!--页签模板结束-->
<script src="${ctxJs}/plugins/dataTables/jquery.dataTables.min.js"></script>
<script src="${ctxJs}/plugins/dataTables/ColReorderWithResize.min.js"></script>
<script src="${ctxJs}/plugins/template/template-web.js" type="text/javascript"></script>
<script src="${ctxJs}/user/role/index.js"></script>
<script>
    var zNodes = JSON.parse('${zNodes}');
</script>