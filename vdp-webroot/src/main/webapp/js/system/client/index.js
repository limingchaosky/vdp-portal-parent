/**
 * Created by chengl on 2018/1/8 0008.
 */
$(function () {
  initEvent();
  getNetData(0, 20);
  getlogoData(0, 20);
});
// 初始化事件
function initEvent() {
  $("body")
  // 业务网络添加
    .on("click", "#bar_net_add", function () {
      var netval = $("input[name=netip]").val();
      //校验
      $('body form#netform').validate({
        rules: {
          netip: {
            required: true,
            isIpRange: true
          },
        }
      });
      if (!$('body form#netform').valid()) {
        return;
      }
      if (checkValue(netval)) {
        postAjax(ctx + '/systemClient/addVedioNetAccess', {ip: netval}, function (msg) {
          if (msg.resultCode == 1) {
            layer.msg('编辑成功！', {icon: 1});
            getNetData(0, 20)
          } else {
            layer.msg('保存失败！' + (msg.resultMsg || ''), {icon: 2});
          }
        });
      }else {
        layer.msg('请勿重复添加！', {icon: 2});
        return;
      }
    })
    // 业务网络删除
    .on("click", "#netClose", function () {
      var id = $(this).parents(".netShowList").data("id");
      var idx = $(this).parents(".netShowList").index();
      layer.confirm("是否确定删除", {
        btn: ['确定', '取消']
      }, function () {
        postAjax(ctx + '/systemClient/deleteVedioNetAccess', {VedioNetAccessId: id}, function (msg) {
          if (msg.resultCode == 1) {
            layer.msg('删除成功！', {icon: 1});
            $(".netShow .netShowList").eq(idx).remove();
          }
          else {
            layer.msg('删除失败！' + (msg.resultMsg || ''), {icon: 2});
          }
        });
      })
    })
    // 登陆方式添加
    .on("click", "#bar_logo_add", function () {
      var nameval = $("input[name=logoname]").val();
      var ipval = $("input[name=logoip]").val();
      // var idx = $(this).parents(".logoShowList").index();
      var startmethod = $(this).parents(".logoShowList").data("method");
      startmethod?startmethod:0;
      //校验
      $('body form#logoform').validate({
        rules: {
          logoname: {
            required: true,
            // maxlength:20
          },
          logoip:{
            required: true,
          }
        }
      });
      if (!$('body form#logoform').valid()) {
        return;
      }
      var data ={name: nameval,startMethod:0,startPath:ipval};
      if (checkLogoValue(nameval) && checkLogoPath(ipval)) {
        postAjax(ctx + '/systemClient/addVedioLogonAccess', data, function (msg) {
          if (msg.resultCode == 1) {
            layer.msg('保存成功！', {icon: 1});
            getlogoData(0, 20)
          } else {
            layer.msg('保存失败！' + (msg.resultMsg || ''), {icon: 2});
          }
        });
      }else {
        layer.msg('请勿重复添加！', {icon: 2});
        return;
      }
    })
    // 登陆删除
    .on("click", "#logoClose", function () {
      var id = $(this).parents(".logoShowList").data("id");
      var idx = $(this).parents(".logoShowList").index();
      layer.confirm("是否确定删除", {
        btn: ['确定', '取消']
      }, function () {
        postAjax(ctx + '/systemClient/deleteVedioLogonAccess', {vedioLogonAccessId: id}, function (msg) {
          if (msg.resultCode == 1) {
            layer.msg('删除成功！', {icon: 1});
            $(".logoShow .logoShowList").eq(idx).remove();
          }
          else {
            layer.msg('删除失败！' + (msg.resultMsg || ''), {icon: 2});
          }
        });
      })
    })
    // 业务网络访问管控
    .on("mouseover", ".netShowList", function () {
      $(this).find("i").show();
      $(this).css("background", "#38D1BF");
      $(this).find('span').css("color", "#fff")
    })
    .on("mouseleave", ".netShowList", function () {
      $(this).find("i").hide();
      $(this).css("background", "#ededed")
      $(this).find('span').css("color", "#333")
    })
    // 视频登陆方式管控
    .on("mouseover", ".logoShowList", function () {
      $(this).addClass("logoShowList-hover");
    })
    .on("mouseleave", ".logoShowList", function () {
      $(this).removeClass("logoShowList-hover");
    })

}
function getNetData(start, length) {
  getAjax(ctx + "/systemClient/getVedioNetAccessPages", {start: start, length: length}, function (msg) {
    if (msg.resultCode == 1) {
      $(".netShow").html();
      $(".netShow").html(template("netList", msg.data));
    }
  })
}
function getlogoData(start, length) {
  getAjax(ctx + "/systemClient/getVedioLogonAccessPages", {start: start, length: length}, function (msg) {
    if (msg.resultCode == 1) {
      $(".logoShow").html("");
      $(".logoShow").html(template("logoList", msg.data));
    }
  })
}
function checkValue(ip) {
  var fl = true;
  $("body .netShow .netShowList span").each(function () {
    // debugger
    if (ip == $(this).text()) {
      fl = false;
      return
    }
  });
  return fl;
}
function checkLogoValue(name){
  var fl = true;
  $("body .logoShow .logoShowList>span").each(function () {
    // debugger
    if (name == $(this).text()) {
      fl = false;
      return
    }
  });
  return fl;
}
function checkLogoPath(path){
  var fl = true;
  $("body .logoShow .logoShowList .con span").each(function () {
    // debugger
    if (path == $(this).text()) {
      fl = false;
      return
    }
  });
  return fl;
}