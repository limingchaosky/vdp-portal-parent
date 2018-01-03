<!--userlist.jsp -->
<!-- <%@ page language="java" pageEncoding="UTF-8"%>-->
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>

<head>
    <title>金盾VDP</title>
    <!--<link href="${ctxCss}/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css" />-->
    <link href="${ctxCss}/policy/index.css" rel="stylesheet" type="text/css"/>
    <!--<link href="${ctxCss}/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />-->
    <!--<link href="${ctxCss}/workorder/pending/index.css" rel="stylesheet" type="text/css" />-->
</head>

<div class="main-right">
    <div class="top-bar">
        <div class="top-title">策略</div>
    </div>
    <div class="policy-content">
        <form action="">
            <div class="screenWater">
                <div class="policy-title">
                    <span>屏幕水印</span>
                    <div class="beauty-switch">
                        <input id="screenSwitch" name="screenSwitch" type="checkbox" checked value="1">
                        <label for="screenSwitch" class="switch-icon"></label>
                    </div>
                </div>
                <div class="policy-con">
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="deptWater" name="deptWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="deptWater" class="checkbox-icon"></label>
                        </div>
                        <span>部门名称</span>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="nameWater" name="nameWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="nameWater" class="checkbox-icon"></label>
                        </div>
                        <span>真实姓名</span>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="ipWater" name="ipWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="ipWater" class="checkbox-icon"></label>
                        </div>
                        <span>IP地址信息</span>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="MACWater" name="MACWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="MACWater" class="checkbox-icon"></label>
                        </div>
                        <span>MAC地址</span>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="computerWater" name="computerWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="computerWater" class="checkbox-icon"></label>
                        </div>
                        <span>计算机名称</span>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="timeWater" name="timeWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="timeWater" class="checkbox-icon"></label>
                        </div>
                        <span>终端时间</span>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="diyWater" name="diyWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="diyWater" class="checkbox-icon"></label>
                        </div>
                        <span>自定义水印</span>
                        <input type="text" name="diyWaterContent" placeholder="自定义水印内容"/>
                    </label>
                </div>
            </div>
            <div class="flowApprove">
                <div class="policy-title">
                    <span>视频图片数据流转审计</span>
                    <div class="beauty-switch">
                        <input id="videoApprove" name="videoApprove" type="checkbox" checked value="1">
                        <label for="videoApprove" class="switch-icon"></label>
                    </div>
                </div>
                <div class="policy-con"></div>
            </div>
            <div class="fileOut">
                <div class="policy-title">
                    <span>文件外发</span>
                    <div class="beauty-switch">
                        <input id="fileOutSwitch" name="fileOutSwitch" type="checkbox" checked value="1">
                        <label for="fileOutSwitch" class="switch-icon"></label>
                    </div>
                </div>
                <div class="policy-con">
                    <label for="" class="out">
                        <div class="beauty-checkbox">
                            <input id="approveOut" name="approveOut" type="checkbox" class="j-check-device-all" value="1">
                            <label for="approveOut" class="checkbox-icon"></label>
                        </div>
                        <span>审批外发</span>
                        <span class="approveButton">审批流程</span>
                    </label>
                    <label for="" class="out">
                        <div class="beauty-checkbox">
                            <input id="forbidScreen" name="forbidScreen" type="checkbox" class="j-check-device-all" value="1">
                            <label for="forbidScreen" class="checkbox-icon"></label>
                        </div>
                        <span>禁止截屏</span>
                    </label>
                    <label for="" class="out">
                        <div class="beauty-checkbox">
                            <input id="fileScreenWater" name="fileScreenWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="fileScreenWater" class="checkbox-icon"></label>
                        </div>
                        <span>屏幕水印</span>
                    </label>
                    <label for="" class="out">
                        <div class="beauty-checkbox">
                            <input id="settingTime" name="settingTime" type="checkbox" class="j-check-device-all" value="1">
                            <label for="settingTime" class="checkbox-icon"></label>
                        </div>
                        <span>设置有效时间</span>
                        <input type="text" name="settingTimes" class="smallinput"/>天
                    </label>
                    <label for="" class="out">
                        <div class="beauty-checkbox">
                            <input id="passwordVerification" name="passwordVerification" type="checkbox" class="j-check-device-all" value="1">
                            <label for="passwordVerification" class="checkbox-icon"></label>
                        </div>
                        <span>密码验证</span>
                        <input type="text" name="passwordVerifications" class="smallinput"/>位
                    </label>
                    <label for="" class="out">
                        <div class="beauty-checkbox">
                            <input id="allowOpen" name="allowOpen" type="checkbox" class="j-check-device-all" value="1">
                            <label for="allowOpen" class="checkbox-icon"></label>
                        </div>
                        <span>允许打开多少次</span>
                        <input type="text" name="allowOpens" class="smallinput"/>次，
                        <div class="beauty-checkbox">
                            <input id="allowOpenDelete" name="allowOpenDelete" type="checkbox" class="j-check-device-all" value="1">
                            <label for="allowOpenDelete" class="checkbox-icon"></label>
                        </div>
                        <span class="autoDelete">超出自动删除</span>
                    </label>
                    <label for="" class="out">
                        <div class="beauty-checkbox">
                            <input id="fileDiyWater" name="fileDiyWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="fileDiyWater" class="checkbox-icon"></label>
                        </div>
                        <span>自定义水印</span>
                        <input type="text" name="fileDiyWaterContent" class="smallinput"/>
                    </label>
                </div>
            </div>
            <div class="fileExport">
                <div class="policy-title">
                    <span>文件导出</span>
                    <div class="beauty-switch">
                        <input id="fileExportSwitch" name="fileExportSwitch" type="checkbox" checked value="1">
                        <label for="fileExportSwitch" class="switch-icon"></label>
                    </div>
                </div>
                <div class="policy-con">
                    <label for="" class="export">
                        <div class="beauty-checkbox">
                            <input id="approveExport" name="approveExport" type="checkbox" class="j-check-device-all" value="1">
                            <label for="approveExport" class="checkbox-icon"></label>
                        </div>
                        <span>审批导出</span>
                        <span class="approveButton">审批流程</span>
                    </label>
                    <div class="beauty-radio margin-right-sm">
                        <input id="waterShow" class="beauty-radio-input" type="radio" name="water" value="0" checked>
                        <label for="waterShow" class="beauty-radio-label">显示水印</label>
                    </div>
                    <div class="beauty-radio margin-right-sm">
                        <input id="waterNo" class="beauty-radio-input" type="radio" name="water" value="1">
                        <label for="waterNo" class="beauty-radio-label">无水印</label>
                    </div>
                    <div class="beauty-radio margin-right-sm">
                        <input id="waterHidden" class="beauty-radio-input" type="radio" name="water" value="2">
                        <label for="waterHidden" class="beauty-radio-label">隐式水印</label>
                    </div>
                    <div class="waterShowContent">
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileExportDept" name="fileExportDept" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileExportDept" class="checkbox-icon"></label>
                            </div>
                            <span>部门名称</span>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileExportName" name="fileExportName" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileExportName" class="checkbox-icon"></label>
                            </div>
                            <span>真实姓名</span>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileExportIpWater" name="fileExportIpWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileExportIpWater" class="checkbox-icon"></label>
                            </div>
                            <span>IP地址信息</span>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileExportMACWater" name="fileExportMACWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileExportMACWater" class="checkbox-icon"></label>
                            </div>
                            <span>MAC地址</span>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileExportComputerWater" name="fileExportComputerWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileExportComputerWater" class="checkbox-icon"></label>
                            </div>
                            <span>计算机名称</span>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileExportTimeWater" name="fileExportTimeWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileExportTimeWater" class="checkbox-icon"></label>
                            </div>
                            <span>终端时间</span>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileExportDiyWater" name="fileExportDiyWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileExportDiyWater" class="checkbox-icon"></label>
                            </div>
                            <span>自定义水印</span>
                            <input type="text" name="diyWaterContent" placeholder="自定义水印内容"/>
                        </label>
                    </div>
                </div>
            </div>
        </form>
        <div class="save">
            <span class="policyBtn">保存</span>
        </div>
    </div>

</div>

<!--<script src="${ctxJs}/plugins/echarts/echarts.common.min.js"></script>-->
<script src="${ctxJs}/plugins/template/template-web.js"></script>
<!--<script src="${ctxJs}/plugins/ueditor/ueditor.config.js"></script>-->
<!--<script src="${ctxJs}/plugins/ueditor/ueditor.all.js"></script>-->
<!--<script src="${ctxJs}/plugins/jquery.PrintArea/jquery.PrintArea.js"></script>-->
<!--<script src="${ctxJs}/plugins/validate/jquery.validate.js"></script>-->
<!--<script src="${ctxJs}/validateExtent.js"></script>-->
<script src="${ctxJs}/plugins/bootstrap/bootstrap.min.js" type="text/javascript"></script>
<!--<script src="${ctxJs}/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>-->
<!--<script src="${ctxJs}/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>-->
<script src="${ctxJs}/policy/index.js"></script>