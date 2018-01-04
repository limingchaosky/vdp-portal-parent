<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<!-- menu.jsp -->

<div id="menus">
    <div id="wlogo"></div>
    <div id="menubtn"></div>
    <div id="menulist">
        <ul class="mul0">
            <c:forEach items="${navigationlist}" var="nav">
                <c:choose>
                    <c:when test="${nav.nLevel==1&&nav.url!=null&&nav.url!=''}">
                        <li class="mli0">
                            <a href="${ctx}${nav.url}" class="ma0"><span class="mname ${nav.iconUrl} namehide">${nav.title}</span></a>
                        </li>
                    </c:when>
                    <c:when test="${nav.nLevel==1 && nav.title == '策略'}">
                        <li class="mli0">
                            <a href="javascript:void(0)" class="ma0"><span class="mname ${nav.iconUrl} namehide">${nav.title}</span></a>
                            <ul class="mul1">
                                <div class="listhover"></div>
                                <li class="mli1">
                                    <a class="ma1" href="#" onclick="newPolicy()">新建</a>
                                </li>
                                <c:forEach items="${policyList}" var="policy">
                                    <li class="mli1">
                                        <a class="ma1" href="#">${policy.name}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:when>
                    <c:when test="${nav.nLevel==1}">
                        <li class="mli0">
                            <a href="javascript:void(0)" class="ma0"><span class="mname ${nav.iconUrl} namehide">${nav.title}</span></a>
                            <ul class="mul1">
                                <div class="listhover"></div>
                                <c:forEach items="${navigationlist}" var="navsec">
                                    <c:if test="${navsec.parentId==nav.id}">
                                        <li class="mli1">
                                            <c:choose>
                                                <c:when test="${navsec.url!=null&&navsec.url!=''}">
                                                    <a class="ma1" href="${ctx}${navsec.url}">${navsec.title}</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a class="ma1" href="javaScript:void(0);">${navsec.title}</a>
                                                    <ul class="mul2">
                                                        <div class="listhover2"></div>
                                                        <c:forEach items="${navigationlist}" var="navthr">
                                                            <c:if test="${navthr.parentId==navsec.id}">
                                                                <li class="mli2">
                                                                    <a class="ma2" href="${ctx}${navthr.url}">${navthr.title}</a>
                                                                </li>
                                                            </c:if>
                                                        </c:forEach>
                                                    </ul>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </ul>
    </div>
</div>
<script id="new_policy" type="text/html">
    <div class="wind-row cf">
        <label for="" class="wind-label label-required">策略名</label>
        <input type="text" class="form-input wind-normal-input" name="policyname" maxlength="20">
    </div>
    <div class="wind-row cf">
        <label for="" class="wind-label label-required">继承自</label>
        <select class="wind-input valid" name="userSelectPolicy" aria-invalid="false">

        </select>
    </div>

</script>
<script type="text/javascript">
  var policylist=null;
  $(function () {
alert(1111);
    getPolicyList();



    var path = '${pageContext.request.contextPath}';
    var ctxImg = '${ctxImg}';
    bgurl = "url('${ctxImg}/leftmenu/logo.png')";
    $('#wlogo').css({
      width: '100%',
      height: '50px',
      backgroundImage: bgurl,
      backgroundRepeat: 'no-repeat',
      backgroundPositionY: '5px'
    });
  });

  function newPolicy() {
    layer.open({
      id: 'openWind',
      type: 1,
      title: '新建策略',
      content: $('#new_policy').html(),
      area: ['500px', '300px'],
      btn: ['确定', '取消'],
      yes: function (index, layero) {
        var postData = {};
        postData.name = $('#openWind input[name=policyname]').val();
        postData.pid = $('#openWind select[name=userSelectPolicy] option:selected').val();
        console.log(postData);
        $.ajax({
          type: 'post',
          url:'${ctx}/policy/addPolicy',//新建策略接口
          data: postData,
          success: function (msg) {
            console.log(msg)
            if (msg.resultCode == '1') {
              layer.close(index);
              layer.msg('新建成功！', {icon: 1});
            } else {
              layer.msg('新建失败！', {icon: 2});
            }
          },
          error: function () {
            layer.msg('新建失败！', {icon: 2});
          }
        })

      },
      success: function (index, layero) {
        var htmlpolicy = '';
        for (var i = 0; i < policylist.length; i++) {
          htmlpolicy += '<option value=' + policylist[i].id + '>' + policylist[i].name + '</option>';
        }
        $('#openWind select[name=userSelectPolicy]').html(htmlpolicy);
      }
    });

  }

  function getPolicyList() {
    alert(11111)
    getAjax(ctx + '/policy/getAllPolicys', '', function (msg) {
      alert(22222)

      if (msg.resultCode == 1) {
        policylist = msg.data;
        console.log(policylist);
      }
      else {
        layer.msg('获取权限列表失败！', {icon: 2});
      }
    });
  }


</script>
