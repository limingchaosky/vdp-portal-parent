/**
 * Created by chengl on 2018/1/8 0008.
 */
$(function () {
  initEvent();
});
// 初始化事件
function initEvent() {
  $("body")
    // 业务网络添加
    .on("click", "#bar_net_add", function () {

    })
      // 业务网络删除
    .on("click","#netClose",function(){
      var id = $(this).parents(".netShowList").data("id")
      layer.confirm("是否确定删除",{
        btn: ['确定', '取消']
      },function(){
        postAjax(ctx + '/clientUser/deleteClientUser', {netid:id}, function (msg) {
          if (msg.resultCode == 1) {
            layer.msg('删除成功！', {icon: 1});
            $(this).remove();
          }
          else {
            layer.msg('删除失败！' + (msg.resultMsg || ''), {icon: 2});
          }
        });
      })
    })
    // 登陆方式添加
    .on("click", "#bar_logo_add", function () {

    })
    // 登陆删除
    .on("click","#logoClose",function(){
      var id = $(this).parents(".logoShowList").data("id")
      layer.confirm("是否确定删除",{
        btn: ['确定', '取消']
      },function(){
        postAjax(ctx + '/clientUser/deleteClientUser', {logoid:id}, function (msg) {
          if (msg.resultCode == 1) {
            layer.msg('删除成功！', {icon: 1});
            $(this).remove();
          }
          else {
            layer.msg('删除失败！' + (msg.resultMsg || ''), {icon: 2});
          }
        });
      })
    })
    // 业务网络访问管控
    .on("mouseover",".netShowList",function(){
      $(this).find("i").show();
      $(this).css("background","#38D1BF");
      $(this).find('span').css("color","#fff")
    })
    .on("mouseleave",".netShowList",function(){
      $(this).find("i").hide();
      $(this).css("background","#ededed")
      $(this).find('span').css("color","#333")
    })
    // 视频登陆方式管控
    .on("mouseover",".logoShowList",function(){
      $(this).addClass("logoShowList-hover");
    })
    .on("mouseleave",".logoShowList",function(){
      $(this).removeClass("logoShowList-hover");
    })

}