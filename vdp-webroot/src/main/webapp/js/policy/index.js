/**
 * Created by chengl on 2018/1/2 0002.
 */
// $(function(){
//   // approve();
// })();
$(".policyBtn").click(function(e){
  var temp = $(".policy-content form").serializeJSON();
  console.log(temp);
  var postData = {};

});
function approve(){
  $("#approveExport,#approveOut").on('click',function(){
    if($(this).is(":checked")){
      $(this).parents('.beauty-checkbox').siblings('.approveButton').css("background","#38CFC0")
    }else{
      $(this).parents('.beauty-checkbox').siblings('.approveButton').css("background","#ededed")
    }
  })
}