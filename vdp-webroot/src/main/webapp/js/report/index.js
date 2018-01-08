/**
 * Created by chengl on 2018/1/4 0004.
 */
var exportReportChart = '';//数据导出报表
var exportReportOpt = '';//当前正在访问的人数量配置

$(function () {
  getExportReport();//当前访问人数信息
  // getUserData();//获取用户数据先不用
  initEvents(); //初始化事件
});
/**
 * 初始化事件
 *
 */
function initEvents() {
  //窗口缩放调整图表
  $(window).resize(function () {
    if (exportReportChart) {
      exportReportChart.resize();
    }
  });
  ininDateTimePicker()

}
// 获取正在访问人数的信息
function getExportReport(){
  exportReportChart = echarts.init(document.getElementById('exportReport'));

  exportReportChart.setOption(exportReportOpt);
}

exportReportOpt={
  color: ['#3398DB'],
  tooltip : {
    trigger: 'axis',
    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
      type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
    }
  },
  grid: {
    left: '3%',
    right: '4%',
    bottom: '3%',
    containLabel: true
  },
  xAxis : [
    {
      type : 'category',
      data : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      axisTick: {
        alignWithLabel: true
      }
    }
  ],
  yAxis : [
    {
      type : 'value'
    }
  ],
  series : [
    {
      name:'直接访问',
      type:'bar',
      barWidth: '60%',
      data:[10, 52, 200, 334, 390, 330, 220]
    }
  ]
};




/**
 * 初始化时间控件
 * @return {[type]} [description]
 */
function ininDateTimePicker() {
  $('#timechange').val(new Date().Format('yyyy-MM-dd')).datetimepicker({
    language: 'zh-CN',
    format: 'yyyy-mm-dd',
    autoclose: true,
    minView: 2,
    todayBtn: true,
    endDate: new Date()
  })
    .on('changeDate', function(ev){
      startTime = $.trim($("#timechange").val());
      getEcharsData();
      initReportTable();
    }).on('hide', function () {
    setTimeout(function () {
      $('#timechange').blur();
    }, 50);
  });
}