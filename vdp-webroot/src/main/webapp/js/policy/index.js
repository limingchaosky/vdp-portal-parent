/**
 * Created by chengl on 2018/1/2 0002.ctx + ''
 */
var approveList = null;
var export_file='';
var out_file='';
$(function () {
  initEvents();
  getAllApprove();
  approve();
});

function initEvents() {
  $('body')
    //保存策略
    .on('click', '.policy-save', function () {
      var temp = $(".policy-content form").serializeJSON();


      temp.id = policyId;
      temp.export_file = export_file;
      temp.out_file = out_file;
      var data = {"content":temp,"policyid":policyId}
      console.log(data);

      $.ajax({
        type:'post',
        url:ctx + '/policy/updatePolicyJsonFile',
        contentType:'application/json;charset=utf-8',//指定为json类型
        //数据格式是json串，商品信息
        data:JSON.stringify(data),
        success:function(msg){//返回json结果
          if (msg.resultCode == 1) {
            layer.msg('保存成功！', {icon: 1});
          }
          else {
            layer.msg('保存失败！' + (msg.resultMsg || ''), {icon: 2});
          }
        },
        error:function(msg){
          layer.msg('保存失败！' + (msg.resultMsg || ''), {icon: 2});
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
            var approvehtml = '';
            for (var i = 0;i<approveList.length;i++){
              var ischecked = ''
              if(msg.export_file == approveList[i].id) ischecked="checked";
              approvehtml+='<div class="beauty-radio margin-right-sm"> <input '+ischecked+' id="approveListAll'+approveList[i].id+'" class="beauty-radio-input" type="radio" name="exportSelect" value="'+approveList[i].id+'"> <label for="approveListAll'+approveList[i].id+'" class="beauty-radio-label">'+approveList[i].name+'</label> </div>';


            }
            $("#exportOpenWind").html(approvehtml);
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
            // console.log(out_file);
            // $("#exportOpenWind input[name=export_file]").attr('value',out_file);
            layer.close(index);
          },
          success:function(index, layero){


            var approvehtml = '';
            for (var i = 0;i<approveList.length;i++){
              var ischecked = '';
              if(msg.out_file == approveList[i].id) ischecked="checked";
              approvehtml+='<div class="beauty-radio margin-right-sm"> <input '+ischecked+' id="approveListAll'+approveList[i].id+'" class="beauty-radio-input" type="radio" name="exportSelect" value="'+approveList[i].id+'"> <label for="approveListAll'+approveList[i].id+'" class="beauty-radio-label">'+approveList[i].name+'</label> </div>';
            }
            $("#outOpenWind").html(approvehtml);
          }
        })
      }
    })

}

function getAllApprove() {

  getAjax(ctx + '/js/policy/approve.json', '', function (msg) {
    approveList= msg.data;
  });

}

function approve() {
  $("#approveExport,#approveOut").on('click', function () {
    if ($(this).is(":checked")) {
      $(this).parents('.beauty-checkbox').siblings('.approveButton').css("background", "#38CFC0")
    } else {
      $(this).parents('.beauty-checkbox').siblings('.approveButton').css("background", "#ededed")
    }
  })
}