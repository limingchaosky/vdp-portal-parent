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
      $(this).parents(".default").siblings().find('.default_bar').removeClass('default_bar_hover');
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
          $(apphum).insertBefore(indexDOm);
          layer.close(index);

        },
        success: function (layero, index) {
          var postData = {};
          if ($(indexDOm).closest("label.default").data("stepid") == '') {//说明是新增
            getAjax(ctx + '/systemSetting/user/getAllOperatorList', '', function (msg) {
              console.log(msg);
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
              console.log(msg);
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
      if ($(this).parents('label.default').data('stepid') == '') {
        layer.msg('该流程还未保存，不能删除', {icon: 7});
        return;
      } else {
        var stepid = $(this).data("stepid");
        var pid = $(this).parents('label.default').prev('label').data('stepid');
        console.log({flowId: flowid, id: stepid, seniorId: pid});
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
                $(this).parents('label.default').fadeOut(300).remove();
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
      // if($(this).hasClass("flow_add_start")){//从0开始的环节
      if (fl) {
        var a = $(this).closest("label").next("label.default");
        var t = $("#default_template").find("label.default");
        var b = t.clone(true);


        b.insertBefore(a);

        b.find(".default_bar_title").trigger('click');
        console.log(b);
      } else {
        layer.msg("有未保存的流程");
        return;
      }


      // }else {
      //
      // }
      // var $(this).closest("label");
      // var labelLength = $(".approve_start").find(".default").length;
      // console.log(labelLength);
    })
    //点击保存
    .on('click', '.save-button', function () {
      var id = $(this).parents("label.default").data("stepid");
      var name = $(this).parents("label.default").find('input[name=stepname]').val();
      var approves = '';
      $(this).parents("label.default").find(".approve_h span").each(function (index) {
        if (index == $(this).parents("label.default").find(".approve_h span").length - 1) {
          approves += $(this).data('guid').toString()
        } else {
          approves += $(this).data('guid').toString() + ';';
        }

      });
      var senid = $(this).parents("label.default").prev("label").data('stepid');

      var postData = {};
      if ($(this).closest("label.default").data("stepid") == '') {//说明是新增
        var standid = $(this).parents("label.default").find('input[name=mode99]:checked').val();
        if (approves == '') {
          layer.msg('审批人不能为空！', {icon: 7});
        }
        if (name == '') {
          layer.msg('环节名称不能为空！', {icon: 7});
        }
        postData.flowId = Number(flowid);
        postData.name = name.toString();
        postData.approvers = approves;
        postData.seniorId = Number(senid);//必有
        postData.standard = Number(standid);//必有
        console.log(postData);
        // return;
        postAjax(ctx + '/approveModel/addOrUpdateApproveModel', postData, function (msg) {
          if (msg.resultCode == 1) {
            layer.msg('保存成功！', {icon: 1});
            getAjax(ctx + '/approveDefinition/getApproveDefinitionModel', '', function (msg) {
              console.log(msg);
              return;
              if (msg.resultCode == 1) {


                $(".approve_start").html(template('approveAllList', objAll));
              }
            });


          } else {
            layer.msg('保存失败！' + (msg.resultMsg || ''), {icon: 2});
          }
        });


      } else {//说明是编辑
        var standid = $(this).parents("label.default").find('input[name=mode' + id + ']:checked').val();
        postData.flowId = flowid;
        postData.id = id;
        postData.name = name;
        postData.approverArr = approves;
        postData.seniorId = senid;
        postData.standard = standid;
        console.log(postData);
        postAjax(ctx + '/approveModel/addOrUpdateApproveModel', postData, function (msg) {
          if (msg.resultCode == 1) {
            layer.msg('保存成功！', {icon: 1});
          }
          else {
            layer.msg('保存失败！' + (msg.resultMsg || ''), {icon: 2});
          }
        });
      }

    })
    //点击取消
    .on('click', '.cancel-button', function () {
      if ($(this).closest("label.default").data("stepid") == '') {//说明是新建
        $(this).parents("label.default").fadeOut(300).remove();
      } else {//说明是编辑的
        $(this).parents(".approve_con").hide();
      }

    })
    //删除审批人
    .on('click', '.hum_del', function () {
      $(this).closest('span').remove();
    })
}

function getapp(objAll) {
  $(".approve_start").html(template('approveAllList', objAll));
}