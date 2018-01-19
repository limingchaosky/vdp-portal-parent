/**
 * Created by chengl on 2018/1/16 0016.
 */
var humtree = null;
$(function () {
  getapp(objAll);
  initEvents();//初始化页面事件
});
function initEvents() {
  $('body')
  //流程列表点击切换
    .on('click', '.default_bar', function () {
      $(this).addClass('default_bar_hover');
      $(this).parents(".default").addClass("default_hover");
      $(this).parents(".default").siblings().find('.default_bar').removeClass('default_bar_hover');
      $(this).parents(".default").siblings("label").removeClass("default_hover");
      $(this).siblings(".approve_con").show();
      $(this).find("img").show();
      $(this).parents(".default").siblings().find(".approve_con").hide();
      $(this).parents(".default").siblings().find("img").hide();
    })
    //添加审批人
    .on('click', '.bar_add_hum', function () {
      var indexDOm = $(this);
      var zNodes = null;
      var setting = {
        check: {
          enable: true,
          chkStyle: "checkbox",
          chkboxType: {"Y": "ps", "N": "ps"}
        },
        data: {
          simpleData: {
            enable: true
          }
        }
      };
      layer.open({
        id: 'openWind',
        type: 1,
        title: '添加审批人',
        content: $('#treeLayer').html(),
        area: ['470px', '400px'],
        btn: ['确定', '取消'],
        yes: function (index, layero) {
          var apphum = '';

          var nodes = humtree.getCheckedNodes(true);
          for (var i = 0; i < nodes.length; i++) {
            apphum += '<span class="wind-span text-ellipsis" data-guid="' + nodes[i].guid + '">' + nodes[i].name + '<i class="iconfont icon-btn-close hum_del" data-guid="' + nodes[i].guid + '"></i></span>'
          }
          apphum += '<a class="bar-item bar-item-icon iconfont icon-btn-add margin-right-sm bar_add_hum" title="添加"></a>'
          indexDOm.parents(".approve_h").html(apphum);
          // $(apphum).insertBefore(indexDOm);
          layer.close(index);

        },
        success: function (layero, index) {
          var postData = {};
          if ($(indexDOm).closest("label.default").data("stepid") == '') {//说明是新增
            getAjax(ctx + '/systemSetting/user/getAllOperatorList', '', function (msg) {
              // console.log(msg);
              if (msg.resultCode == 1) {
                zNodes = msg.data;
                humtree = $.fn.zTree.init($("#openWind #treeview"), setting, zNodes);

              }
              else {
                layer.msg('获取审批账户失败！', {icon: 2});
              }
            });
          } else {//说明是保存 是回显
            var id = $(indexDOm).closest("label.default").data("stepid");
            // postData.flowId= flowid;
            postData.approveModelId = id;
            getAjax(ctx + '/systemSetting/user/getAllOperatorList', postData, function (msg) {
              // console.log(msg);
              if (msg.resultCode == 1) {
                zNodes = msg.data;
                humtree = $.fn.zTree.init($("#openWind #treeview"), setting, zNodes);

              }
              else {
                layer.msg('获取审批账户失败！', {icon: 2});
              }
            });

          }


        }

      });
    })
    //删除流程
    .on('click', '.bar_delete_flow', function () {
      var indexDom = $(this);

      if ($(".approve_start label.default").length == 1) {
        layer.msg('必须保留一个节点', {icon: 7});
        return false;
      }

      if ($(this).parents('label.default').data('stepid') == '') {
        layer.msg('该流程还未保存，不能删除', {icon: 7});
        return false;
      } else {
        var stepid = $(this).data("stepid");
        var pid = $(this).parents('label.default').prev('label').data('stepid');
        layer.confirm('确定要删除该流程？', {
          btn: ['确定', '取消'],
          zIndex: 100
        }, function (index) {

          layer.close(index);
          $.ajax({
            type: 'post',
            url: ctx + '/approveModel/deleteApproveModel',
            data: {flowId: flowid, id: stepid, seniorId: pid},
            success: function (msg) {
              if (msg.resultCode == '1') {
                layer.msg('删除成功！', {icon: 1});
                $(indexDom).parents('label.default').fadeOut(300).remove();
              } else {
                layer.msg('删除失败！', {icon: 2});
              }
            },
            error: function (e) {
              layer.msg('删除失败！', {icon: 2});
            }
          })

        });
      }

    })
    //克隆流程
    .on('click', '.flow_add', function () {
      var fl = true;
      $(".approve_start").find(".default").each(function () {
        if ($(this).data('stepid') == '') {
          fl = false;
        }
      });
      if (fl) {
        var a = $(this).closest("label").next("label.default");
        var t = $("#default_template").find("label.default");
        var b = t.clone(true);


        b.insertBefore(a);

        b.find(".default_bar_title").trigger('click');
      } else {
        // layer.msg("有未保存的流程");
        return;
      }
    })
    //删除审批人
    .on('click', '.hum_del', function () {
      $(this).closest('span').remove();
    })
}
//保存环节
function saveApprove(ele) {
  // debugger;
  var id = $(ele).parents("label.default").data("stepid");
  var name = $(ele).parents("label.default").find('input[name=stepname]').val();
  var approvers = '';
  $(ele).parents("label.default").find(".approve_h span").each(function (index) {
    if (index == $(this).parents("label.default").find(".approve_h span").length - 1) {
      approvers += $(this).data('guid').toString()
    } else {
      approvers += $(this).data('guid').toString() + ';';
    }

  });
  var senid = $(ele).parents("label.default").prev("label").data('stepid');

  var postData = {};
  if ($(ele).closest("label.default").data("stepid") == '') {  //说明是新增
    var standid = $(ele).parents("label.default").find('input[name=mode99]:checked').val();
    if (approvers == '') {
      layer.msg('审批人不能为空！', {icon: 7});
      return;
    }
    if (name == '') {
      layer.msg('环节名称不能为空！', {icon: 7});
      return;
    }
    postData.flowId = Number(flowid);
    postData.name = name.toString();
    postData.approvers = approvers;
    postData.seniorId = Number(senid);//必有
    postData.standard = Number(standid);//必有
    // console.log(postData);
    // return;
    postAjax(ctx + '/approveModel/addOrUpdateApproveModel', postData, function (msg) {
      console.log(msg);
      if (msg.resultCode == 1) {
        layer.msg('保存成功！', {icon: 1});
        getAjax(ctx + '/approveDefinition/getApproveDefinitionModel', {approveDefinitionId: flowid}, function (msg) {
          // console.log(msg);
          // return;
          if (msg.resultCode == 1) {


            $(".approve_start").html(template('approveAllList', msg.data));
          }
        });


      } else {
        layer.msg('保存失败！' + (msg.resultMsg || ''), {icon: 2});
      }
    });
  } else {//说明是编辑
    // debugger;
    var standid = $(ele).parents("label.default").find('input[name=mode' + id + ']:checked').val();
    postData.flowId = flowid;
    postData.id = id;
    postData.name = name;
    postData.approvers = approvers;
    postData.seniorId = senid;
    postData.standard = standid;
    console.log(postData);
    postAjax(ctx + '/approveModel/addOrUpdateApproveModel', postData, function (msg) {
      console.log(msg)
      if (msg.resultCode == 1) {
        layer.msg('保存成功！', {icon: 1});
      }
      else {
        layer.msg('保存失败！' + (msg.resultMsg || ''), {icon: 2});
      }
    });
  }

}
//取消环节
function cancelApprove(ele) {
  if ($(ele).closest("label.default").data("stepid") == '') {//说明是新建
    $(ele).parents("label.default").fadeOut(300).remove();
  } else {//说明是编辑的
    $(ele).parents(".approve_con").hide();
  }
}
//重新获取所有审批流程
function getapp(objAll) {
  $(".approve_start").html(template('approveAllList', objAll));
}