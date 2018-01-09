<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>

<head>
    <title>金盾VDP</title>
    <link href="${ctxCss}/dataTables/dataTablesgray.css" rel="stylesheet" type="text/css"/>
    <!--<link href="${ctxCss}/ztree/ztree.css" rel="stylesheet" type="text/css" />-->
    <link href="${ctxCss}/system/client/index.css" rel="stylesheet" type="text/css"/>
</head>
<div class="main-right">
    <!--内容区头部-->
    <div class="top-bar">
        <div class="top-title">客户端</div>
    </div>
    <!--内容区头部结束-->
    <!--内容区-表格-->
    <div class="content-box">
        <div class="videoNetCon">
            <div class="top-bar">
                <div class="top-title">视频业务网络访问管控</div>
            </div>
            <div class="netContent">
                <div class="netAdd">
                    <div class="wind-row inline-block">
                        <label for="" class="wind-label">IP/IP段</label>
                        <input type="text" class="form-input wind-normal-input" name="username" maxlength="20">
                    </div>
                    <a id="bar_net_add" class="bar-item bar-item-icon iconfont icon-btn-add" title="添加用户"></a>
                </div>
                <div class="netShow">
                    <div class="netShowList inline-block" data-id=""><span>192.168.111.111-192.168.222.222</span><i id="netClose" class="iconfont icon-btn-close none"></i></div>
                    <div class="netShowList inline-block"><span>192.168.111.111-192.168.222.222</span><i class="iconfont icon-btn-close none"></i></div>
                    <div class="netShowList inline-block"><span>192.168.111.111-192.168.222.222</span><i class="iconfont icon-btn-close none"></i></div>
                    <div class="netShowList inline-block"><span>192.168.111.111-192.168.222.222</span><i class="iconfont icon-btn-close none"></i></div>
                    <div class="netShowList inline-block"><span>192.168.111.111-192.168.222.222</span><i class="iconfont icon-btn-close none"></i></div>
                    <div class="netShowList inline-block"><span>192.168.111.111-192.168.222.222</span><i class="iconfont icon-btn-close none"></i></div>
                    <div class="netShowList inline-block"><span>192.168.111.111-192.168.222.222</span><i class="iconfont icon-btn-close none"></i></div>
                    <div class="netShowList inline-block"><span>192.168.111.111-192.168.222.222</span><i class="iconfont icon-btn-close none"></i></div>
                    <div class="netShowList inline-block"><span>192.168.111.111-192.168.222.222</span><i class="iconfont icon-btn-close none"></i></div>
                    <div class="netShowList inline-block"><span>192.168.111.111-192.168.222.222</span><i class="iconfont icon-btn-close none"></i></div>
                    <div class="netShowList inline-block"><span>192.168.111.111-192.168.222.222</span><i class="iconfont icon-btn-close none"></i></div>
                    <div class="netShowList inline-block"><span>192.168.111.111-192.168.222.222</span><i class="iconfont icon-btn-close none"></i></div>
                    <div class="netShowList inline-block"><span>192.168.111.111-192.168.222.222</span><i class="iconfont icon-btn-close none"></i></div>
                </div>
            </div>
        </div>
        <div class="videoLogoCon">
            <div class="top-bar">
                <div class="top-title">视频业务登陆方式管理</div>
            </div>
            <div class="netContent">
                <div class="logoAdd">
                    <div class="wind-row inline-block">
                        <label for="" class="wind-label">业务名称</label>
                        <input type="text" class="form-input wind-normal-input" name="username" maxlength="20">
                    </div>
                    <div class="wind-row inline-block">
                        <label for="" class="wind-label">IP/IP段</label>
                        <input type="text" class="form-input wind-normal-input" name="username" maxlength="20">
                    </div>
                    <a id="bar_logo_add" class="bar-item bar-item-icon iconfont icon-btn-add" title="添加用户"></a>
                </div>
                <div class="logoShow">
                    <div class="logoShowList inline-block">
                        <span class="inline-block text-ellipsis">192.168.111.1111111111111111</span>
                        <div class="con inline-block text-top">
                            <i class="iconfont icon-nav-monitor"></i>
                            <span class="inline-block text-ellipsis text-top">v:\1b69\De\download(1)\font_501303_4ftfb9s8g2kgwrk9\sfsdf.exe</span>
                            <i id="logoClose" class="iconfont icon-btn-close"></i>
                        </div>
                    </div>
                    <div class="logoShowList inline-block">
                        <span class="inline-block text-ellipsis">192.168.111.1111111111111111</span>
                        <div class="con inline-block text-top">
                            <i class="iconfont icon-nav-monitor"></i>
                            <span class="inline-block text-ellipsis text-top">v:\1b69\De\download(1)\font_501303_4ftfb9s8g2kgwrk9\sfsdf.exe</span>
                            <i class="iconfont icon-btn-close"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--内容区-表格结束-->
</div>
<!-- usbkey库详情结束 -->
<!--<script src="${ctxJs}/plugins/dataTables/jquery.dataTables.min.js"></script>-->
<!--<script src="${ctxJs}/plugins/dataTables/ColReorderWithResize.min.js"></script>-->
<!--<script src="${ctxJs}/plugins/zTree/jquery.ztree.core-3.5.js" type="text/javascript"></script>-->
<!--<script src="${ctxJs}/plugins/zTree/jquery.ztree.excheck-3.5.js" type="text/javascript"></script>-->
<!--<script src="${ctxJs}/plugins/template/template-web.js" type="text/javascript"></script>-->
<script src="${ctxJs}/system/client/index.js"></script>