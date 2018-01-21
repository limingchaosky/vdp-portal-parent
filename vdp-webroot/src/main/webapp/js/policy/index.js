/**
 * Created by chengl on 2018/1/2 0002.
 */
var approveList = null;
var export_file=0;//审批流程的选择的id
var out_file=0;//审批流程的选择的id
var obj = {
  // "out_file":'0',
  // "export_file":'0',
  "sbscrnwatermark":{
    "content": {
      "computername": 1,
      "depname": 1,
      "macaddress": 1,
      "ip": 1,
      "time": 1,
      "manualtext": "程磊测试",//自定义水印内容
      "mode": 0,
      "opacity": 60,
      "username": 1,
      "manual":0
    },
    "enable": 1,
  },
  "sbfileoutcfg": {//外发
    "content": {
      "validtimecheck": 0,//设置有效时间
      "autodelouttime": 0,
      "default": 1,
      "autodelete":0,
      "opencountcheck": 0,//设置允许打开
      "disablemod": 0,
      "pwdcheck": 0,//设置密码验证
      "disablesc": 1,//禁止截屏
      "flowid": "2",//审批流程
      "mode": 1,//1自主外发 2是审批外发
      "opencount": 20,//允许打开多少次
      "printwatermark": 0,
      "ptwmcontent": "",
      "pwd": 10,//密码验证多少位
      "scwmcontent": "文件外发水印",
      "validtime": 1,//有效时间多少天
      "scwatermark": {
        "content": {
          "computername": 1,
          "depname": 1,
          "macaddress": 1,
          "ip": 1,
          "time": 1,
          "manualtext": "程磊测试",//自定义水印内容
          "mode": 0,
          "username": 1,
          "manual":0
        },
        "enable": 0,
        "isshow":0//0是显示1是隐式水印
      },//屏幕水印
    },
    "enable": 1,
  },
  "sbfileopt":{
    "content": {
      "exportenable": 1,
      "exporttype": 1,//1是明文 3是审批外发
      "flowid": "2",//审批流程
      "importenable": 1,
      "sbfileoptwatermark":{
        "content": {
          "computername": 1,
          "depname": 1,
          "macaddress": 1,
          "ip": 1,
          "time": 1,
          "manualtext": "程磊测试",//自定义水印内容
          "mode": 0,
          "username": 1,
          "manual":0
        },
        "enable": 0,
        "isshow":0//0是显示1是隐式水印
      }
    },
    "enable": 1,
  },
  "videoappro":0//视频数据流转是否
};
var objAll = {};
$(function () {
  initEvents();
  allChecked();
  getAllApprove();
});

function initEvents() {
  $('body')
    //保存策略
    .on('click', '.policy-save', function () {
      $('.policy-content form').validate({
        rules: {
          screendiyWaterContent: {
            maxlength:30,

          },
          settingTimes:{
            digits:true
          },
          passwordVerifications:{
            digits:true
          },
          allowOpens:{
            digits:true
          },
          outdiyWaterContent:{
            maxlength:30,
          },
          exportdiyWaterContent:{
            maxlength:30,
          },
        }
      });
      // 审批流程外发

      if($("body input[name=diyWater]").is(":checked")){
        if($("body input[name=screendiyWaterContent]").val()!=''){

        }else {
          layer.msg("请填写自定义水印内容",{icon:2});
          return;
        }
      }
      if($("body input[name=fileOutDiyWater]").is(":checked")){
        if($("body input[name=outdiyWaterContent]").val()!=''){

        }else {
          layer.msg("请填写自定义水印内容",{icon:2});
          return;
        }
      }
      if($("body input[name=fileExportDiyWater]").is(":checked")){
        if($("body input[name=exportdiyWaterContent]").val()!=''){

        }else {
          layer.msg("请填写自定义水印内容",{icon:2});
          return;
        }
      }
      if (!$(".policy-content form").valid()) {
        return;
      }
      var temp = $(".policy-content form").serializeJSON();
      console.log(temp);
      //下面是关于审批的
      if(out_file == 0){//说明进来没有点审批
        if(msg.sbfileoutcfg.content.flowid!=0){
          obj.sbfileoutcfg.content.flowid = msg.sbfileoutcfg.content.flowid;
        }else {
          obj.sbfileoutcfg.content.flowid = out_file;
        }
      }else {//第一次进来点了审批，out_file有值了，不用管了
          obj.sbfileoutcfg.content.flowid=out_file;
      }
      if(export_file == 0){
        if(msg.sbfileopt.content.flowid!=0){
          obj.sbfileopt.content.flowid = msg.sbfileopt.content.flowid;
        }else {
          obj.sbfileopt.content.flowid = 0;
        }
      }else {//第一次进来点了审批，export_file，不用管了
          obj.sbfileopt.content.flowid=export_file;
      }
      debugger;
      if($("body input[name=approveOut]").is(":checked")){
        if(obj.sbfileoutcfg.content.flowid>0){

        }else {
          layer.msg("请选择文件外发流程",{icon:2});
          return;
        }
      }
      // 审批流程导出
      if($("body input[name=approveExport]").is(":checked")){
        if(obj.sbfileopt.content.flowid>0){

        }else {
          layer.msg("请选择文件导出流程",{icon:2});
          return;
        }
      }
      //这是关于策略内容的
      //屏幕水印
      obj.sbscrnwatermark.enable = temp.screenSwitch?Number(temp.screenSwitch):0;
      obj.sbscrnwatermark.content.depname = temp.deptWater?Number(temp.deptWater):0;
      obj.sbscrnwatermark.content.username = temp.nameWater?Number(temp.nameWater):0;
      obj.sbscrnwatermark.content.ip = temp.ipWater?Number(temp.ipWater):0;
      obj.sbscrnwatermark.content.macaddress = temp.MACWater?Number(temp.MACWater):0;
      obj.sbscrnwatermark.content.computername = temp.computerWater?Number(temp.computerWater):0;
      obj.sbscrnwatermark.content.time = temp.timeWater?Number(temp.timeWater):0;
      obj.sbscrnwatermark.content.manual = temp.diyWater?Number(temp.diyWater):0;
      obj.sbscrnwatermark.content.manualtext = temp.screendiyWaterContent||'';
      // 文件外发
      obj.sbfileoutcfg.enable = temp.fileOutSwitch?Number(temp.fileOutSwitch):0;
      obj.sbfileoutcfg.content.mode = temp.approveOut?Number(temp.approveOut):1;
      obj.sbfileoutcfg.content.disablesc = temp.forbidScreen?Number(temp.forbidScreen):0;
      obj.sbfileoutcfg.content.validtimecheck = temp.settingTime?Number(temp.settingTime):0;
      obj.sbfileoutcfg.content.validtime = temp.settingTimes?Number(temp.settingTimes):0;
      obj.sbfileoutcfg.content.pwdcheck = temp.passwordVerification?Number(temp.passwordVerification):0;
      obj.sbfileoutcfg.content.pwd = temp.passwordVerifications?Number(temp.passwordVerifications):0;
      obj.sbfileoutcfg.content.opencountcheck = temp.allowOpen?Number(temp.allowOpen):0;
      obj.sbfileoutcfg.content.opencount = temp.allowOpens?Number(temp.allowOpens):0;
      obj.sbfileoutcfg.content.autodelete = temp.allowOpenDelete?Number(temp.allowOpenDelete):0;
      obj.sbfileoutcfg.content.scwatermark.enable = temp.isScreenWater?Number(temp.isScreenWater):0;
      obj.sbfileoutcfg.content.scwatermark.isshow = temp.outWater?Number(temp.outWater):0;
      obj.sbfileoutcfg.content.scwatermark.content.depname = temp.fileOutDept?Number(temp.fileOutDept):0;
      obj.sbfileoutcfg.content.scwatermark.content.username = temp.fileOutName?Number(temp.fileOutName):0;
      obj.sbfileoutcfg.content.scwatermark.content.ip = temp.fileOutIpWater?Number(temp.fileOutIpWater):0;
      obj.sbfileoutcfg.content.scwatermark.content.macaddress = temp.fileOutMACWater?Number(temp.fileOutMACWater):0;
      obj.sbfileoutcfg.content.scwatermark.content.computername = temp.fileOutComputerWater?Number(temp.fileOutComputerWater):0;
      obj.sbfileoutcfg.content.scwatermark.content.time = temp.fileOutTimeWater?Number(temp.fileOutTimeWater):0;
      obj.sbfileoutcfg.content.scwatermark.content.manual = temp.fileOutDiyWater?Number(temp.fileOutDiyWater):0;
      obj.sbfileoutcfg.content.scwatermark.content.manualtext = temp.outdiyWaterContent||'';
      //文件导出
      obj.sbfileopt.enable = temp.fileOutSwitch?Number(temp.fileExportSwitch):0;
      obj.sbfileopt.content.mode = temp.approveExport?Number(temp.approveExport):1;//1是明文3是审批
      obj.sbfileopt.content.sbfileoptwatermark.enable = temp.isScreen?Number(temp.isScreen):0;
      obj.sbfileopt.content.sbfileoptwatermark.isshow = temp.exportWater?Number(temp.exportWater):0;
      obj.sbfileopt.content.sbfileoptwatermark.content.depname = temp.fileExportDept?Number(temp.fileExportDept):0;

      obj.sbfileopt.content.sbfileoptwatermark.content.username = temp.fileExportName?Number(temp.fileExportName):0;

      obj.sbfileopt.content.sbfileoptwatermark.content.ip = temp.fileExportIpWater?Number(temp.fileExportIpWater):0;

      obj.sbfileopt.content.sbfileoptwatermark.content.macaddress = temp.fileExportMACWater?Number(temp.fileExportMACWater):0;

      obj.sbfileopt.content.sbfileoptwatermark.content.computername = temp.fileExportComputerWater?Number(temp.fileExportComputerWater):0;
      obj.sbfileopt.content.sbfileoptwatermark.content.time = temp.fileExportTimeWater?Number(temp.fileExportTimeWater):0;
      obj.sbfileopt.content.sbfileoptwatermark.content.manual = temp.fileExportDiyWater?Number(temp.fileExportDiyWater):0;
      obj.sbfileopt.content.sbfileoptwatermark.content.manualtext = temp.exportdiyWaterContent||'';
      // console.log(temp.videoApprove);
      //图片审计
      obj.videoappro=temp.videoApprove?Number(temp.videoApprove):0;


      objAll = {"content":obj,"policyid":policyId};
      console.log(objAll);
      $.ajax({
        type:'post',
        url:ctx + '/policy/updatePolicyJsonFile',
        contentType:'application/json;charset=utf-8',//指定为json类型
        //数据格式是json串
        data:JSON.stringify(objAll),
        success:function(msg){//返回json结果
          if (msg.resultCode == 1) {
            layer.msg('保存成功！', {icon: 1});
          }
          else {
            layer.msg('保存失败！' + (msg.resultMsg || ''), {icon: 2});
          }
        },
        error:function(msg){
          layer.msg('保存错误！' + (msg.resultMsg || ''), {icon: 2});
        }
      });



      // postAjax(ctx + '/policy/updatePolicyJsonFile', temp, function (msg) {
      //   if (msg.resultCode == 1) {
      //     layer.msg('保存成功！', {icon: 1});
      //   }
      //   else {
      //     layer.msg('保存失败！' + (msg.resultMsg || ''), {icon: 2});
      //   }
      // });
    })
    //删除策略
    .on('click', '.policy-delete', function () {
      var postData = {};
      postData.policyId = policyId;
      layer.confirm('确定删除该策略吗？', {
        btn: ['确定', '取消']
      }, function () {
        postAjax(ctx + '/policy/deletePolicy', postData, function (msg) {
          if (msg.resultCode == 1) {
            layer.msg('删除成功！', {icon: 1});
            window.location = ctx + '/policy/readPolicyJsonFileById?id=1';
          }
          else {
            layer.msg('保存失败！' + (msg.resultMsg || ''), {icon: 2});
          }
        });
      });

    })
    //审批流程
    .on('click', '#fileExportApprove,#fileOutApprove', function () {
      if ($(this).is('#fileExportApprove')) {
        //这是导出
        layer.open({
          id:'exportOpenWind',
          type:1,
          title:'选择审批流程',
          content:'',
          area: ['270px', '200px'],
          btn: ['确定', '取消'],
          yes:function(index, layero){
            export_file = $("#exportOpenWind input[name=exportSelect]:checked").val();
            layer.close(index);
          },
          success:function(index, layero){
            if(export_file == 0){//说明刚进来  没有点过审批选项
              var approvehtml = '';
              for (var i = 0;i<approveList.length;i++){
                var ischecked = '';
                if(msg.sbfileopt.content.flowid == approveList[i].id) ischecked="checked";
                approvehtml+='<div class="beauty-radio margin-right-sm"><input '+ischecked+' id="approveListAll'+approveList[i].id+'" class="beauty-radio-input" type="radio" name="exportSelect" value="'+approveList[i].id+'"> <label for="approveListAll'+approveList[i].id+'" class="beauty-radio-label">'+approveList[i].name+'</label> </div>';
              }
              $("#exportOpenWind").html(approvehtml);
            }else {
              var approvehtml = '';
              for (var i = 0;i<approveList.length;i++){
                var ischecked = '';
                if(export_file == approveList[i].id) ischecked="checked";
                approvehtml+='<div class="beauty-radio margin-right-sm"><input '+ischecked+' id="approveListAll'+approveList[i].id+'" class="beauty-radio-input" type="radio" name="exportSelect" value="'+approveList[i].id+'"> <label for="approveListAll'+approveList[i].id+'" class="beauty-radio-label">'+approveList[i].name+'</label> </div>';
              }
              $("#exportOpenWind").html(approvehtml);
            }

          }
        })
      } else if ($(this).is('#fileOutApprove')) {
        //这是外发
        layer.open({
          id:'outOpenWind',
          type:1,
          title:'选择审批流程',
          content:'',
          area: ['270px', '200px'],
          btn: ['确定', '取消'],
          yes:function(index, layero){
            out_file = $("#outOpenWind input[name=exportSelect]:checked").val();
            layer.close(index);
          },
          success:function(index, layero){
            if(out_file == 0){
              var approvehtml = '';
              for (var i = 0;i<approveList.length;i++){
                var ischecked = '';
                if(msg.sbfileoutcfg.content.flowid == approveList[i].id) ischecked="checked";
                approvehtml+='<div class="beauty-radio margin-right-sm"> <input '+ischecked+' id="approveListAll'+approveList[i].id+'" class="beauty-radio-input" type="radio" name="exportSelect" value="'+approveList[i].id+'"> <label for="approveListAll'+approveList[i].id+'" class="beauty-radio-label">'+approveList[i].name+'</label> </div>';
              }
              $("#outOpenWind").html(approvehtml);
            }else {
              var approvehtml = '';
              for (var i = 0;i<approveList.length;i++){
                var ischecked = '';
                if(out_file == approveList[i].id) ischecked="checked";
                approvehtml+='<div class="beauty-radio margin-right-sm"> <input '+ischecked+' id="approveListAll'+approveList[i].id+'" class="beauty-radio-input" type="radio" name="exportSelect" value="'+approveList[i].id+'"> <label for="approveListAll'+approveList[i].id+'" class="beauty-radio-label">'+approveList[i].name+'</label> </div>';
              }
              $("#outOpenWind").html(approvehtml);
            }

          }
        })
      }
    })
    //点击input框解除disabled
    .on('click','#diyWater,#settingTime,#passwordVerification,#allowOpen,#fileOutDiyWater,#fileExportDiyWater,#fileExportDiyWater',function(){
      if($(this).is(":checked")){
        $(this).parents(".beauty-checkbox").siblings("input[type=text]").prop("disabled",false);
        $(this).parents(".beauty-checkbox").siblings(".beauty-checkbox").find("input").prop("disabled",false);
      }else{
        $(this).parents(".beauty-checkbox").siblings("input[type=text]").prop("disabled",true);
        $(this).parents(".beauty-checkbox").siblings(".beauty-checkbox").find("input").prop("disabled",true);
      }
    })
    // 文件外发水印那块点选效果
    .on('click','input[name=outWater]',function(){
      if($("body #outWaterHidden").is(":checked")){
        $("body .fileOut .waterShowContent label.ms input").prop("checked","checked");
        $("body .fileOut .waterShowContent label.ms input").prop("disabled",true);
      }else {
        $("body .fileOut .waterShowContent label.ms input").prop("checked",false);
        $("body .fileOut .waterShowContent label.ms input").prop("disabled",false);
      }
    })
    // 文件导出水印那块点选效果
    .on('click','input[name=exportWater]',function(){
      if($("body #waterHidden").is(":checked")){
        $("body .fileExport .waterShowContent label.ms input").prop("checked","checked");
        $("body .fileExport .waterShowContent label.ms input").prop("disabled",true);
      }else {
        $("body .fileExport .waterShowContent label.ms input").prop("checked",false);
        $("body .fileExport .waterShowContent label.ms input").prop("disabled",false);
      }
    })
    // 文件外发disabled效果
    .on('click','input[name=isScreenWater]',function(){
      if($("body #isScreenWater").is(":checked")){
        $(this).parents(".policy-con").siblings(".policy-list").find("input[type=radio]").prop("disabled",false)
      }else {
        $(this).parents(".policy-con").siblings(".policy-list").find("input[type=radio]").prop("disabled",true)
      }
    })
    // 文件导出disabled效果
    .on('click','input[name=isScreen]',function(){
      if($("body #isScreen").is(":checked")){
        $(this).parents(".policy-con").find("input[type=radio]").prop("disabled",false)
      }else {
        $(this).parents(".policy-con").find("input[type=radio]").prop("disabled",true)
      }
    })
}
// 获取所有的审批流程
function getAllApprove() {

  getAjax(ctx + '/approveDefinition/getAllApproveDefinition', '', function (msg) {
    if (msg.resultCode == 1){
      console.log(msg.data);
      approveList= msg.data;
    }

  });

}
// 页面中的js交互
function allChecked(){
  if($("body #diyWater").is(":checked")){
    $("body input[name=screendiyWaterContent]").removeAttr("disabled");
  }
  if($("body #settingTime").is(":checked")){
    $("body input[name=settingTimes]").removeAttr("disabled");
  }
  if($("body #passwordVerification").is(":checked")){
    $("body input[name=passwordVerifications]").removeAttr("disabled");
  }
  if($("body #allowOpen").is(":checked")){
    $("body input[name=allowOpens]").removeAttr("disabled");
    $("body input[name=allowOpenDelete]").removeAttr("disabled");
  }
  if($("body #fileOutDiyWater").is(":checked")){
    $("body input[name=outdiyWaterContent]").removeAttr("disabled");
  }
  if($("body #fileExportDiyWater").is(":checked")){
    $("body input[name=exportdiyWaterContent]").removeAttr("disabled");
  }
  if($("body #outWaterHidden").is(":checked")){
    $("body .fileOut .waterShowContent label.ms input").prop("checked","checked");
    $("body .fileOut .waterShowContent label.ms input").prop("disabled",true);
  }
  if($("body #isScreenWater").is(":checked")){
    $("body input[name=outWater]").removeAttr("disabled");
  }
  if($("body #isScreen").is(":checked")){
    $("body input[name=exportWater]").removeAttr("disabled");
  }
}