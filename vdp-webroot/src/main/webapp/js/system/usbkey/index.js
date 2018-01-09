/**
 * Created by chengl on 2018/1/8 0008.
 */
var userTable = null;
var deptTree = null;
var roleTypeData = null;//角色数据
$(function () {
  initUserTable();//用户表
  initEvents();//事件
  getRoleList()//获取权限列表
});
/**
 * 初始化事件
 *
 */
function initEvents() {
  $('body')
  //添加用户
    .on('click', '#bar_add_user', function () {
      layer.open({
        id: 'openWind',
        type: 1,
        title: '添加用户',
        content: $('#add_user_wind').html(),
        area: ['900px', '610px'],
        btn: ['确定', '取消'],
        yes: function (index, layero) {
          if (!$("#openWind form").valid()) {
            return;
          }
          var postData = $("#openWind form").serializeJSON();
          if (postData.password) {
            postData.password = encrypt(postData.password).toUpperCase();
          }
          delete postData.repassword;
          for (var key in postData) {
            if (postData[key].isEmpty()) {
              delete postData[key];
            }
          }
          var deptTreeNodes = $.grep(deptTree.getCheckedNodes(true), function (obj) {
            return !obj.getCheckStatus().half
          });
          if (deptTreeNodes.length == 0) {
            layer.msg('请选择部门！', { icon: 0 });
            return;
          }
          postData.dep = deptTreeNodes.map(function (obj) {
            return obj.id
          }).join(',');
          postAjax(ctx + '/user/addOrUpdateUser', postData, function (msg) {
            if (msg.resultCode == '1') {
              userTable.ajax.reload(function () { }, true);
              layer.close(index);
              layer.msg('添加成功！', { icon: 1 });
              $('.j-check-user-all').prop('checked', false);
            } else {
              layer.msg('添加失败！' + (msg.resultMsg || ''), { icon: 2 });
            }
          });
        },
        success: function (layero, index) {
          $('#openWind input[name=userName]').focus();
          //密码和重复密码添加必填标记
          $('#openWind input[name=password]').prev().addClass('label-required');
          $('#openWind input[name=repassword]').prev().addClass('label-required');
          var html = '';
          for (var i = 0; i < roleTypeData.length; i++) {
            html += '<option value=' + roleTypeData[i].id + '>' + roleTypeData[i].roleName + '</option>';
          }
          $('#openWind select[name=roleType]').html(html);
          var setting = {
            view: {
              dblClickExpand: false,
              showLine: true,
              showIcon: false
            },
            check: {
              enable: true,
              nocheckInherit: false,
              chkboxType: { "Y": "ps", "N": "ps" }
            },
            data: {
              simpleData: {
                enable: true
              }
            }
          };
          //部门树
          deptTree = $.fn.zTree.init($("#openWind .deptTree"), setting, zNodes);
          //选中未分组
          var node = deptTree.getNodeByParam("id", 2, null);
          deptTree.checkNode(node, true, true);
          deptTree.updateNode(node);
          //校验
          $('#openWind form').validate({
            rules: {
              userName: {
                required: true,
                isNeedString: true,
              },
              realName: {
                required: true
              },
              password: {
                required: true,
              },
              repassword: {
                required: true,
                equalTo: $('#openWind input[name=password]')
              },
              phone: {
                phone: true,
                required: true
              },
              email: {
                email: true
              },
              roleType: {
                required: true,
              },
              constableNumber: {
                sixnumber: true,
                required: true
              }
            },
            messages: {
              repassword: {
                equalTo: "两次密码不一致"
              }
            }
          });
        }
      });
    })
    //编辑用户
    .on('click', '.j-opt-hover-edit', function () {
      var userID = $(this).attr('data-id');
      var oldUserName = userTable.row($('.j-opt-hover-edit').index($(this))).data()[1];
      layer.open({
        id: 'openWind',
        type: 1,
        title: '编辑用户',
        content: $('#add_user_wind').html(),
        area: ['900px', '610px'],
        btn: ['确定', '取消'],
        yes: function (index, layero) {
          if (!$('#openWind .j-add-user-form').valid()) {
            return;
          }
          var postData = $("#openWind form").serializeJSON();
          if (postData.password) {
            postData.password = encrypt(postData.password).toUpperCase();
          }
          postData.id = userID;
          delete postData.repassword;
          for (var key in postData) {
            if (postData[key].isEmpty()) {
              delete postData[key];
            }
          }
          postData.flag = 2;//1新增，2修改
          var deptTreeNodes = $.grep(deptTree.getCheckedNodes(true), function (obj) {
            return !obj.getCheckStatus().half
          });
          if (deptTreeNodes.length == 0) {
            layer.msg('请选择部门！', { icon: 0 });
            return;
          }
          postData.dep = deptTreeNodes.map(function (obj) {
            return obj.id
          }).join(',');
          postAjax(ctx + '/user/addOrUpdateUser', postData, function (msg) {
            if (msg.resultCode == '1') {
              userTable.ajax.reload(function () { }, true);
              layer.close(index);
              if (postData.id == $('#top_user_name').attr('data-id')) {
                $('#top_user_name').text(postData.userName);
              }
              layer.msg('编辑成功！', { icon: 1 });
            } else {
              layer.msg('编辑失败！' + (msg.resultMsg || ''), { icon: 2 });
            }
          });
        },
        success: function (layero, index) {
          $('#openWind input[name=password]').focus();
          $('#openWind input[name=userName]').prop('disabled', true);
          var setting = {
            view: {
              dblClickExpand: false,
              showLine: true,
              showIcon: false
            },
            check: {
              enable: true,
              nocheckInherit: false,
              chkboxType: { "Y": "ps", "N": "ps" }
            },
            data: {
              simpleData: {
                enable: true
              }
            }
          };
          //部门树
          deptTree = $.fn.zTree.init($("#openWind .deptTree"), setting, zNodes);

          var html = '';
          for (var i = 0; i < roleTypeData.length; i++) {
            html += '<option value=' + roleTypeData[i].id + '>' + roleTypeData[i].roleName + '</option>';
          }
          $('#openWind select[name=roleType]').html(html);
          //获取用户信息
          $.ajax({
            type: 'post',
            url: ctx + '/user/getUser',
            data: {
              userId: userID
            },
            success: function (user) {
              $('#openWind input[name=userName]').val(user.bean.userName);
              $('#openWind input[name=realName]').val(user.bean.realName);
              $('#openWind input[name=phone]').val(user.bean.phone);
              $('#openWind input[name=email]').val(user.bean.email);
              $('#openWind input[name=constableNumber]').val(user.bean.constableNumber);
              $('#openWind select[name=roleType]').val(user.bean.roleType);
              //选中已有的部门权限
              for (var i = 0; i < user.udlist.length; i++) {
                var node = deptTree.getNodeByParam("id", user.udlist[i].departmentId, null);
                deptTree.checkNode(node, true, true);
                deptTree.updateNode(node);
              }
            },
            error: function () {
              layer.msg('获取用户信息失败！', { icon: 2 });
            }
          })

          //校验
          $('#openWind form').validate({
            rules: {
              realName: {
                required: true
              },
              password: {},
              repassword: {
                equalTo: $('#openWind input[name=password]')
              },
              phone: {
                phone: true,
                required: true
              },
              email: {
                email: true
              },
              roleType: {
                required: true,
              },
              constableNumber: {
                sixnumber: true,
                required: true
              }
            },
            messages: {
              repassword: {
                equalTo: "两次密码不一致"
              }
            }
          });
        }
      });
    })
    //删除用户
    .on('click', '.j-opt-hover-delete,#bar_del_user', function () {
      var ids = [];
      if ($(this).is('#bar_del_user')) {
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
      layer.confirm(ids.length > 1 ? '确定要删除选中的用户吗？' : '确定要删除该用户吗？', {
        btn: ['确定', '取消']
      }, function () {
        var postData = {}
        postData.ids = ids.join(',');
        $.ajax({
          type: 'post',
          url: ctx + '/user/deleteUser',
          data: postData,
          success: function (msg) {
            if (msg === 'success') {
              userTable.ajax.reload(function () { }, true);
              $('.j-check-user-all').prop('checked', false);
              layer.msg('删除成功！', { icon: 1 });
            } else {
              layer.msg('删除失败！', { icon: 2 });
            }
          },
          error: function () {
            layer.msg('删除失败！', { icon: 2 });
          }
        })
      });

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
      userTable.settings()[0].ajax.data.searchstr = $('#bar_searchstr').val().trim();
      userTable.ajax.reload();
    })
    //角色切换搜索
    .on('change', '#bar_select_role', function () {
      userTable.settings()[0].ajax.data.roleType = $(this).val();
      userTable.ajax.reload();
    })
    //导出
    .on('click', '#bar_export_user', function () {
      var param = {
        searchstr: $('#bar_searchstr').val().trim(),
        roleType: $('#bar_select_role').val()
      }
      window.location.href = ctx + '/user/exportxsl?' + $.param(param);
    })
}
/**
 * 获取权限列表
 *
 */
function getRoleList() {
  getAjax(ctx + '/role/getRoleList', '', function (msg) {
    if (msg.resultCode == 1) {
      roleTypeData = msg.data;
      var html = '';
      $.each(msg.data, function (index, obj) {
        html += '<option value=' + obj.id + '>' + obj.roleName + '</option>';
      });
      $('#bar_select_role').append(html);
    }
    else {
      layer.msg('获取权限列表失败！', { icon: 2 });
    }
  });
}
/**
 * 用户表
 *
 */
function initUserTable() {
  userTable = $('#userTable').DataTable({ //表格初始化
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
      data.search.search = "";
    },
    "order": [[1, "asc"]],
    "lengthMenu": [
      [20, 30, 50, 100],
      ["20条", "30条", "50条", "100条"]
    ],//定义在每页显示记录数的select中显示的选项
    "ajax": {
      "beforeSend": function () {
      },
      "url": ctx + "/user/datalist",
      //改变从服务器返回的数据给Datatable
      "dataSrc": function (json) {
        return json.data.map(function (obj) {
          return [obj.id, obj.userName, obj.departmentList, obj.roleName, obj.realName, obj.constableNumber, obj.phone, obj.email, obj.id];
        });
      },
      //将额外的参数添加到请求或修改需要被提交的数据对象
      "data": {
        "searchstr": '',
        'roleType': ''
      },
      "complete": function () {
        $('.j-check-user-all').prop('checked', false);
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
      "orderable": true,
      "class": "text-ellipsis"
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
      "class": "text-ellipsis"
    }, {
      "targets": [6],
      "orderable": false,
      "width": "180px",
      "class": "text-ellipsis"
    }, {
      "targets": [7],
      "orderable": false,
      "width": "180px",
      "class": "text-ellipsis"
    }, {
      "targets": [8],
      "orderable": false,
      "width": "80px",
      "class": "center-text",
      "render": function (data, type, full) {
        return template('temp_opt_box', { id: data });
      }
    }],
    //当每次表格重绘的时候触发一个操作，比如更新数据后或者创建新的元素
    "drawCallback": function (oTable) {
      var oTable = $("#userTable").dataTable();
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
      location.href = "/drs/login";
    }
  });
}
