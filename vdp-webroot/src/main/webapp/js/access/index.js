/**
 * Created by chengl on 2018/1/3 0003.
 */
$(function() {
  //初始化事件
  initEvents();
  showEmpty(); //没有数据显示暂无数据
  $('.list-item:eq(0)').click();
  //定时刷新状态
  // refreshStatus();
});
/**
 * 初始化事件
 * @Author   张东
 * @DateTime 2017-03-20T17:54:25+0800
 */
function initEvents() {
  $('body')
    //准入配置
    .on('click', '.config', function() {
      layer.open({
        id: 'openWind',
        type: 1,
        area: ['640px', '550px'],
        btn: ['确定', '取消'],
        title: '准入配置',
        zIndex: 100,
        content: $('.edit-server-wind').html(),
        yes: function(index, layero) {
          //mac
          if (!$('#openWind form').valid()) {
            return;
          }
          //准入控制网段
          var flag = true;
          el = $(layero).find('input[name=ctrlAreas-x]');
          if($(".layui-layer-content").find(".switch-btn").hasClass("on")){
            if ($(layero).find('input[name=ctrlAreas]').length == 0) {
              $(el).focus();
              $(el).closest('.row').find('.error-text').text('至少要有一个准入控制网段').show();
              flag = false;
            }
          }else{
          }

          if (!flag) {
            return;
          }
          if ($('.layui-layer-btn0').attr('disabled') == 'true') {
            return;
          }
          $('.layui-layer-btn0').attr('disabled', true);
          $.ajax({
            type: 'post',
            url: ctx + '/access/editconfig',
            data: $(layero).find('form').serialize(),
            success: function(msg) {
              $('.layui-layer-btn0').removeAttr('disabled');
              if (msg === 'success') {
                layer.close(index);
                layer.msg('配置成功！',{icon:1});
              } else {
                layer.msg('配置失败！',{icon:2});
              }
            },
            error: function(e) {
              $('.layui-layer-btn0').removeAttr('disabled');
              layer.msg('配置失败！',{icon:2});
            }
          })
        },

        btn2: function(index, layero) {
          return true;
        },
        success: function(layero, index) {
          $('#openWind').addClass('layer-bottom-line');
          if ($('#status').text() === '已开启') {
            $('#status-switch .switch-btn').addClass('on');
            $('#status-switch input[type=checkbox]').prop("checked", true);
            //$(".macaddress").addClass("required");
            $(".layui-layer-content").find(".mustinput").addClass("must");
          } else {
            $('#status-switch .switch-btn').removeClass('on');
            $('#status-switch input[type=checkbox]').prop("checked", false);
            //$(".macaddress").removeClass("required");
            $(".layui-layer-content").find(".mustinput").removeClass("must");
          }
          $(".switch-btn").click(function(){
            if($(".layui-layer-content").find(".switch-btn").hasClass("on")){
              //$(".macaddress").removeClass("required");
              $(".mustinput").removeClass("must");
            }else{
              //$(".macaddress").addClass("required");
              $(".mustinput").addClass("must");
            }
          })
          if ($.trim($('#nac_mac').text()) !== '未配置') {
            $('#openWind input[name=nacMac]').val(nacMac)
          }
          if ($.trim($('#nac_url').text()) !== '未配置') {
            $('#openWind input[name=nacUrl]').val(nacUrl)
          }
          for (var i = 0; i < ctrlAreas.length; i++) {
            $('#openWind .ctrl-area').append('<div class="append-param-box"><input class="add-param-val medium-input append" value="' + ctrlAreas[i] + '" type="text" name="ctrlAreas" readonly><i class="iconfont icon-guanbi del-param"></i></div>');
          }
          for (var i = 0; i < legalIps.length; i++) {
            $('#openWind .legal-ip').append('<div class="append-param-box"><input class="add-param-val medium-input append" value="' + legalIps[i] + '" type="text" name="legalIps" readonly><i class="iconfont icon-guanbi del-param"></i></div>');
          }
          for (var i = 0; i < legalPorts.length; i++) {
            $('#openWind .legal-port').append('<div class="append-param-box"><input class="add-param-val medium-input append" value="' + legalPorts[i] + '" type="text" name="legalPorts" readonly><i class="iconfont icon-guanbi del-param"></i></div>');
          }
          for (var i = 0; i < ilegalIps.length; i++) {
            $('#openWind .ilegal-ip').append('<div class="append-param-box"><input class="add-param-val medium-input append" value="' + ilegalIps[i] + '" type="text" name="ilegalIps" readonly><i class="iconfont icon-guanbi del-param"></i></div>');
          }
          for (var i = 0; i < ilegalPorts.length; i++) {
            $('#openWind .ilegal-port').append('<div class="append-param-box"><input class="add-param-val medium-input append" value="' + ilegalPorts[i] + '" type="text" name="ilegalPorts" readonly><i class="iconfont icon-guanbi del-param"></i></div>');
          }
          for (var i = 0; i < httpPorts.length; i++) {
            $('#openWind .http-port').append('<div class="append-param-box"><input class="add-param-val medium-input append" value="' + httpPorts[i] + '" type="text" name="httpPorts" readonly><i class="iconfont icon-guanbi del-param"></i></div>');
          }
          $('#openWind input[name=nacServer]').val($.trim($('#ip').text()));
          $('#openWind form').validate({
            rules: {
              nacMac: {
                mac: true
              },
            },
            messages: {
              nacMac: {
                mac: "MAC格式不正确",
              },
            },
          });
        }
      });
    })
    //添加准入控制网段
    .on('click', '.add-ctrl-area', function() {
      var el = $('#openWind input[name=ctrlAreas-x]')
      var val = $.trim($(el).val());
      if (checkIp(val)) {
        $('#openWind .ctrl-area').append('<div class="append-param-box"><input class="add-param-val medium-input append" value="' + val + '" type="text" name="ctrlAreas" readonly><i class="iconfont icon-guanbi del-param"></i></div>');
        $(el).val('').focus();
      } else {
        if (val !== '') {
          $(el).focus();
          $(el).closest('.row').find('.error-text').text('IP地址格式不正确').show();
        }
      }
    })
    //添加白名单IP
    .on('click', '.add-legal-ip', function() {
      var el = $('#openWind input[name=legalIps-x]')
      var val = $.trim($(el).val());
      if (checkIp(val)) {
        $('#openWind .legal-ip').append('<div class="append-param-box"><input class="add-param-val medium-input append" value="' + val + '" type="text" name="legalIps" readonly><i class="iconfont icon-guanbi del-param"></i></div>');
        $(el).val('').focus();
      } else {
        if (val !== '') {
          $(el).focus();
          $(el).closest('.row').find('.error-text').text('IP地址格式不正确').show();
        }
      }
    })
    //添加白名单端口
    .on('click', '.add-legal-port', function() {
      var el = $('#openWind input[name=legalPorts-x]')
      var val = $.trim($(el).val());
      if (portValidate(val) || portAreasValidate(val)) {
        $('#openWind .legal-port').append('<div class="append-param-box"><input class="add-param-val medium-input append" value="' + val + '" type="text" name="legalPorts" readonly><i class="iconfont icon-guanbi del-param"></i></div>');
        $(el).val('').focus();
      } else {
        if (val !== '') {
          $(el).focus();
          $(el).closest('.row').find('.error-text').text('0~65535之间的整数').show();
        }
      }
    })
    //添加HTTP端口
    .on('click', '.add-http-port', function() {
      var el = $('#openWind input[name=httpPorts-x]')
      var val = $.trim($(el).val());
      if (portValidate(val) || portAreasValidate(val)) {
        $('#openWind .http-port').append('<div class="append-param-box"><input class="add-param-val medium-input append" value="' + val + '" type="text" name="httpPorts" readonly><i class="iconfont icon-guanbi del-param"></i></div>');
        $(el).val('').focus();
      } else {
        if (val !== '') {
          $(el).focus();
          $(el).closest('.row').find('.error-text').text('0~65535之间的整数').show();
        }
      }
    })
    //删除参数
    .on('click', '.del-param', function() {
      $(this).closest('.append-param-box').remove();
    })
    //隐藏错误信息
    .on('focus', '#openWind input[type=text]', function() {
      $(this).closest('.row').find('.error-text').hide();
    })
    //隐藏错误信息
    .on('input', '#openWind input[type=text]', function() {
      $(this).closest('.row').find('.error-text').hide();
    })
    //准入状态开关
    .on('click', '#openWind .switch-box .switch-btn', function() {
      if ($(this).hasClass('on')) {
        $(this).removeClass('on');
        $(this).next('input[type=checkbox]').prop("checked", false)
      } else {
        $(this).addClass('on');
        $(this).next('input[type=checkbox]').prop("checked", true);
      }
    });
};
/**
 * 较验端口
 */
function portValidate(val) {
  //端口正则
  var portReg = /^([0-9]|[1-9]\d|[1-9]\d{2}|[1-9]\d{3}|[1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-5])$/;
  return portReg.test(val);
}
/**
 * 较验端口段
 */
function portAreasValidate(val) {
  //端口段正则
  var portAreasReg = /^([0-9]|[1-9]\d|[1-9]\d{2}|[1-9]\d{3}|[1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-5])\-([0-9]|[1-9]\d|[1-9]\d{2}|[1-9]\d{3}|[1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-5])$/;
  if (portAreasReg.test(val)) {
    var temp = val.split('-');
    return Number(temp[0]) < Number(temp[1])
  }
  return false;
}
/**
 * 定时刷新状态
 * @Author   张东
 * @DateTime 2017-03-21T18:47:56+0800
 * @return   {[type]}                 [description]
 */
function refreshStatus() {
  setInterval(getStatus, 1000)
}
/**
 * 获取服务器状态
 * @Author   张东
 * @DateTime 2017-03-21T18:54:33+0800
 * @return   {[type]}                 [description]
 */
function getStatus() {
  if (typeof status != 'undefined') {
    $.ajax({
      type: 'get',
      url: ctx + '/access/getstatus',
      success: function(data) {
        $('.list-item').each(function(i, el) {
          $.each(data, function(j, obj) {
            if ($(el).attr('data-ip') == obj.ip) {
              if ($(el).hasClass('online') !== obj.status) {
                if (obj.status) {
                  $(el).addClass('online')
                } else {
                  $(el).removeClass('online')
                }
                //$("#inright-content").load(ctx + '/access/detail?id=' + $('#ip').text);
              }
              return false;
            }
          });
        });
        $.each(data, function(index, obj) {
          if ($('.list-item.active').attr('data-ip') == obj.ip) {
            if (obj.config) {
              var config = JSON.parse(obj.config);
              if (config.nac_open) {
                if (config.nac_open === '1') {
                  status = true;
                } else {
                  status = false;
                }
              }
              if (config.nac_mac) {
                nacMac = config.nac_mac;
              } else {
                nacMac = '';
              }
              if (config.url) {
                nacUrl = config.url;
              } else {
                nacUrl = '';
              }
              if (config.ctrl_area) {
                ctrlAreas = [];
                for (var key in config.ctrl_area) {
                  ctrlAreas.push(key)
                }
              } else {
                ctrlAreas = [];
              }
              if (config.legal_ip) {
                legalIps = [];
                for (var key in config.legal_ip) {
                  legalIps.push(key)
                }
              } else {
                legalIps = [];
              }
              if (config.legal_port) {
                legalPorts = [];
                for (var key in config.legal_port) {
                  legalPorts.push(key)
                }
              } else {
                legalPorts = [];
              }
              if (config.ilegal_ip) {
                ilegalIps = [];
                for (var key in config.ilegal_ip) {
                  ilegalIps.push(key)
                }
              } else {
                ilegalIps = [];
              }
              if (config.ilegal_port) {
                ilegalPorts = [];
                for (var key in config.ilegal_port) {
                  ilegalPorts.push(key)
                }
              } else {
                ilegalPorts = [];
              }
              if (config.http_port) {
                httpPorts = [];
                for (var key in config.http_port) {
                  httpPorts.push(key)
                }
              } else {
                httpPorts = [];
              }
              refreshPage();
            }
          }

        });
      },
      error: function(e) {}
    })
  };
}
