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



});
function initEvent() {
  $("body")
  //tab页导航
    .on("click", ".titleTab li", function () {
      $(this).addClass("titleTabactive").siblings("li").removeClass("titleTabactive");
      var classcon = $(this).data("class");
      $("." + classcon + "con").show().siblings("div").hide();
      initdeptTable();
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
          userId: id
        };
        postAjax(ctx + '/systemSetting/user/deleteUser', postData, function (msg) {
          if (msg.resultCode == 1) {
            accountTable.ajax.reload(function () {}, true);
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
          if(deptnodes.length==0||navnodes==0){
            layer.msg('部门或者功能权限必选！', {icon: 2});
            return;
          }
          var pass = $("#openWind input[name=password]").val();
          $("input[name=password]").val(encrypt(pass).toUpperCase());

          pass = $.trim(pass);
          $("input[name=departmentListStr]").val(getnodesrt(deptnodes));
          $("input[name=navigationListStr]").val(getnodesrt(navnodes));
          var temp = $("#openWind form").serialize();

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
          initDeptTree(0);

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
                required:true,
              },
              repassword: {
                equalTo: $('#openWind input[name=password]')
              },
              phone:{
                isPhone:true
              }
            }
          });
        }
      });
    })
    //编辑用户
    .on('click', '.j-opt-hover-edit', function () {
      var idx = $('.j-opt-hover-edit').index(this);
      // idx =idx+4;
      var id = $(this).attr('data-id');//这是账户的id
      var guid = $(this).attr('data-guid');//这是账户的id
      // if (id == 1 || id == 2 || id == 3 || id ==4) {
      //   layer.msg("内置管理员不能编辑", {icon: 2});
      //   return
      // }
      layer.open({
        id: 'openWind',//这个地方会自动给弹出框添加一个id
        type: 1,
        title: '编辑账户',
        content: $('#add_user_wind').html(),
        area: ['722px', '600px'],
        btn: ['确定', '取消'],
        yes: function (index, layero) {
          if (!$("#openWind .j-add-account-form").valid()) {
            return;
          }
          var deptnodes = depttreeobj.getCheckedNodes(true);
          var navnodes = navtreeobj.getCheckedNodes(true);
          if(deptnodes.length==0||navnodes==0){
            layer.msg('部门或者功能权限必选！', {icon: 2});
            return;
          }
          var pass = $("input[name=password]").val()
          $("input[name=password]").val(encrypt(pass).toUpperCase());
          $("input[name=repassword]").val(encrypt(pass).toUpperCase());
          $("input[name=departmentListStr]").val(getnodesrt(deptnodes));
          $("input[name=navigationListStr]").val(getnodesrt(navnodes));
          var temp = $("#openWind form").serialize();

          $.ajax({
            type: 'post',
            url: ctx + '/systemSetting/user/addOrUpdateUser',
            data: String(temp+'&id='+id+'&guid='+guid),
            success: function (msg) {
              console.log(msg);
              if (msg.resultCode == 1) {
                layer.close(index);
                accountTable.ajax.reload();
                layer.msg('修改成功！', {icon: 1});
              } else {
                layer.msg('修改失败！' + (msg.resultMsg || ''), {icon: 2});
                layer.close(index);
              }
            },
            error: function () {
              layer.msg('修改错误！' + (msg.resultMsg || ''), {icon: 2});
              layer.close(index);
            }
          })
        },
        success: function (layero, index) {
          initNavTree(1);
          // 部门权限树
          initDeptTree(id);
          $('#openWind input[name=userName]').val(accountTable.ajax.json().data[idx].userName);
          $('#openWind input[name=name]').val(accountTable.ajax.json().data[idx].name);
          $('#openWind input[name=phone]').val(accountTable.ajax.json().data[idx].phone);
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
              },
              repassword: {
                equalTo: $('#openWind input[name=password]')
              },
              phone:{
                isPhone:true
              }
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
    //获取文件名放到text上
    .on('change','input[type=file]',function(){
      var file=$(this).val();
      var filenames=getfilename(file);
      $(this).siblings('input[type=text]').val(filenames);
    })
    //点击上传升级文件
    .on('click','#updata',function(){
      if($("input#clientUpdataPath").val()==''){
        $("#clientUpdataTip").show();
        return
      }
      var formData = new FormData($("#updataform")[0]);
      $.ajax({
        url: ctx + "/systemSetting/uploadClientUpdate",
        type: "post",
        async: true,
        cache: false,
        contentType: false,
        processData: false,
        dataType: "json",
        data: formData,
        success: function (msg) {
          if (msg.resultCode == '1') {
            layer.msg("上传成功", {
              icon: 1,
              end: function () {
                // window.location.reload();
              }
            });
            $("#clientUpdataTip").hide();
          } else {
            layer.msg("上传失败！" + (msg.resultMsg || ''), { icon: 2 });
          }
        },
        error: function (e) {
          layer.msg("上传失败", { icon: 2 });
        }
      });
    })
    //点击上传升级文件
    .on('click','#install',function(){
      if($("input#clientInstallPath").val()==''){
        $("#clientInstallTip").show();
        return
      }
      var formData = new FormData($("#installform")[0]);
      $.ajax({
        url: ctx + "/systemSetting/uploadClientPackage",
        type: "post",
        async: true,
        cache: false,
        contentType: false,
        processData: false,
        dataType: "json",
        data: formData,
        success: function (msg) {
          if (msg.resultCode == '1') {
            layer.msg("上传成功", {
              icon: 1,
              end: function () {
              }
            });
          } else {
            layer.msg("上传失败！" + (msg.resultMsg || ''), { icon: 2 });
          }
        },
        error: function (e) {
          layer.msg("上传失败", { icon: 2 });
        }
      });
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
        console.log(json)
        return json.data.map(function (obj) {
          return [obj.name, obj.userName, obj.roleType, obj.readonly, obj.phone || '--', {id:obj.id,guid:obj.guid}];
        });
      },
      //将额外的参数添加到请求或修改需要被提交的数据对象
      "data": {
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
        return template('temp_opt_box', {id: data.id,guid:data.guid});
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
function initDeptTree(id) {
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
      }
    }
  };
  getAjax(ctx + '/department/getDepartmentTreeByUserId', {userId: id}, function (msg) {
    if (msg.resultCode == 1) {
      console.log(msg)
      var zNodes1 = eval(msg.data);
      if(deptTree){
        deptTree.destroy();
      }
      deptTree = $.fn.zTree.init($("body #depttree"), setting1, zNodes1);
      depttreeobj = $.fn.zTree.getZTreeObj("depttree");
      depttreeobj.expandAll(true);
    }
    else {
      layer.msg('获取部门列表失败', {icon: 2});
    }
  });
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
//获取文件名
function getfilename(filePath){
  var pos=filePath.lastIndexOf("\\");
  return filePath.substring(pos+1);
}
changeq("clientUpdataPath", "clientUpdata");
changeq("clientInstallPath", "clientInstall");

function changeq(a, b) {
  var copyFile = document.getElementById(a);
  var trueFile = document.getElementById(b);
  trueFile.onchange = function () {
    // 判断是不是火狐
    if (navigator.userAgent.indexOf('Firefox') >= 0) {
      copyFile.value = getFile(this);
    } else {
      copyFile.value = getFile(this).substring(12);
    }
  }
  function getFile(obj) {
    if (obj) {
      return obj.value;
    }
  }
}
