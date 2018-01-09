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
        <c:if test="${policyId != 1}">
            <div class="bar-item-box policy-delete">
            <i class="iconfont icon-btn-delete"></i>
            </div>
        </c:if>
    </div>
</div>
<div class="policy-content content-box">

</div>
<div class="save">
    <div class="policy-save">
        <span>保存</span>
    </div>
</div>

<script id="policyContent" type="text/html">
    <form action="">
        <div class="screenWater">
            <div class="policy-title">
                <span>屏幕水印</span>
                <div class="beauty-switch">
                    <input id="screenSwitch" value="1" name="screenSwitch" type="checkbox" {{if $data.sbscrnwatermark.enable==1}} checked {{/if}}>
                    <label for="screenSwitch" class="switch-icon"></label>
                </div>

            </div>
            <div class="policy-con">
                <label for="">
                    <div class="beauty-checkbox">
                        <input id="deptWater" name="deptWater" type="checkbox" {{if $data.sbscrnwatermark.content.depname==1}} checked {{/if}} class="j-check-device-all" value="1">
                        <label for="deptWater" class="checkbox-icon"></label>
                    </div>
                    <label for="deptWater">部门名称</label>
                </label>
                <label for="">
                    <div class="beauty-checkbox">
                        <input id="nameWater" name="nameWater" type="checkbox" {{if $data.sbscrnwatermark.content.username==1}} checked {{/if}} class="j-check-device-all" value="1">
                        <label for="nameWater" class="checkbox-icon"></label>
                    </div>
                    <label for="nameWater">真实姓名</label>
                </label>
                <label for="">
                    <div class="beauty-checkbox">
                        <input id="ipWater" name="ipWater" type="checkbox" {{if $data.sbscrnwatermark.content.ip==1}} checked {{/if}} class="j-check-device-all" value="1">
                        <label for="ipWater" class="checkbox-icon"></label>
                    </div>
                    <label for="ipWater">IP地址信息</label>
                </label>
                <label for="">
                    <div class="beauty-checkbox">
                        <input id="MACWater" name="MACWater" type="checkbox" {{if $data.sbscrnwatermark.content.macaddress==1}} checked {{/if}} class="j-check-device-all" value="1">
                        <label for="MACWater" class="checkbox-icon"></label>
                    </div>
                    <label for="MACWater">MAC地址</label>
                </label>
                <label for="">
                    <div class="beauty-checkbox">
                        <input id="computerWater" name="computerWater" type="checkbox" {{if $data.sbscrnwatermark.content.computername==1}} checked {{/if}} class="j-check-device-all" value="1">
                        <label for="computerWater" class="checkbox-icon"></label>
                    </div>
                    <label for="computerWater">计算机名称</label>
                </label>
                <label for="">
                    <div class="beauty-checkbox">
                        <input id="timeWater" name="timeWater" type="checkbox" {{if $data.sbscrnwatermark.content.time==1}} checked {{/if}} class="j-check-device-all" value="1">
                        <label for="timeWater" class="checkbox-icon"></label>
                    </div>
                    <label for="timeWater">终端时间</label>
                </label>
                <label for="">
                    <div class="beauty-checkbox">
                        <input id="diyWater" name="diyWater" type="checkbox" {{if $data.sbscrnwatermark.content.manual==1}} checked {{/if}} class="j-check-device-all" value="1">
                        <label for="diyWater" class="checkbox-icon"></label>
                    </div>
                    <label for="diyWater">自定义水印</label>
                    <input type="text" disabled name="screendiyWaterContent" placeholder="自定义水印内容" value="{{$data.sbscrnwatermark.content.manualtext}}"/>
                </label>
            </div>
        </div>
        <div class="fileOut">
            <div class="policy-title">
                <span>文件外发</span>
                <div class="beauty-switch">
                    <input id="fileOutSwitch" value="1" name="fileOutSwitch" type="checkbox" {{if $data.sbfileoutcfg.enable==1}} checked {{/if}}>
                    <label for="fileOutSwitch" class="switch-icon"></label>
                </div>
            </div>
            <div class="policy-con">
                <label for="" class="out">
                    <div class="beauty-checkbox">
                        <input id="approveOut" name="approveOut" type="checkbox" {{if $data.sbfileoutcfg.content.mode==2}} checked {{/if}} class="j-check-device-all" value="2">
                        <label for="approveOut" class="checkbox-icon"></label>
                    </div>
                    <label for="approveOut">审批外发</label>
                    <label id="fileOutApprove" class="approveButton">审批流程</label>
                </label>
                <label for="" class="out">
                    <div class="beauty-checkbox">
                        <input id="forbidScreen" name="forbidScreen" type="checkbox" {{if $data.sbfileoutcfg.content.disablesc==1}} checked {{/if}} class="j-check-device-all" value="1">
                        <label for="forbidScreen" class="checkbox-icon"></label>
                    </div>
                    <label for="forbidScreen">禁止截屏</label>
                </label>
                <label for="" class="out">
                    <div class="beauty-checkbox">
                        <input id="settingTime" name="settingTime" type="checkbox" {{if $data.sbfileoutcfg.content.validtimecheck==1}} checked {{/if}} class="j-check-device-all" value="1">
                        <label for="settingTime" class="checkbox-icon"></label>
                    </div>
                    <label for="settingTime">设置有效时间</label>
                    <input type="text" name="settingTimes" disabled value="{{$data.sbfileoutcfg.content.validtime}}" class="smallinput"/>天
                </label>
                <label for="" class="out">
                    <div class="beauty-checkbox">
                        <input id="passwordVerification" name="passwordVerification" type="checkbox" {{if $data.sbfileoutcfg.content.pwdcheck==1}} checked {{/if}} class="j-check-device-all" value="1">
                        <label for="passwordVerification" class="checkbox-icon"></label>
                    </div>
                    <label for="passwordVerification">密码验证</label>
                    <input type="text" disabled name="passwordVerifications" value="{{$data.sbfileoutcfg.content.pwd}}" class="smallinput"/>位
                </label>
                <label for="" class="out">
                    <div class="beauty-checkbox">
                        <input id="allowOpen" name="allowOpen" type="checkbox" {{if $data.sbfileoutcfg.content.opencountcheck==1}} checked {{/if}} class="j-check-device-all" value="1">
                        <label for="allowOpen" class="checkbox-icon"></label>
                    </div>
                    <label for="allowOpen">允许打开多少次</label>
                    <input type="text" disabled name="allowOpens" value="{{$data.sbfileoutcfg.content.opencount}}" class="smallinput"/>次，
                    <div class="beauty-checkbox">
                        <input id="allowOpenDelete" name="allowOpenDelete" type="checkbox" {{if $data.sbfileoutcfg.content.autodelete==1}} checked {{/if}} class="j-check-device-all" value="1">
                        <label for="allowOpenDelete" class="checkbox-icon"></label>
                    </div>
                    <span class="autoDelete">超出自动删除</span>
                </label>
                <label for="" class="out">
                    <div class="beauty-checkbox">
                        <input id="isScreenWater" name="isScreenWater" type="checkbox" {{if $data.sbfileoutcfg.content.scwatermark.enable==1}} checked {{/if}} class="j-check-device-all" value="1">
                        <label for="isScreenWater" class="checkbox-icon"></label>
                    </div>
                    <label for="isScreenWater">屏幕水印</label>
                </label>
            </div>
            <div class="policy-con">
                <div class="beauty-radio margin-right-sm">
                    <input id="outWaterShow" value="0" class="beauty-radio-input" type="radio" name="outWater" {{if $data.sbfileoutcfg.content.scwatermark.isshow==0}} checked {{/if}} >
                    <label for="outWaterShow" class="beauty-radio-label">显示水印</label>
                </div>
                <div class="beauty-radio margin-right-sm">
                    <input id="outWaterHidden" value="1" class="beauty-radio-input" type="radio" name="outWater" {{if $data.sbfileoutcfg.content.scwatermark.isshow==1}} checked {{/if}} >
                    <label for="outWaterHidden" class="beauty-radio-label">隐式水印</label>
                </div>
                <div class="waterShowContent">
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="fileOutDept" name="fileOutDept" type="checkbox" {{if $data.sbfileoutcfg.content.scwatermark.content.depname==1}} checked {{/if}} class="j-check-device-all" value="1">
                            <label for="fileOutDept" class="checkbox-icon"></label>
                        </div>
                        <label for="fileOutDept">部门名称</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="fileOutName" name="fileOutName" type="checkbox" {{if $data.sbfileoutcfg.content.scwatermark.content.username==1}} checked {{/if}} class="j-check-device-all" value="1">
                            <label for="fileOutName" class="checkbox-icon"></label>
                        </div>
                        <label for="fileOutName">真实姓名</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="fileOutIpWater" name="fileOutIpWater" type="checkbox" {{if $data.sbfileoutcfg.content.scwatermark.content.ip==1}} checked {{/if}} class="j-check-device-all" value="1">
                            <label for="fileOutIpWater" class="checkbox-icon"></label>
                        </div>
                        <label for="fileOutIpWater">IP地址信息</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="fileOutMACWater" name="fileOutMACWater" type="checkbox" {{if $data.sbfileoutcfg.content.scwatermark.content.macaddress==1}} checked {{/if}} class="j-check-device-all" value="1">
                            <label for="fileOutMACWater" class="checkbox-icon"></label>
                        </div>
                        <label for="fileOutMACWater">MAC地址</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="fileOutComputerWater" name="fileOutComputerWater" type="checkbox" {{if $data.sbfileoutcfg.content.scwatermark.content.computername==1}} checked {{/if}} class="j-check-device-all" value="1">
                            <label for="fileOutComputerWater" class="checkbox-icon"></label>
                        </div>
                        <label for="fileOutComputerWater">计算机名称</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="fileOutTimeWater" name="fileOutTimeWater" type="checkbox" {{if $data.sbfileoutcfg.content.scwatermark.content.time==1}} checked {{/if}} class="j-check-device-all" value="1">
                            <label for="fileOutTimeWater" class="checkbox-icon"></label>
                        </div>
                        <label for="fileOutTimeWater">终端时间</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="fileOutDiyWater" name="fileOutDiyWater" type="checkbox" {{if $data.sbfileoutcfg.content.scwatermark.content.manual==1}} checked {{/if}} class="j-check-device-all" value="1">
                            <label for="fileOutDiyWater" class="checkbox-icon"></label>
                        </div>
                        <label for="fileOutDiyWater">自定义水印</label>
                        <input type="text" value="{{$data.sbfileoutcfg.content.scwatermark.content.manualtext}}" name="outdiyWaterContent" placeholder="自定义水印内容"/>
                    </label>
                </div>
            </div>
        </div>
        <div class="fileExport">
            <div class="policy-title">
                <span>文件导出</span>
                <div class="beauty-switch">
                    <input id="fileExportSwitch" name="fileExportSwitch" type="checkbox" value="1" {{if $data.sbfileopt.enable==1}} checked {{/if}}>
                    <label for="fileExportSwitch" class="switch-icon"></label>
                </div>
            </div>
            <div class="policy-con">
                <label for="" class="export">
                    <div class="beauty-checkbox">
                        <input id="approveExport" name="approveExport" type="checkbox" class="j-check-device-all" value="3" {{if $data.sbfileopt.content.mode==3}} checked {{/if}}>
                        <label for="approveExport" class="checkbox-icon"></label>
                    </div>
                    <label for="approveExport">审批导出</label>
                    <label id="fileExportApprove" class="approveButton">审批流程</label>
                </label>
                <label for="" class="export">
                    <div class="beauty-checkbox">
                        <input id="isScreen" name="isScreen" type="checkbox" class="j-check-device-all" value="1" {{if $data.sbfileopt.content.sbfileoptwatermark.enable==1}} checked {{/if}}>
                        <label for="isScreen" class="checkbox-icon"></label>
                    </div>
                    <label for="isScreen">水印</label>
                </label>
                <div class="beauty-radio margin-right-sm">
                    <input id="waterShow" class="beauty-radio-input" type="radio" name="exportWater" value="0" {{if $data.sbfileopt.content.sbfileoptwatermark.isshow==0}} checked {{/if}}>
                    <label for="waterShow" class="beauty-radio-label">显示水印</label>
                </div>
                <div class="beauty-radio margin-right-sm">
                    <input id="waterHidden" class="beauty-radio-input" type="radio" name="exportWater" value="1" {{if $data.sbfileopt.content.sbfileoptwatermark.isshow==1}} checked {{/if}}>
                    <label for="waterHidden" class="beauty-radio-label">隐式水印</label>
                </div>
                <div class="waterShowContent">
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="fileExportDept" name="fileExportDept" type="checkbox" class="j-check-device-all" value="1" {{if $data.sbfileopt.content.sbfileoptwatermark.content.depname==1}} checked {{/if}}>
                            <label for="fileExportDept" class="checkbox-icon"></label>
                        </div>
                        <label for="fileExportDept">部门名称</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="fileExportName" name="fileExportName" type="checkbox" class="j-check-device-all" value="1" {{if $data.sbfileopt.content.sbfileoptwatermark.content.username==1}} checked {{/if}}>
                            <label for="fileExportName" class="checkbox-icon"></label>
                        </div>
                        <label for="fileExportName">真实姓名</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="fileExportIpWater" name="fileExportIpWater" type="checkbox" class="j-check-device-all" value="1" {{if $data.sbfileopt.content.sbfileoptwatermark.content.ip==1}} checked {{/if}}>
                            <label for="fileExportIpWater" class="checkbox-icon"></label>
                        </div>
                        <label for="fileExportIpWater">IP地址信息</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="fileExportMACWater" name="fileExportMACWater" type="checkbox" class="j-check-device-all" value="1" {{if $data.sbfileopt.content.sbfileoptwatermark.content.macaddress==1}} checked {{/if}}>
                            <label for="fileExportMACWater" class="checkbox-icon"></label>
                        </div>
                        <label for="fileExportMACWater">MAC地址</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="fileExportComputerWater" name="fileExportComputerWater" type="checkbox" class="j-check-device-all" value="1" {{if $data.sbfileopt.content.sbfileoptwatermark.content.computername==1}} checked {{/if}}>
                            <label for="fileExportComputerWater" class="checkbox-icon"></label>
                        </div>
                        <label for="fileExportComputerWater">计算机名称</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="fileExportTimeWater" name="fileExportTimeWater" type="checkbox" class="j-check-device-all" value="1" {{if $data.sbfileopt.content.sbfileoptwatermark.content.time==1}} checked {{/if}}>
                            <label for="fileExportTimeWater" class="checkbox-icon"></label>
                        </div>
                        <label for="fileExportTimeWater">终端时间</label>
                    </label>
                    <label for="">
                        <div class="beauty-checkbox">
                            <input id="fileExportDiyWater" name="fileExportDiyWater" type="checkbox" class="j-check-device-all" value="1" {{if $data.sbfileopt.content.sbfileoptwatermark.content.manual==1}} checked {{/if}}>
                            <label for="fileExportDiyWater" class="checkbox-icon"></label>
                        </div>
                        <label for="fileExportDiyWater">自定义水印</label>
                        <input type="text" value="{{$data.sbfileopt.content.sbfileoptwatermark.content.manualtext}}" name="exportdiyWaterContent" placeholder="自定义水印内容"/>
                    </label>
                </div>
            </div>
        </div>
        <div class="flowApprove">
            <div class="policy-title">
                <span>视频图片数据流转审计</span>
                <div class="beauty-switch">
                    <input id="videoApprove" name="videoApprove" type="checkbox" value="1" {{if $data.videoappro==1}} checked {{/if}}>
                    <label for="videoApprove" class="switch-icon"></label>
                </div>
            </div>
            <div class="policy-con"></div>
        </div>
    </form>
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
  var msg =
  ${resultMsg.data}
  //        console.log(msg);
  //      msg.content="我是一个兵";
  //      msg.out_file='1';
  //      msg.export_file='2';
  var policyContent = template('policyContent', msg);
  $(".policy-content").html(policyContent);
  var policyId =
  ${policyId}

</script>