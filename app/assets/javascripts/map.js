map = null;
function show_map(id,point){
  if(map == null){
    map = new BMap.Map(id);          // 创建地图实例
    var opts = {type: BMAP_NAVIGATION_CONTROL_LARGE};
    map.addControl(new BMap.NavigationControl(opts));
    map.centerAndZoom(point, 15);                 // 初始化地图，设置中心点坐标和地图级别
  }
}

function add_marker(pos){
  //    var marker = new BMap.Marker(point);        // 创建标注  
  //    marker.enableDragging();  
  //    marker.addEventListener("dragend", function(e){  
  //     alert("当前位置：" + e.point.lng + ", " + e.point.lat);  
  //    })  
  //    map.addOverlay(marker);                     // 将标注添加到地图中
}

function bind_click_for_form(){
  map.addEventListener("dblclick", function(e){  
    marker_for_form(e.point);
    marker_to_address(e.point);
  });
}

function bind_autocomplete(address_input_id){
  var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
      {
        "input" : address_input_id,
      "location" : map
      });
  ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
    var _value = e.item.value;
    var myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business
    marker_address(myValue);
  });
}

marker_form = null
function marker_for_form(point){
  if(marker_form == null){
    marker_form = new BMap.Marker(point);        // 创建标注  
    map.addOverlay(marker_form);// 将标注添加到地图中
    map.panTo(point);
  }
  else{
    marker_form.setPosition(point)
  }
  $('#activity_lat').val(point.lat);
  $('#activity_lng').val(point.lng);
}

myGeo = null;
function get_geo(){
  if(myGeo == null)
    myGeo = new BMap.Geocoder();// 将地址解析结果显示在地图上,并调整地图视野
  return myGeo;
}

function marker_address(address){
  get_geo().getPoint(address, function(point){
    if (point) {
      marker_for_form(point);
    }
  });
  infoWindow.close();
}

function marker_to_address(point){
  get_geo().getLocation(point, function(result){
    if (result){
      $('#activity_address').val(result.address);
    }
  });
}

function new_init_map(p_point){
  var geo = navigator.geolocation;
  geo.getCurrentPosition(function (pos) {//成功获取时执行
    var coord = pos.coords,        //坐标detail
    accuracy = coord.accuracy,    //精准度，单位为米
    latitude = coord.latitude,       //纬度
    longitude = coord.longitude,  //经度
    altitudeAccuracy = coord.altitudeAccuracy,        //高度精确度，单位为米
    heading = coord.heading,        //移动的方向
    speed = coord.speed;        //速度
  var point = new BMap.Point(coord.longitude, coord.latitude);  // 创建点坐标
  init_form_map('activity_address',point)
  },
  function (error) {//获取失败时执行
    console.log(error);
    init_form_map('activity_address',p_point)
  });
}

function edit_init_map(lat,lng){
  var point = new BMap.Point(lng, lat);  // 创建点坐标
  init_form_map('activity_address',point)

    marker_form = new BMap.Marker(point);        // 创建标注  
  map.addOverlay(marker_form);                     // 将标注添加到地图中
}

function init_form_info_window(){
    map.disableDoubleClickZoom();
    var opts = {  
      title : "<h3>请点击选择活动地点</h3>"  // 信息窗口标题  
    }  
    infoWindow = new BMap.InfoWindow("<span class='red'>双击</span>选择地点", opts);  // 创建信息窗口对象  
    map.openInfoWindow(infoWindow, map.getCenter());      // 打开信息窗口  

}

function init_form_map(id,point){
  show_map('bmap',point);        //显示google地图
  init_form_info_window()
  bind_click_for_form();
  bind_autocomplete(id)
}

function show_init_map(lat,lng){
  var point = new BMap.Point(lng, lat);  // 创建点坐标
  show_map('bmap',point);        //显示google地图
  marker_for_form(point);
  map.setZoom(17);
}

