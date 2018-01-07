/**
 * Created by chengl on 2018/1/5 0005.
 */
var accountTable = null;
var deptTree = null;
var navTree = null;
var depttreeobj = null;
var navtreeobj=null;
$(function () {
  initEvent();
  initdeptTable();


});
function initEvent() {
  $("body")
  //tab页导航
    .on("click", ".titleTab li", function () {
      $(this).addClass("titleTabactive").siblings("li").removeClass("titleTabactive");
      var classcon = $(this).data("class");
      $("." + classcon + "con").show().siblings("div").hide();

    })
    //删除用户
    .on('click', '.j-opt-hover-delete', function () {
      var id = $(this).attr('data-id');
      if (id == 1 || id == 2 || id == 3) {
        layer.msg("内置管理员不能删除", {icon: 2});
        return
      }
      layer.confirm('确定要删除该账户吗？', {
        btn: ['确定', '取消']
      }, function () {
        var postData = {
          id: id
        };
        postAjax(ctx + '/clientUser/deleteClientUser', postData, function (msg) {
          if (msg.resultCode == 1) {
            accountTable.ajax.reload(function () {
            }, true);
            layer.msg('删除成功！', {icon: 1});
          }
          else {
            layer.msg('删除失败！' + (msg.resultMsg || ''), {icon: 2});
          }
        });
      });
    })
    //添加用户
    .on('click', '#bar_add_account', function () {
      layer.open({
        id: 'openWind',
        type: 1,
        title: '添加账户',
        content: $('#add_user_wind').html(),
        area: ['722px', '600px'],
        btn: ['确定', '取消'],
        yes: function (index, layero) {
          if (!$("#openWind .j-add-account-form").valid()) {
            return;
          }
          var deptnodes = depttreeobj.getCheckedNodes(true);
          var navnodes = navtreeobj.getCheckedNodes(true);
          var pass = $("input[name=password]").val()
          $("input[name=password]").val(encrypt(pass).toUpperCase())

          $("input[name=departmentListStr]").val(getnodesrt(deptnodes))
          $("input[name=navigationListStr]").val(getnodesrt(navnodes));
          var temp = $("#openWind form").serialize();
          console.log(temp);

          $.ajax({
            type: 'post',
            url: ctx + '/systemSetting/user/addOrUpdateUser',
            data: $("#openWind form").serialize(),
            success: function (msg) {
              if (msg.resultCode == 1) {
                layer.close(index);
                accountTable.ajax.reload();
                layer.msg('添加成功！', {icon: 1});
              } else {
                layer.msg('添加失败！' + (msg.resultMsg || ''), {icon: 2});
              }
            },
            error: function () {
              layer.msg('添加失败！' + (msg.resultMsg || ''), {icon: 2});
            }
          })
        },
        success: function (layero, index) {
          initNavTree(1);
          // 部门权限树
          initDeptTree();

          // 校验
          $('#openWind .j-add-account-form').validate({
            rules: {
              username: {
                required: true,
              },
              name: {
                required: true,
              },
              password: {
                required: true,
                minlength: 6
              },
              repassword: {
                equalTo: $('#openWind input[name=password]')
              },
              phone: {
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
          htmlusb += '<option value="-1"></option>';
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
    //切换不同账户的导航权限
    .on('change','#openWind #systemauthlist',function(){
      var value = $("#openWind #systemauthlist").find("option:selected").val();
      initNavTree(Number(value));
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
}
//账户用户表
function initdeptTable() {
  if (accountTable) {
    accountTable.ajax.reload();
    return;
  }
  accountTable = $('#accountTable').DataTable({ //表格初始化
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
      "url": ctx + "/systemSetting/user/getUserPages",
      //改变从服务器返回的数据给Datatable
      "dataSrc": function (json) {
        // console.log(json);
        return json.data.map(function (obj) {
          return [obj.name, obj.userName, obj.roleType, obj.readonly, obj.phone || '--', obj.id];
        });
      },
      //将额外的参数添加到请求或修改需要被提交的数据对象
      "data": {
        // "pid": pid,
        // "searchstr": $('#bar_searchstr').val().trim()
      },
    },
    "columnDefs": [{
      "targets": [0],
      "orderable": false,
      "class": "text-ellipsis",

    }, {
      "targets": [1],
      "orderable": false,
      "class": "text-ellipsis"
    }, {
      "targets": [2],
      "orderable": false,
      "class": "text-ellipsis",
      "render": function (data, type, full) {
        if (data == 0) {
          return '<span>超级管理员</span>';
        } else if (data == 1) {
          return '<span>系统管理员</span>';
        } else if (data == 2) {
          return '<span>系统操作员</span>';
        } else if (data == 3) {
          return '<span>系统审计员</span>';
        }
      }
    }, {
      "targets": [3],
      "orderable": false,
      "class": "text-ellipsis",
      "render": function (data, type, full) {
        if (data == 0) {
          return '<span>读写权限</span>';
        } else if (data == 1) {
          return '<span>只读权限</span>';
        }
      }
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
      var oTable = $("#accountTable").dataTable();
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
//获取所有部门表
function initDeptTree() {
  var setting1 = {
    view: {
      dblClickExpand: false,
      showLine: true,
      showIcon: false
    },
    check: {
      enable: true,
      nocheckInherit: false
    },
    data: {
      simpleData: {
        enable: true
      }
    },
    callback: {
      onClick: function (event, treeId, treeNode) {
        // console.log(treeNode)
        // //var level = treeNode.level;
        // //console.log("leveladd----------" + level)
        // //$('#curLevel').val(treeNode.level);
        // $('#department2').val(treeNode.id)
        // $("#departmentTreeDiv2").show();
      }
    }
  };
  console.log(zNodes1);
  deptTree = $.fn.zTree.init($("body #depttree"), setting1, zNodes1);
  depttreeobj = $.fn.zTree.getZTreeObj("depttree");
}
//获取所有权限tree
function initNavTree(id) {
  // 获取权限树
  var setting2 = {
    view: {
      dblClickExpand: false,
      showLine: true,
      showIcon: false
    },
    check: {
      enable: true,
      nocheckInherit: false
    },
    data: {
      simpleData: {
        enable: true
      }
    },
    callback: {
      onClick: function (event, treeId, treeNode) {
        // console.log(treeNode)
        // //var level = treeNode.level;
        // //console.log("leveladd----------" + level)
        // //$('#curLevel').val(treeNode.level);
        // $('#department2').val(treeNode.id)
        // $("#departmentTreeDiv2").show();
      }
    }
  };
  getAjax(ctx + '/system/navigation/getNavigationListByRoleType', {roleType: id}, function (msg) {
    if (msg.resultCode == 1) {
      console.log(msg)
      var navzNodes = eval(msg.data);
      if(navTree){
        navTree.destroy();
      }
      navTree = $.fn.zTree.init($("body #navtree"), setting2, navzNodes);
      navtreeobj = $.fn.zTree.getZTreeObj("navtree");
      navtreeobj.expandAll(true);
    }
    else {
      layer.msg('获取权限失败', {icon: 2});
    }
  });

}
//获取tree的字符串字段
function getnodesrt(nodes){
  var nodestr='';
  for (var i=0;i<nodes.length;i++){
    if(i==nodes.length-1){
      nodestr+=nodes[i].id
    }else {
      nodestr+=nodes[i].id+','
    }
  }
  return nodestr;
}
