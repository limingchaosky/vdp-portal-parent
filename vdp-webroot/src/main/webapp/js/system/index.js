/**
 * Created by chengl on 2018/1/5 0005.
 */
$(function(){
  initEvent();
});
function initEvent(){
  $("body")
    .on("click",".titleTab li",function(){
      $(this).addClass("titleTabactive").siblings("li").removeClass("titleTabactive");
      var classcon = $(this).data("class");
      $("."+classcon+"con").show().siblings("div").hide();

    })
}