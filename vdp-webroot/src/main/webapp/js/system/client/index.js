/**
 * Created by chengl on 2018/1/8 0008.
 */
$(function () {
  initEvent();
});
// 初始化事件
function initEvent() {
  $("body")
    .on("click", "#bar_net_add", function () {

    })
    .on("click", "#bar_logo_add", function () {

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