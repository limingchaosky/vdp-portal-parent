/**
 * Created by chengl on 2018/1/2 0002.ctx + ''
 */
var approveList = null;
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
      console.log(temp)
      postAjax(ctx + '/policy/updatePolicyJsonFile', temp, function (msg) {
        if (msg.resultCode == 1) {
          layer.msg('保存成功！', {icon: 1});
        }
        else {
          layer.msg('保存失败！' + (msg.resultMsg || ''), {icon: 2});
        }
      });
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
        layer.open({
          id:'exportOpenWind',
          type:1,
          title:'选择审批流程',
          content:'',
          area: ['270px', '200px'],
          btn: ['确定', '取消'],
          yes:function(index, layero){
            layer.close(index);
          },
          success:function(index, layero){
            var approvehtml = '';
            for (var i = 0;i<approveList.length;i++){
              approvehtml+='<div class="beauty-radio margin-right-sm"> <input id="approveListAll'+approveList[i].id+'" class="beauty-radio-input" type="radio" name="exportSelect" value="'+approveList[i].id+'"> <label for="approveListAll'+approveList[i].id+'" class="beauty-radio-label">'+approveList[i].name+'</label> </div>';
            }
            $("#exportOpenWind").html(approvehtml);
          }
        })
      } else if ($(this).is('#fileOutApprove')) {

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