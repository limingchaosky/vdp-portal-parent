var deptTable = null;//部门用户表
var deptTree = null;//部门树
var policyList = null;//策略列表
var usbDeviceList = null;//没有用的usb设备列表
$(function () {
  initDeptTree(1);//初始化部门树,1是选中节点的id
  initEvents();//初始化页面事件
  getPolicyList();//获取所有的策略列表
  getEmUsbList();//获取空的usb设备
});
function getPolicyList() {
  getAjax(ctx + '/policy/getAllPolicys', '', function (msg) {
    if (msg.resultCode == 1) {
      policyList = msg.data;
      // console.log(policyList);
      // var html = '';
      // $.each(msg.data, function (index, obj) {
      //   html += '<option value=' + obj.id + '>' + obj.roleName + '</option>';
      // });
      // $('#bar_select_role').append(html);
    }
    else {
      layer.msg('获取权限列表失败！', {icon: 2});
    }
  });
}
function getEmUsbList() {
  getAjax(ctx + '/usbKey/getAllUnbindUsbKey', '', function (msg) {
    if (msg.resultCode == 1) {
      console.log(msg.data)
      usbDeviceList = msg.data;
      // var html = '';
      // $.each(msg.data, function (index, obj) {
      //   html += '<option value=' + obj.id + '>' + obj.roleName + '</option>';
      // });
      // $('#temp_usb').append(html);
    }
    else {
      layer.msg('获取usbKey失败！', {icon: 2});
    }
  });
}
function initEvents() {
  $('body')
  //删除用户
    .on('click', '.j-opt-hover-delete', function () {
      var id = $(this).attr('data-id');
      layer.confirm('确定要删除该用户吗？', {
        btn: ['确定', '取消']
      }, function () {
        var postData = {
          id: id
        };
        postAjax(ctx + '/clientUser/deleteClientUser', postData, function (msg) {
          if (msg.resultCode == 1) {
            deptTable.ajax.reload(function () {
            }, true);
            layer.msg('删除成功！', {icon: 1});
            $('.j-check-dept-all').prop('checked', false);
            //更新部门树
            getAjax(ctx + '/department/getDepartmentNodesByLoginUser', '', function (msg) {
              zNodes = JSON.parse(msg);
              var selectID = deptTree.getSelectedNodes()[0].id;
              deptTree.destroy();
              initDeptTree(selectID);
              initdeptTable(selectID);
            })
          }
          else {
            layer.msg('删除失败！' + (msg.resultMsg || ''), {icon: 2});
          }
        });
      });
    })
    //添加用户
    .on('click', '#bar_add_user', function () {
      var parentDeptTree = null;//部门树
      var nameValidate = null;//较验
      layer.open({
        id: 'openWind',
        type: 1,
        title: '添加用户',
        content: $('#add_user_wind').html(),
        area: ['470px', '400px'],
        btn: ['确定', '取消'],
        yes: function (index, layero) {
          if (!$("#openWind .j-add-user-form").valid()) {
            return;
          }
          var temp = $("#openWind form").serializeJSON();
          console.log(temp)
          var postData = {
            username: $('#openWind input[name=username]').val().trim(),
            truename: $('#openWind input[name=truename]').val().trim(),
            password: encrypt(temp.password).toUpperCase(),
            policyid: temp.selectPolicy,
            usbkeyid: temp.usbKeyList,
            deptguid: $('#openWind input[name=parentdept]').attr('data-id'),
          }
          if ($(layero).find('.layui-layer-btn0').hasClass('btn-disabled')) {
            return;
          }
          $(layero).find('.layui-layer-btn0').addClass('btn-disabled');
          $.ajax({
            type: 'post',
            url: ctx + '/clientUser/addClientUser',
            data: postData,
            success: function (msg) {
              // console.log(msg.resultCode);
              if (msg.resultCode == 1) {
                layer.close(index);
                layer.msg('添加成功！', {icon: 1});
                //更新部门树
                //更新部门树
                getAjax(ctx + '/department/getDepartmentNodesByLoginUser', '', function (msg) {
                  zNodes = JSON.parse(msg);
                  var selectID = deptTree.getSelectedNodes()[0].id;
                  deptTree.destroy();
                  initDeptTree(selectID);
                  initdeptTable(selectID);
                });
              } else {
                $(layero).find('.layui-layer-btn0').removeClass('btn-disabled');
                layer.msg('添加失败！' + (msg.resultMsg || ''), {icon: 2});
              }
            },
            error: function () {
              $(layero).find('.layui-layer-btn0').removeClass('btn-disabled');
              layer.msg('添加失败！' + (msg.resultMsg || ''), {icon: 2});
            }
          })
        },
        success: function (layero, index) {
          var htmlpolicy = '';
          for (var i = 0; i < policyList.length; i++) {
            htmlpolicy += '<option value=' + policyList[i].id + '>' + policyList[i].name + '</option>';
          }
          $('#openWind select[name=selectPolicy]').html(htmlpolicy);
          var htmlusb = '';
          htmlusb +='<option value="-1"></option>';
          for (var i = 0; i < usbDeviceList.length; i++) {
            htmlusb += '<option value=' + usbDeviceList[i].id + '>' + usbDeviceList[i].name + '</option>';
          }
          $('#openWind select[name=usbKeyList]').html(htmlusb);
          var setting = {
            view: {
              dblClickExpand: false,
              showLine: true,
              showIcon: true
            },
            data: {
              simpleData: {
                enable: true
              }
            },
            callback: {
              onClick: function (event, treeId, treeNode, clickFlag) {
                $('#openWind .parent-dept').val(treeNode.name).attr('data-id', treeNode.id);
                $('#openWind .parent-dept-tree-box').slideUp('fast');
                // if (nameValidate) {
                //   nameValidate.settings.rules.name.remote.data.pid = treeNode.id;
                // }
              }
            }
          };
          //部门树
          parentDeptTree = $.fn.zTree.init($("#openWind .j-parent-dept-tree"), setting, zNodes);
          if (zNodes.length > 0) {
            var node = parentDeptTree.getNodeByParam('id', deptTree.getSelectedNodes()[0].id);
            //默认选中顶级部门
            $('#' + node.tId + '_a').click();
          }
          //校验
          nameValidate = $('#openWind .j-add-user-form').validate({
            rules: {
              username: {
                required: true,
              },
              truename: {
                required: true,
              },
              password: {
                required: true,
                minlength: 6
              },
              repassword: {
                equalTo: $('#openWind input[name=password]')
              },
              parentdept: {
                required: true,
              },
            }
          });
        }
      });
    })
    //编辑用户
    .on('click', '.j-opt-hover-edit', function () {
      getEmUsbList();
      var idx = $('.j-opt-hover-edit').index(this);
      var id = Number($(this).attr('data-id'));//这是用户的id
      var parentDeptTree = null;//部门树
      layer.open({
        id: 'openWind',//这个地方会自动给弹出框添加一个id
        type: 1,
        title: '编辑用户',
        content: $('#add_user_wind').html(),
        area: ['470px', '400px'],
        btn: ['确定', '取消'],
        yes: function (index, layero) {
          if (!$("#openWind .j-add-user-form").valid()) {
            return;
          }
          var temp = $("#openWind form").serializeJSON();
          // console.log(temp);
          var postData = {
            id: id,
            username: temp.username,
            truename: temp.truename,
            password: encrypt(temp.password).toUpperCase(),
            deptguid: $('#openWind input[name=parentdept]').attr('data-id'),
            policyid: temp.selectPolicy,
            usbkeyid: temp.usbKeyList,
          };
          console.log(postData)
          if ($(layero).find('.layui-layer-btn0').hasClass('btn-disabled')) {
            return;
          }
          $(layero).find('.layui-layer-btn0').addClass('btn-disabled');
          postAjax(ctx + '/clientUser/updateClientUser', postData, function (msg) {
            if (msg.resultCode == 1) {
              layer.close(index);
              layer.msg('编辑成功！', {icon: 1});
              //更新部门树
              getAjax(ctx + '/department/getDepartmentNodesByLoginUser', '', function (msg) {
                zNodes = JSON.parse(msg);
                var selectID = deptTree.getSelectedNodes()[0].id;
                deptTree.destroy();
                initDeptTree(selectID);
                initdeptTable(selectID);
              });
            } else {
              $(layero).find('.layui-layer-btn0').removeClass('btn-disabled');
              layer.msg('编辑失败！' + (msg.resultMsg || ''), {icon: 2});
            }
          });
        },
        success: function (layero, index) {
          var htmlpolicy = '';
          for (var i = 0; i < policyList.length; i++) {
            htmlpolicy += '<option value=' + policyList[i].id + '>' + policyList[i].name + '</option>';
          }
          $('#openWind select[name=selectPolicy]').html(htmlpolicy);
          var htmlusb = '';
          htmlusb +='<option value="-1"></option>';
          for (var i = 0; i < usbDeviceList.length; i++) {
            htmlusb += '<option value=' + usbDeviceList[i].id + '>' + usbDeviceList[i].name + '</option>';
          }
          $('#openWind select[name=usbKeyList]').html(htmlusb);
          var setting = {
            view: {
              dblClickExpand: false,
              showLine: true,
              showIcon: true
            },
            data: {
              simpleData: {
                enable: true
              }
            },
            callback: {
              onClick: function (event, treeId, treeNode) {
                $('#openWind .parent-dept').val(treeNode.name).attr('data-id', treeNode.id);
                $('#openWind .parent-dept-tree-box').slideUp('fast');
              }
            }
          };
          //部门树
          var zNodesBak = $.grep(zNodes, function (obj) {
            return obj.treePath.indexOf(',' + id + ',') < 0 && obj.id !== id;
          });
          parentDeptTree = $.fn.zTree.init($("#openWind .j-parent-dept-tree"), setting, zNodesBak);
          if (zNodesBak.length > 0) {
            var node = parentDeptTree.getNodeByParam('id', deptTree.getNodeByParam('id', id));
            if (node) {
              $('#' + node.tId + '_a').click();
            }
          }
          $('#openWind input[name=username]').val(deptTable.ajax.json().data[idx].username);
          $('#openWind input[name=truename]').val(deptTable.ajax.json().data[idx].truename);
          //校验
          $('#openWind .j-add-user-form').validate({
            rules: {
              username: {
                required: true,
              },
              truename: {
                required: true,
              },
              password: {
                required: true,
                minlength: 6
              },
              repassword: {
                equalTo: $('#openWind input[name=password]')
              },
              parentdept: {
                required: true,
              },
            }
          });
        }
      });
    })
    //批量修改策略
    .on('click', '#bar_policy_user', function () {
      var ids = [];
      if ($('.j-check-user:checked').length == 0) {
        layer.msg('请先选中用户！', {icon: 0});
        return;
      } else {
        ids = $('.j-check-user:checked').map(function (index, obj) {
          return $(obj).attr('data-id');
        }).toArray();
      }
      layer.open({
        id: 'openWind',
        type: 1,
        title: '批量修改策略',
        content: $('#temp_policy').html(),
        area: ['300px', '200px'],
        btn: ['确定', '取消'],
        yes: function (index, layero) {
          var postData = {};
          postData.ids = ids.join(',');
          postData.policyid = $('#openWind select[name=userSelectPolicy] option:selected').val();
          $.ajax({
            type: 'post',
            url: ctx + '/policy/batchUpdateClientUsersPolicy',//批量修改策略接口
            data: postData,
            success: function (msg) {
              if (msg.resultCode == '1') {
                deptTable.ajax.reload(function () {}, true);
                $('.j-check-user-all').prop('checked', false);
                layer.close(index);
                layer.msg('修改成功！', {icon: 1});
              } else {
                layer.msg('修改失败！', {icon: 2});
              }
            },
            error: function () {
              layer.msg('删除失败！', {icon: 2});
            }
          })

        },
        success: function (index, layero) {
          var htmlpolicy = '';
          for (var i = 0; i < policyList.length; i++) {
            htmlpolicy += '<option value=' + policyList[i].id + '>' + policyList[i].name + '</option>';
          }
          $('#openWind select[name=userSelectPolicy]').html(htmlpolicy);
        }
      });

    })
    //解绑usbkey
    .on('click', '.j-opt-hover-remove,#bar_relieve', function () {
      var ids = [];
      if ($(this).is('#bar_relieve')) {
        if ($('.j-check-user:checked').length == 0) {
          layer.msg('请先选中用户！', { icon: 0 });
          return;
        }
        else {
          ids = $('.j-check-user:checked').map(function (index, obj) {
            return $(obj).attr('data-id');
          }).toArray();
        }
      }
      else {
        ids.push($(this).attr('data-id'));
      }
      layer.confirm(ids.length > 1 ? '确定要解绑选中的用户吗？' : '确定要解绑该用户吗？', {
        btn: ['确定', '取消']
      }, function () {
        var postData = {};
        postData.clientUserId = ids.join(',');
        $.ajax({
          type: 'post',
          url: ctx + '/usbKey/unbindUsbKeyByClientUserId',
          data: postData,
          success: function (msg) {
            if (msg.resultCode == '1') {
              deptTable.ajax.reload(function () { }, true);
              $('.j-check-user-all').prop('checked', false);
              layer.msg('解绑成功！', { icon: 1 });
            } else {
              layer.msg('解绑失败！', { icon: 2 });
            }
          },
          error: function () {
            layer.msg('解绑失败！', { icon: 2 });
          }
        })
      });

    })
    //导出
    .on('click', '#bar_export', function () {
      var param = {
        searchstr: $('#bar_searchstr').val().trim(),//关键字
        pid: deptTree.getSelectedNodes()[0].id
      }
      window.location.href = ctx + '/department/exportxsl?' + $.param(param);
    })
    //显示与隐藏上级部门树
    .on('click', '.parent-dept', function () {
      if ($('#openWind .parent-dept-tree-box').css('display') == 'block') {
        $('#openWind .parent-dept-tree-box').slideUp('fast');
      }
      else {
        $('#openWind .parent-dept-tree-box').slideDown('fast');
      }
      return false;
    })
    //空白处点击收起上级部门树
    .on('click', '.parent-dept-tree-box', function () {
      return false;
    })
    //阻止收起上级部门树
    .on('click', '', function () {
      $('#openWind .parent-dept-tree-box').slideUp('fast');
    })
    //用户全选或取消全选
    .on('change', '.j-check-user-all', function () {
      $('.j-check-user').prop('checked', $(this).prop('checked'));
    })
    //用户单个选择或取消选择
    .on('change', '.j-check-user', function () {
      $('.j-check-user-all').prop('checked', $('.j-check-user').not(':checked').length == 0);
    })
    //用户名回车搜索
    .on('keydown', '#bar_searchstr', function (e) {
      if (e.keyCode == 13) {
        $('#bar_searchstr_icon').click();
      }
    })
    //用户名点击搜索
    .on('click', '#bar_searchstr_icon', function () {
      deptTable.settings()[0].ajax.data.searchstr = $('#bar_searchstr').val().trim();
      deptTable.ajax.reload();
    })
    //显示操作悬浮框
    .on('mouseover', '.table-opt-icon', function () {
      var offset = document.documentElement.clientHeight - $(this).offset().top;
      $(this).next().addClass('opt-hover-down');
      if (offset > $(this).next().outerHeight() + 70) {
        $(this).next().removeClass('opt-hover-down').addClass('opt-hover-up');
      }
    })
    //隐藏操作悬浮框
    .on('mouseleave', '.table-opt-box', function () {
      $(this).find('.opt-hover-box').removeClass('opt-hover-up opt-hover-down');
    })
    //密码强度验证
    .on('keyup', '#pass', function () {
      var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g");
      var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g");
      var enoughRegex = new RegExp("(?=.{6,}).*", "g");

      if (false == enoughRegex.test($(this).val())) {
        $('body #level').removeClass('pw-weak');
        $('body #level').removeClass('pw-medium');
        $('body #level').removeClass('pw-strong');
        $('body #level').addClass(' pw-defule');
        //密码小于六位的时候，密码强度图片都为灰色
      }
      else if (strongRegex.test($(this).val())) {
        $('body #level').removeClass('pw-weak');
        $('body #level').removeClass('pw-medium');
        $('body #level').removeClass('pw-strong');
        $('body #level').addClass(' pw-strong');
        //密码为八位及以上并且字母数字特殊字符三项都包括,强度最强
      }
      else if (mediumRegex.test($(this).val())) {
        $('body #level').removeClass('pw-weak');
        $('body #level').removeClass('pw-medium');
        $('body #level').removeClass('pw-strong');
        $('body #level').addClass(' pw-medium');
        //密码为七位及以上并且字母、数字、特殊字符三项中有两项，强度是中等
      }
      else {
        $('body #level').removeClass('pw-weak');
        $('body #level').removeClass('pw-medium');
        $('body #level').removeClass('pw-strong');
        $('body #level').addClass('pw-weak');
        //如果密码为6为及以下，就算字母、数字、特殊字符三项都包括，强度也是弱的
      }
      return true;
    })
}

/**
 * 初始化部门树
 *
 */
function initDeptTree(selectID) {
  var setting = {
    view: {
      dblClickExpand: false,
      showLine: true,
      showIcon: true
    },
    data: {
      simpleData: {
        enable: true
      }
    },
    callback: {
      onClick: function (event, treeId, treeNode, clickFlag) {
        initdeptTable(treeNode.id);
        $('.j-check-dept-all').prop('checked', false);
      }
    }
  };
  //部门树
  deptTree = $.fn.zTree.init($("#dept_tree"), setting, zNodes);
  if (zNodes.length > 0) {
    //点击第一个节点
    var node = deptTree.getNodeByParam('id', selectID) || deptTree.getNodeByParam('id', 1);
    if (node) {
      $('#' + node.tId + '_a').click();
      $('.j-edit-dept').css('display', 'inline-block');
    }
  }
  else {
    $('.j-edit-dept').css('display', 'none');
    $('#user_table').DataTable();
  }
}

/**
 * 子部门列表
 *
 */
function initdeptTable(pid) {
  if (deptTable) {
    deptTable.settings()[0].ajax.data.pid = pid;
    deptTable.settings()[0].ajax.data.searchstr = $('#bar_searchstr').val().trim();
    deptTable.ajax.reload();
    return;
  }
  deptTable = $('#user_table').DataTable({ //表格初始化
    "searching": true,//关闭Datatables的搜索功能:
    "destroy": true,//摧毁一个已经存在的Datatables，然后创建一个新的
    "retrieve": true, //检索已存在的Datatables实例,如果已经初始化了，则继续使用之前的Datatables实例
    "autoWidth": true,//自动计算列宽
    "processing": false,//是否显示正在处理的状态
    "stateSave": false, //开启或者禁用状态储存。当你开启了状态储存，Datatables会存储一个状态到浏览器上， 包含分页位置，每页显示的长度，过滤后的结果和排序。当用户重新刷新页面，表格的状态将会被设置为之前的设置。
    "serverSide": true,//服务器端处理模式——此模式下如：过滤、分页、排序的处理都放在服务器端进行。
    "scrollY": "auto",//控制表格的垂直滚动。
    /*l - Length changing 改变每页显示多少条数据的控件
     f - Filtering input 即时搜索框控件
     t - The Table 表格本身
     i - Information 表格相关信息控件
     p - Pagination 分页控件
     r - pRocessing 加载等待显示信息*/
    "dom": 'rlfrtip',
    "stateLoadParams": function (settings, data) { //状态加载完成之后，对数据处理的回调函数
    },
    "lengthMenu": [
      [20, 30, 50, 100],
      ["20条", "30条", "50条", "100条"]
    ],//定义在每页显示记录数的select中显示的选项
    "ajax": {
      "beforeSend": function () {
      },
      "url": ctx + "/clientUser/getClientUserPageByDepartmentId",
      //改变从服务器返回的数据给Datatable
      "dataSrc": function (json) {
        // console.log(json);
        return json.data.map(function (obj) {
          console.log(obj)
          return [obj.id, {username:obj.username,isusb:obj.isbindedUsbkey}, obj.truename, obj.policyname, obj.policyid || '--', obj.id]
        });
      },
      //将额外的参数添加到请求或修改需要被提交的数据对象
      "data": {
        "pid": pid,
        "searchstr": $('#bar_searchstr').val().trim()
      },
    },
    "columnDefs": [{
      "targets": [0],
      "orderable": false,
      "width": "35px",
      "class": "text-center",
      "render": function (data, type, full) {
        return '<div class="beauty-checkbox">' +
          '<input id="table_check_' + data + '" type="checkbox" class="j-check-user" data-id="' + data + '">' +
          '<label for="table_check_' + data + '" class="checkbox-icon"></label>' +
          '</div>';
      }
    }, {
      "targets": [1],
      "orderable": false,
      "class": "text-ellipsis",
      "render": function (data, type, full) {
        if(data.isusb == 1 ){
          return '<i class="iconfont icon-list-USB" style="position: absolute;left: 40px;"></i><span>'+data.username+'</span>';
        }else {
          return '<span>'+data.username+'</span>';
        }

      }
    }, {
      "targets": [2],
      "orderable": false,
      "class": "text-ellipsis"
    }, {
      "targets": [3],
      "orderable": false,
      "class": "text-ellipsis"
    }, {
      "targets": [4],
      "orderable": false,
      "class": "text-ellipsis"
    }, {
      "targets": [5],
      "orderable": false,
      "class": "center-text",
      "width": "80px",
      "render": function (data, type, full) {
        return template('temp_opt_box', {id: data});
      }
    }],
    //当每次表格重绘的时候触发一个操作，比如更新数据后或者创建新的元素
    "drawCallback": function (oTable) {
      var oTable = $("#user_table").dataTable();
      //设置每一列的title
      $("table").find("tr td:not(:last-child)").each(function (index, obj) {
        $(obj).attr("title", $(obj).text());
      })
      //添加跳转到指定页
      $(".dataTables_paginate").append("<span style='margin-left: 10px;font-size: 14px;'>到第 </span><input style='height:20px;line-height:28px;width:28px;margin-top: 5px;' class='margin text-center' id='changePage' type='text'> <span style='font-size: 14px;'>页</span>  <a class='shiny' href='javascript:void(0);' id='dataTable-btn'>确认</a>");
      $('#dataTable-btn').click(function (e) {
        if ($("#changePage").val() && $("#changePage").val() > 0) {
          var redirectpage = $("#changePage").val() - 1;
        } else {
          var redirectpage = 0;
        }
        oTable.fnPageChange(redirectpage);
      });

      //键盘事件  回车键 跳页
      $("#changePage").keydown(function () {
        var e = event || window.event;
        if (e && e.keyCode == 13) {
          if ($("#changePage").val() && $("#changePage").val() > 0) {
            var redirectpage = $("#changePage").val() - 1;
          } else {
            var redirectpage = 0;
          }
          oTable.fnPageChange(redirectpage);
        }
      })
    }
  }).on('xhr.dt', function (e, settings, json, xhr) {
    //登陆超时重定向
    if (xhr.getResponseHeader('isRedirect') == 'yes') {
      location.href = "/vdp/login";
    }
  });
}
//密码验证

