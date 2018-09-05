<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>全国农业市场信息大数据分析平台</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" CONTENT="Wed, 26 Feb 2016 08:21:57 GMT">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="shortcut icon" href="images/yn.png" />
	<link rel="stylesheet" type="text/css" href="css/common.css" />
	<link href="css/index.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="css/nongye_price.css" />
	<link href="css/tab.css" rel="stylesheet" type="text/css">

	<style type="text/css">
		#se {
			position: absolute;
			top: 220px;
			margin: 20px auto 0px;
			width: 800px;
			height: 250px;
			left: 122px;
		}
		#type {
			position: absolute;
			top: 230px;
			margin: 20px auto 0px;
			width: 400px;
			height: 250px;
			left: 798px
		}
		#type a {
			position: absolute;
			padding: 3px 6px;
			font-family: Microsoft YaHei;
			color: #fff;
			TOP: 0px;
			font-weight: bold;
			text-decoration: none;
			left: 0px
		}
		#type a:hover {
			border: #eee 1px solid;
		}
		#type .red {
			color: black
		}
		#highcharts-8{
			top:40px;
		}
		.price_3{
			width:1200px;
		}
		.content_left{
			float:left;
			width:49%;
			margin-left:8px;
			border-right: 1px solid #dfdfdf;
			border-top:1px solid #dfdfdf;
		}
		.content_right{
			float:left;
			width:49%;
			border-top:1px solid #dfdfdf;
		}
		.content h3{
			/* margin-left:30px; */
			text-align: center;
			margin-top:20px;
		}
		.kind_nav{
			display: flex;
			width: 1180px;
			height: 180px;
		}
		.kind_nav>li{
			flex:1 1 auto;
			width: 160px;
			height: 180px;
		}
        #MarketCount,#TypeCount,#NameCount,#DrawCount,#todayDrawCount,#Time{
            font-size: 30px;
            margin-top: 70px;
            color: #FFCC33;
        }
		#pie{
			flex:1 1 auto;
			width: 100%;
			height: 400px;
		}
		#ndgr{
			flex:1 1 auto;
			width: 100%;
			height: 400px;
		}
	</style>
</head>
<body>
<!----------------------------- 导航栏部分----------------------- -->
<div id="type-dialogBox"></div>
<div class="top_t">
	<div class="top_tittle">
		<div class="logo" style="font-size: 22px">
			<font color="white">全国农业市场信息大数据分析平台 </font>
		</div>
		<span style="display: none"> </span>
		<c:if test="${user!=null }">
			<div class="login_register" style="font-size: 12px">
				<a href="./user.do?method=quit">退出系统</a>
			</div>
		</c:if>
		<c:if test="${user==null }">
			<div class="login_register" style="font-size: 12px">
				<a href="javascript:" onclick="loginUser()">登录系统</a>
			</div>
		</c:if>
		<div class="nav">
			<ul>
				<li><a href="./index.jsp">首页</a></li>
				<li><a href="./control.jsp" class="nav_aclick">数据监控</a></li>
				<li><a href="./contrast.jsp" >数据查询</a></li>
				<li><a href="./forecast.jsp">价格预测</a></li>
				<li><a href="./EnterpriseMap.jsp">企业地图</a></li>
			</ul>
		</div>
	</div>
</div>
<!------------------------------- 结束 ----------------------------->
<div class="main">
	<div class="main_center">
		<!-- -------------当天数据查询监控---------------  -->
		<div class="price_1">
			<div class="title">
				<!-- <br />
                <h2>
                    <font color="black" size="4" ><b>实时监控</b>
                    </font>
                </h2> -->
				<div id="box">
					<ul id="tab">
						<li class="two on" id="tab_1" onClick="switchTab(this,0)">实时监控</li>
						<li class="two" id="tab_2" onClick="switchTab(this,1)">抓取量查询</li>
					</ul>
				</div>
			</div>
			<div class="content box_content_block">
				<ul class="kind_nav">
					<li class="li_long li_first" >
						<div class="name">市场总数</div>
                        <div id="MarketCount"></div>
					</li>
					<li class="li_long">
						<div class="name">品类总数</div>
                        <div id="TypeCount"></div>
					</li>
					<li class="li_long">
						<div class="name">品种总数</div>
						<div id="NameCount"></div>
					</li>
					<li class="li_long">
						<div class="name">总抓取量</div>
						<div id="DrawCount"></div>
					</li>
					<li class="li_long">
						<div class="name">当天抓取量</div>
						<div id="todayDrawCount"></div>
					</li>
					<li class="li_long">
						<div class="name">抓取时间</div>
						<div id="Time"></div>
					</li>

				</ul>
				<!------------------------- 结束 -------------------------->
				<!----------------品种排行榜---------------  -->
				<div class="Top_Record" >
                    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#d8d8d8" class="m_t_5">
                    <tr>
                        <td width="20%" height="30" align="center" bgcolor="#FFFFFF" class="B">种类</td>
                        <td width="35%" height="30" align="center" bgcolor="#FFFFFF" class="B">市场</td>
                        <td width="15%" height="30" align="center" bgcolor="#FFFFFF" class="B">价格(元/斤)</td>
                        <td width="30%" height="30" align="center" bgcolor="#FFFFFF" class="B">日期</td>
                    </tr>
                    </table>
                    <td height="30" colspan="5" valign="top">
                        <table width="100%" border="0" align="center" id="show" cellpadding="0" cellspacing="0" class="f_s_14">

                        </table>
                        <table width="60%" align="right">
                            <tr>
								<td>
									<div id="barcon" name="barcon">
                                        <a id="h_text"></a>
                                        <br>
                                        <a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                                        <a href="" id="up" ></a>
                                        <a href="" id="down"></a>
                                    </div>
								</td>
							</tr>
                        </table>
                    </td>
                </div>
			</div>

			<div class="content box_content_hidden">
				<div class="search">
					<div class="fields">
						<label style="font-size:15px;">省份:</label>
						<select name="province" style="width: 160px;height:30px;"
								tabindex="2" id="province">
							<option value=1 selected="selected" >请选择</option>
							<option value=2>新疆</option>
							<option value=3>江苏</option>
							<option value=4>江西</option>
							<option value=5>河北</option>
							<option value=6>河南</option>
							<option value=7>浙江</option>
							<option value=8>山东</option>
							<option value=9>山西</option>
							<option value=10>广东</option>
							<option value=11>广西</option>
							<option value=12>海南</option>
							<option value=13>湖北</option>
							<option value=14>湖南</option>
							<option value=15>甘肃</option>
							<option value=16>福建</option>
							<option value=17>贵州</option>
							<option value=18>辽宁</option>
							<option value=19>重庆</option>
							<option value=20>陕西</option>
							<option value=21>青海</option>
							<option value=22>黑龙江</option>
							<option value=23>上海</option>
							<option value=24>云南</option>
							<option value=25>内蒙古</option>
							<option value=26>北京</option>
							<option value=27>吉林</option>
							<option value=28>四川</option>
							<option value=29>天津</option>
							<option value=30>宁夏</option>
							<option value=31>安徽</option>
						</select>

						<label style="font-size:15px;">市场:</label>
						<select name="country" style="width: 240px;height:30px;"
								tabindex="2" id="market">
							<option value=1 selected="selected">请选择</option>
						</select>

						<label style="font-size:15px;">品类:</label>
						<select name="type" style="width:160px;height:30px;"
								id="typeMarket" tabindex="2">
							<option value=1 selected="selected">请选择</option>
						</select>
						<input type="button" value="开始查询"
							   class="search_btn" id="queryButton"
						/>
					</div>
				</div>
				<div class="content_left">
					<h3>
						<font color="black" >抓取数量
						</font>
					</h3>
					<!--------------数据查询的部分 ---------------->
					<div id="pie" ></div>
				</div>
				<div class="content_right">
					<h3>
						<font color="black" >所占记录数
						</font>
					</h3>
					<div id="ndgr" style="" ></div>
				</div>
			</div>
		</div>
		<jsp:include page="bottom.jsp"></jsp:include>
	</div>

</div>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript"  src="js/script.js"></script>
<script type="text/javascript" src="js/highcharts.js"></script>
<script type="text/javascript" src="js/echarts.js"></script>
<!-- <script type="text/javascript" src="js/exporting.js"></script> -->
<script type="text/javascript" src="js/radialIndicator.min.js"></script>
<!-- <script type="text/javascript" src="js/jquery.dialogBox.js"></script>
 -->
<script type="text/javascript">
    /**
     *  tab切换
     */
    function switchTab(obj,i){
        $(obj).addClass("on");
        $(obj).siblings().removeClass("on");
        $(".content").eq(i).removeClass("box_content_hidden").addClass("box_content_block");
        $(".content").eq(i).siblings().removeClass("box_content_block").addClass("box_content_hidden");
    }
</script>



<script>
    window.onload = function (ev) {
        //   执行函数，获得data
        var mydata = JSON.parse(localStorage.getItem('mydata'));

        function GetMonitorData() {
            $.ajax({
                type: "GET",
                url: "http://localhost:8080/agriculture/AllData",
                success: function (data) {
                    data=data.substring(1,data.length-1);
                    console.log(data);
                    var arrayAllData = data.split(",");
                    console.log(arrayAllData);
                    document.getElementById("MarketCount").innerText=arrayAllData[0];
                    document.getElementById("TypeCount").innerText=arrayAllData[1];
                    document.getElementById("NameCount").innerText=arrayAllData[2];
                    document.getElementById("DrawCount").innerText=arrayAllData[3];
                    document.getElementById("todayDrawCount").innerText=arrayAllData[4];
                    document.getElementById("Time").innerText=arrayAllData[5];

                }
            }
        )}
        GetMonitorData();

        function showTable(data) {
            var flagment = document.createDocumentFragment();
            for (var i = 0; i < data.length; i++) {
                var templi = document.createElement('tr');

                var tempEm1  = document.createElement('td');
                tempEm1.innerText = data[i].type;
                tempEm1.style.width="240";
                tempEm1.style.height="30";
                tempEm1.style.textAlign="center";
                templi.appendChild(tempEm1);

                var tempEm2  = document.createElement('td');
                tempEm2.innerText = data[i].market;
                tempEm2.style.width="418.33";
                tempEm2.style.height="30";
                tempEm2.style.textAlign="center";
                templi.appendChild(tempEm2);

                var tempEm3  = document.createElement('td');
                tempEm3.innerText = data[i].price;
                tempEm3.style.width="179.17";
                tempEm3.style.height="30";
                tempEm3.style.textAlign="center";
                templi.appendChild(tempEm3);

                var tempEm4  = document.createElement('td');
                tempEm4.innerText = data[i].date;
                tempEm4.style.width="358.33";
                tempEm4.style.height="30";
                tempEm4.style.textAlign="center";
                templi.appendChild(tempEm4);

                flagment.appendChild(templi)
            }
            $('#show').append(flagment);
        }
        showTable(mydata);
        function goPage(pno,psize) {
            var itable = document.getElementById("show");
            var num = itable.rows.length;//表格所有行数(所有记录数)
            console.log(num);
            var totalPage = 0;//总页数
            var pageSize = psize;//每页显示行数

            //计算分几页
            if (num / pageSize > parseInt(num / pageSize)) {
                totalPage = parseInt(num / pageSize) + 1;
            } else {
                totalPage = parseInt(num / pageSize);
            }

            var currentPage = pno;//当前页数
			console.log(currentPage);
            var startRow = (currentPage - 1) * pageSize + 1;//开始显示的行  31
            var endRow = currentPage * pageSize;//结束显示的行   40

            endRow = (endRow > num) ? num : endRow;

            console.log(endRow);

            //遍历显示数据实现分页
            for (var i = 1; i < (num + 1); i++) {
                var irow = itable.rows[i - 1];
                if (i >= startRow && i <= endRow) {
                    irow.style.display = "block";//此元素将显示为块级元素，此元素前后会带有换行符。
                } else {
                    irow.style.display = "none";//此元素不会被显示。
                }
            }


            var tempStr = "共" + num + "条记录 分" + totalPage + "页 当前第" + currentPage + "页";
            var tempStr_id=document.getElementById("h_text");
            tempStr_id.innerText=tempStr;

            if (currentPage > 1 && currentPage <totalPage) {
                var templi1 = document.getElementById("up");
                templi1.href="#show";
                templi1.onclick=function(){
                    goPage(currentPage-1,pageSize);
                }
                templi1.innerText="上一页";

                var templi2=document.getElementById("down");
                templi2.href="#show";
                templi2.onclick=function () {
                    goPage(currentPage+1,pageSize);
                }
                templi2.innerText="下一页";
            } else if(currentPage == 1){
                var templi3=document.getElementById('up');
                templi3.innerText="首页";


                var templi4=document.getElementById('down');
                templi4.href="#show";
                templi4.innerText="下一页";
                templi4.onclick=function () {
                    goPage(currentPage+1,pageSize);
                }
            }else if(currentPage == totalPage){
                var templi5 = document.getElementById('up');
                templi5.href="#show";
                templi5.onclick=function(){
                    goPage(currentPage-1,pageSize);
                }
                templi5.innerText="上一页";

                var templi6=document.getElementById('down');
                templi6.innerText="尾页";
            }
        }
        goPage(1,10);


        var province=null;
        var market=null;
        var type=null;

        function getMarket(){
            province = $("#province").find("option:selected").text();
            $.ajax({
                type:"GET",
                url:"http://localhost:8080/agriculture/getMarket",
                contentType:"UTF-8",
                data:{
                    province:province
                },
                success:function (data) {
                    data=data.substring(1,data.length-1);
                    var arrayData = data.split(",");
                    console.log(arrayData)
                    console.log(arrayData[0])
                    $("#market").html('<option value=1 selected="selected">请选择</option>');
                    $("#typeMarket").html('<option value=1 selected="selected">请选择</option>');
                    for (var i = 0; i < arrayData.length; i++) {
                        var tempOpt = document.createElement('option');
                        $(tempOpt).attr('value',i+2);
                        $(tempOpt).text(arrayData[i]);
                        $("#market").append(tempOpt);
                    }
                }
            })
        }

        function getType(){
            market = $("#market").find("option:selected").text();
            $.ajax({
                type:"GET",
                url:"http://localhost:8080/agriculture/getType",
                data:{
                    province:province,
                    market:market
                },
                success:function (data) {
                    $("#typeMarket").html('<option value=1 selected="selected">请选择</option>');
                    data=data.substring(1,data.length-1);
                    var arrayData = data.split(",");
                    console.log(arrayData.length)
                    console.log(arrayData[0])
                    for (var i = 0; i < arrayData.length; i++) {
                        var tempOpt = document.createElement('option');
                        $(tempOpt).attr('value',i+2);
                        $(tempOpt).text(arrayData[i]);
                        $("#typeMarket").append(tempOpt);
                    }
                }
            })
        }

        function getData(){
            type = $("#typeMarket").find("option:selected").text();



            /*---------------------初始化----------------------------*/
            var myChart_pie = echarts.init(document.getElementById('pie'));

            /*---------------------数据----------------------------*/

			//初始化数据，
            var echartData = [{
                value: 200,//时间
                name: '交卷时间'
            }, {
                value: 100,
                name: '未交卷时间'
            }];


            /*---------------------颜色变量----------------------------*/
			//蓝色
            var innerColor = '#2bff8f'; //内层颜色
            var outColor = "#50e0ff"; //外层边框色粗
            var textColor = '#50e0ff'; //文字颜色
            var startColor = 'rgba(73,223,240,0.1)'; //中间饼图渐变开始颜色
            var endColor = 'rgba(73,223,240,0.8)'; //中间饼图渐变结束颜色
			//绿色
			// var innerColor = '#50e0ff'; //内层颜色
			// var outColor = "#2bff8f"; //外层边框色粗
			// var textColor = '#50e0ff'; //文字颜色
			// var startColor = 'rgba(43,255,143,0.1)'; //中间饼图渐变开始颜色
			// var endColor = 'rgba(43,255,143,0.8)'; //中间饼图渐变结束颜色


            /*---------------------缩放----------------------------*/
            var scale = 1;


            /*---------------------颜色配置----------------------------*/
            var color = [{
                type: 'linear',
                x: 0,
                y: 0,
                x2: 0,
                y2: 1,
                colorStops: [{
                    offset: 0,
                    color: startColor // 0% 处的颜色
                }, {
                    offset: 1,
                    color: endColor // 100% 处的颜色
                }],
                globalCoord: false // 缺省为 false
            }, 'none'];
            /*---------------------富文本----------------------------*/
            var rich = {
                time: {
                    color: innerColor,
                    fontSize: 32 * scale,
                    padding: [0, 0],
                    fontWeight:'bold'
                },
                unit:{
                    color: innerColor,
                    fontSize: 14 * scale,
                    padding: [0,0,0, 0],
                    verticalAlign:'bottom',
                }
            }


            option1 = {
                backgroundColor: '#031f2d',
                title: [{
                    text: '占比情况',
                    x: '50%',
                    y: '90%',
                    textAlign: 'center',
                    textStyle: {
                        color: '#fff',
                        textAlign: 'center',
                        fontSize: 24 * scale,
                        fontWeight: 'bold'
                    },
                }],

                series: [
                    //内圈圆环
                    {
                        name: 'Line 0',
                        type: 'pie',
                        clockWise: false, //顺时加载
                        hoverAnimation: false, //鼠标移入变大
                        center: ['50%', '50%'],
                        radius: ['50%', '51.5%'],
                        itemStyle: {
                            normal: {
                                color: innerColor
                            }
                        },
                        //只是为了百分百显示圆环
                        data: [{
                            value: 0,
                            name: '',
                        }],
                        label: {
                            normal: {
                                formatter: function(params) {
                                    var time = echartData[0].value;
                                    return '{time|' + (100+200)/200 + '}{unit|%}';
                                },
                                position: 'center',
                                textStyle: {
                                    fontSize: 38 * scale,
                                    fontWeight: 'bold',
                                    color: textColor
                                },
                                rich:rich
                            }
                        }
                    },
                    //中间圆环
                    {
                        name: 'Line 1',
                        type: 'pie',
                        clockWise: false, //顺时加载
                        hoverAnimation: true, //鼠标移入变大
                        center: ['50%', '50%'],
                        radius: ['75%', '65%'],
                        color: color,
                        itemStyle: {
                            normal: {
                                label: {
                                    show: false
                                },
                                labelLine: {
                                    show: false
                                },
                            }
                        },
                        data:echartData,
                    },
                    //外层圆环
                    {
                        name: 'Line 2',
                        type: 'pie',
                        clockWise: false, //顺时加载
                        hoverAnimation: false, //鼠标移入变大
                        center: ['50%', '50%'],
                        radius: ['75%', '75%'],
                        itemStyle: {
                            normal: {
                                borderWidth: 2* scale,
                                borderColor: outColor,
                                label: {
                                    show: false
                                },
                                labelLine: {
                                    show: false
                                },
                            }
                        },
                        //只是为了百分百显示圆环
                        data: [{
                            value: 10,
                            name: '',
                        }]
                    }
                ],
            };
            myChart_pie.setOption(option1);

            var myChart_ndgr = echarts.init(document.getElementById('ndgr'));
            option2 = {
                backgroundColor: '#2c343c',

                title: {
                    text: 'Customized Pie',
                    left: 'center',
                    top: 20,
                    textStyle: {
                        color: '#ccc'
                    }
                },

                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },

                visualMap: {
                    show: false,
                    min: 80,
                    max: 600,
                    inRange: {
                        colorLightness: [0, 1]
                    }
                },
                series : [
                    {
                        name:'访问来源',
                        type:'pie',
                        radius : '55%',
                        center: ['50%', '50%'],
                        data:[
                            {value:335, name:'直接访问'},
                            {value:310, name:'邮件营销'},
                            {value:274, name:'联盟广告'},
                            {value:235, name:'视频广告'},
                            {value:400, name:'搜索引擎'}
                        ].sort(function (a, b) { return a.value - b.value}),
                        roseType: 'angle',
                        label: {
                            normal: {
                                textStyle: {
                                    color: 'rgba(255, 255, 255, 0.3)'
                                }
                            }
                        },
                        labelLine: {
                            normal: {
                                lineStyle: {
                                    color: 'rgba(255, 255, 255, 0.3)'
                                },
                                smooth: 0.2,
                                length: 10,
                                length2: 20
                            }
                        },
                        itemStyle: {
                            normal: {
                                color: '#c23531',
                                shadowBlur: 200,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            myChart_ndgr.setOption(option2);

        }


        $("#province").change(getMarket);
        $("#market").change(getType);
        $("#queryButton").click(getData);

    }
</script>
</body>
</html>