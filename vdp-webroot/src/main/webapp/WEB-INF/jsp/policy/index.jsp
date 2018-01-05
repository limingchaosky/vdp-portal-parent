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
        <div class="top-title">${policyName}</div>
        <div class="bar-item-box policy-delete">
            <i class="iconfont icon-btn-delete"></i>
        </div>
    </div>
    <div class="policy-content content-box">
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
                        <label for="deptWater">部门名称</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="nameWater" name="nameWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="nameWater" class="checkbox-icon"></label>
                        </div>
                        <label for="nameWater">真实姓名</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="ipWater" name="ipWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="ipWater" class="checkbox-icon"></label>
                        </div>
                        <label for="ipWater">IP地址信息</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="MACWater" name="MACWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="MACWater" class="checkbox-icon"></label>
                        </div>
                        <label for="MACWater">MAC地址</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="computerWater" name="computerWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="computerWater" class="checkbox-icon"></label>
                        </div>
                        <label for="computerWater">计算机名称</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="timeWater" name="timeWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="timeWater" class="checkbox-icon"></label>
                        </div>
                        <label for="timeWater">终端时间</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="diyWater" name="diyWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="diyWater" class="checkbox-icon"></label>
                        </div>
                        <label for="diyWater">自定义水印</label>
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
                        <label for="approveOut">审批外发</label>
                        <label id="fileOutApprove" class="approveButton">审批流程</label>
                    </label>
                    <label for="" class="out">
                        <div class="beauty-checkbox">
                            <input id="forbidScreen" name="forbidScreen" type="checkbox" class="j-check-device-all" value="1">
                            <label for="forbidScreen" class="checkbox-icon"></label>
                        </div>
                        <label for="forbidScreen">禁止截屏</label>
                    </label>
                    <label for="" class="out">
                        <div class="beauty-checkbox">
                            <input id="fileScreenWater" name="fileScreenWater" type="checkbox" class="j-check-device-all" value="1">
                            <label for="fileScreenWater" class="checkbox-icon"></label>
                        </div>
                        <label for="fileScreenWater">屏幕水印</label>
                    </label>
                    <label for="" class="out">
                        <div class="beauty-checkbox">
                            <input id="settingTime" name="settingTime" type="checkbox" class="j-check-device-all" value="1">
                            <label for="settingTime" class="checkbox-icon"></label>
                        </div>
                        <label for="settingTime">设置有效时间</label>
                        <input type="text" name="settingTimes" class="smallinput"/>天
                    </label>
                    <label for="" class="out">
                        <div class="beauty-checkbox">
                            <input id="passwordVerification" name="passwordVerification" type="checkbox" class="j-check-device-all" value="1">
                            <label for="passwordVerification" class="checkbox-icon"></label>
                        </div>
                        <label for="passwordVerification">密码验证</label>
                        <input type="text" name="passwordVerifications" class="smallinput"/>位
                    </label>
                    <label for="" class="out">
                        <div class="beauty-checkbox">
                            <input id="allowOpen" name="allowOpen" type="checkbox" class="j-check-device-all" value="1">
                            <label for="allowOpen" class="checkbox-icon"></label>
                        </div>
                        <label for="allowOpen">允许打开多少次</label>
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
                        <label for="fileDiyWater">自定义水印</label>
                        <input type="text" name="fileDiyWaterContent" class="smallinput"/>
                    </label>
                </div>
                <div class="policy-con">
                    <div class="beauty-radio margin-right-sm">
                        <input id="outWaterShow" class="beauty-radio-input" type="radio" name="outWater" value="0" checked>
                        <label for="outWaterShow" class="beauty-radio-label">显示水印</label>
                    </div>
                    <div class="beauty-radio margin-right-sm">
                        <input id="outWaterNo" class="beauty-radio-input" type="radio" name="outWater" value="1">
                        <label for="outWaterNo" class="beauty-radio-label">无水印</label>
                    </div>
                    <div class="beauty-radio margin-right-sm">
                        <input id="outWaterHidden" class="beauty-radio-input" type="radio" name="outWater" value="2">
                        <label for="outWaterHidden" class="beauty-radio-label">隐式水印</label>
                    </div>
                    <div class="waterShowContent">
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileOutDept" name="fileOutDept" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileOutDept" class="checkbox-icon"></label>
                            </div>
                            <label for="fileOutDept">部门名称</label>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileOutName" name="fileOutName" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileOutName" class="checkbox-icon"></label>
                            </div>
                            <label for="fileOutName">真实姓名</label>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileOutIpWater" name="fileOutIpWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileOutIpWater" class="checkbox-icon"></label>
                            </div>
                            <label for="fileOutIpWater">IP地址信息</label>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileOutMACWater" name="fileOutMACWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileOutMACWater" class="checkbox-icon"></label>
                            </div>
                            <label for="fileOutMACWater">MAC地址</label>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileOutComputerWater" name="fileOutComputerWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileOutComputerWater" class="checkbox-icon"></label>
                            </div>
                            <label for="fileOutComputerWater">计算机名称</label>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileOutTimeWater" name="fileOutTimeWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileOutTimeWater" class="checkbox-icon"></label>
                            </div>
                            <label for="fileOutTimeWater">终端时间</label>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileOutDiyWater" name="fileOutDiyWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileOutDiyWater" class="checkbox-icon"></label>
                            </div>
                            <label for="fileOutDiyWater">自定义水印</label>
                            <input type="text" name="diyWaterContent" placeholder="自定义水印内容"/>
                        </label>
                    </div>
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
                        <label for="approveExport">审批导出</label>
                        <label id="fileExportApprove" class="approveButton">审批流程</label>
                    </label>
                    <div class="beauty-radio margin-right-sm">
                        <input id="waterShow" class="beauty-radio-input" type="radio" name="exportWater" value="0" checked>
                        <label for="waterShow" class="beauty-radio-label">显示水印</label>
                    </div>
                    <div class="beauty-radio margin-right-sm">
                        <input id="waterNo" class="beauty-radio-input" type="radio" name="exportWater" value="1">
                        <label for="waterNo" class="beauty-radio-label">无水印</label>
                    </div>
                    <div class="beauty-radio margin-right-sm">
                        <input id="waterHidden" class="beauty-radio-input" type="radio" name="exportWater" value="2">
                        <label for="waterHidden" class="beauty-radio-label">隐式水印</label>
                    </div>
                    <div class="waterShowContent">
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileExportDept" name="fileExportDept" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileExportDept" class="checkbox-icon"></label>
                            </div>
                            <label for="fileExportDept">部门名称</label>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileExportName" name="fileExportName" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileExportName" class="checkbox-icon"></label>
                            </div>
                            <label for="fileExportName">真实姓名</label>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileExportIpWater" name="fileExportIpWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileExportIpWater" class="checkbox-icon"></label>
                            </div>
                            <label for="fileExportIpWater">IP地址信息</label>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileExportMACWater" name="fileExportMACWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileExportMACWater" class="checkbox-icon"></label>
                            </div>
                            <label for="fileExportMACWater">MAC地址</label>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileExportComputerWater" name="fileExportComputerWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileExportComputerWater" class="checkbox-icon"></label>
                            </div>
                            <label for="fileExportComputerWater">计算机名称</label>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileExportTimeWater" name="fileExportTimeWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileExportTimeWater" class="checkbox-icon"></label>
                            </div>
                            <label for="fileExportTimeWater">终端时间</label>
                        </label>
                        <label for="">
                            <div class="beauty-checkbox">
                                <input id="fileExportDiyWater" name="fileExportDiyWater" type="checkbox" class="j-check-device-all" value="1">
                                <label for="fileExportDiyWater" class="checkbox-icon"></label>
                            </div>
                            <label for="fileExportDiyWater">自定义水印</label>
                            <input type="text" name="diyWaterContent" placeholder="自定义水印内容"/>
                        </label>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="save">
        <div class="policy-save">
            <span>保存</span>
        </div>
    </div>
</div>
<script id="policyContent" type="text/html">

</script>
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
<script>
  var aa = ${resultMsg.data}
  console.log(aa);
//    alert(aa);
    var policyId = ${policyId}
</script>