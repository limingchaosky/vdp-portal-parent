/**
 * Created by chengl on 2018/1/15 0015.
 */
var approveList = null;
$(function () {
  getApprroveList('.left-list:first');//获取审批列表
  initEvents();//初始化页面事件
});
function initEvents() {
  $('body')
  //流程列表点击切换
    .on('click', '.left-list', function () {
      if (!$(this).hasClass('list-active')) {
        $('.list-active').removeClass('list-active');
        $(this).addClass('list-active');
        $("#approveFlow_box").html('').load(ctx + '/approveDefinition/approveDetailView?approveDefinitionId=' + $(this).attr('data-id'));
        // getRoleInfo($(this).attr('data-id'));
      }
    })
    //添加流程
    .on('click', '#bar_add_flow', function () {
      layer.open({
        id: 'openWind',
        type: 1,
        title: '添加审批流程',
        content: $('#new_flow').html(),
        area: ['430px', '300px'],
        btn: ['确定', '取消'],
        yes: function (index, layero) {
          var postData = {};
          postData.name = $('#openWind input[name=flowname]').val();
          postData.parentApproveId = $('#openWind select[name=userSelectFlow] option:selected').val();
          if ($('#openWind input[name=flowname]').val() == '') {
            $("body #openWind #flowTip").css('display', 'inline-block');
            return
          }
          $.ajax({
            type: 'post',
            url: ctx + '/approveDefinition/addApproveDefinition',//新建流程接口
            data: postData,
            success: function (msg) {
              if (msg.resultCode == '1') {
                layer.close(index);
                layer.msg('新建成功！', {icon: 1});
                getApprroveList('.left-list:last');
              } else {
                layer.msg('新建失败！', {icon: 2});
                // $('#left_content_box').addClass('empty');//后期加上
              }
            },
            error: function () {
              layer.msg('新建失败！', {icon: 2});
            }
          })
        },
        success: function (layero, index) {
          var htmlflow = '';
          for (var i = 0; i < approveList.length; i++) {
            htmlflow += '<option value=' + approveList[i].id + '>' + approveList[i].name + '</option>';
          }
          $('#openWind select[name=userSelectFlow]').html(htmlflow);
        }
      });
    })
    //删除流程
    .on('click', '.list-del', function () {
      var el = $(this);
      var id  = $(this).data("id");
      layer.confirm('确定要删除流程？', {
        btn: ['确定', '取消'],
        zIndex: 100
      }, function (index) {
      if(id == 1){
        layer.msg("默认流程不能删除",{icon:7});
        return;
      }
        layer.close(index);
        $.ajax({
          type: 'post',
          url: ctx + '/approveDefinition/deleteApproveDefinition',
          data: {approveDefinitionId:id},
          success: function (msg) {
            if (msg.resultCode == '1') {
              layer.msg('删除成功！', {icon: 1});
              getApprroveList('.left-list:first');
            } else {
              layer.msg('删除失败！', {icon: 2});
            }
          },
          error: function (e) {
            layer.msg('删除失败！', {icon: 2});
          }
        })

      });
    })

}
// 获取所有的审批流程
function getApprroveList(el) {
  getAjax(ctx + '/approveDefinition/getAllApproveDefinition', '', function (msg) {
    if (msg.resultCode == 1) {
      approveList = msg.data;
      $("#flow_list_box").html(template('flow_list',approveList))
    }
    $(el).click();


  });

}