/**
 * Created by chengl on 2018/1/16 0016.
 */
var humtree = null;
$(function () {
  initEvents();//初始化页面事件
});
function initEvents() {
  $('body')
      //流程列表点击切换
    .on('click', '.default_bar', function () {
        $(this).siblings(".approve_con").show();
        $(this).find("img").show();
      $(this).parents(".default").siblings().find(".approve_con").hide();
      $(this).parents(".default").siblings().find("img").hide();
    })
    //添加审批人
    .on('click','#bar_add_hum',function(){
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
          var nodes = humtree.getCheckedNodes(true);

          console.log(nodes);





        },
        success: function (layero, index) {
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




        }

      });
    })
    //删除流程
    .on('click','.bar_delete_flow',function(){
      var stepid = $(this).data("stepid");
      layer.confirm('确定要删除该流程？', {
        btn: ['确定', '取消'],
        zIndex: 100
      }, function (index) {

        layer.close(index);
        $.ajax({
          type: 'post',
          url: ctx + '/approveDefinition/deleteApproveDefinition',
          data: {flowid:flowid,stepid:stepid},
          success: function (msg) {
            if (msg.resultCode == '1') {
              layer.msg('删除成功！', {icon: 1});
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
  //克隆流程
    .on('click','.flow_add',function(){
      
    })
}

$(".tips").hover(function(){
  $(this).find("span").css("background-color","#38CEC0");
  $(this).find('div').show()
},function(){
  $(this).find("span").css("background-color","#d9d9d9");
  $(this).find('div').hide();
});
// $(".default_bar").hover(function () {
//   $(this).addClass("default_bar_hover")
// },function(){
//   $(this).removeClass("default_bar_hover")
// });