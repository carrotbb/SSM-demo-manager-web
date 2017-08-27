<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/view/public/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>
		<title>My JSP 'list.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link rel="stylesheet" href="<%=css%>/style.css" type="text/css" media="screen" charset="utf-8" />

	</head>

	<style>
		.page-bar {
			margin: 40px 40px 40px 500px;
		}
		
		ul,
		li {
			margin: 0px;
			padding: 0px;
		}
		
		li {
			list-style: none
		}
		
		.page-bar ul {
			overflow: hidden;
		}
		
		.page-bar li {
			float: left;
		}
		
		.page-bar li:first-child>a {
			margin-left: 0px
		}
		
		.page-bar a {
			display: block;
			border: 1px solid #ddd;
			text-decoration: none;
			position: relative;
			padding: 6px 12px;
			margin-left: -1px;
			line-height: 1.42857143;
			color: #337ab7;
			cursor: pointer
		}
		
		.page-bar a:hover {
			background-color: #eee;
		}
		
		.page-bar a.banclick {
			cursor: not-allowed;
		}
		
		.page-bar .active a {
			color: #fff;
			cursor: default;
			background-color: #337ab7;
			border-color: #337ab7;
		}
		
		.page-bar i {
			font-style: normal;
			color: #d44950;
			margin: 0px 4px;
			font-size: 12px;
		}
	</style>

	<body>
		<div id="header">

			<div class="clear"></div>
		</div>

		<div id="table" class="help" id="page">
			<h1>定时任务管理: </h1>

			<input style="margin: 3px 14px;" type="text" name="simple_input" value="" class="text w_20" placeholder="请输入任务名称">
			<a href="http://google.com" class="button"><small class="icon looking_glass"></small><span>查询</span></a>
			<a href="http://google.com" style="float: right;" class="button "><small class="icon play"></small><span>启动</span></a>
			<a href="http://google.com" style="float: right;" class="button rg"><small class="icon stop"></small><span>停止</span></a>
			<a href="http://google.com" style="float: right;" class="button rg"><small class="icon plus"></small><span>新增</span></a>

			<br>
			<br>

			<div class="col w10 last">
				<div class="content">
					<table>
						<tr>
							<th class="checkbox"><input type="checkbox" name="checkbox" /></th>
							<th>任务名称</th>
							<th>正则表达式</th>
							<th>类路径</th>
							<th>创建时间</th>
							<th>创建人ID</th>
							<th>操作</th>
						</tr>
						
						<tr id="id_1" v-for="en in datas">
							<td class="checkbox"><input type="checkbox" name="checkbox" /></td>
							<td v-text="msg"></td>
							<td>{{en.cronExpression}}</td>
							<td>{{en.classPath}}</td>
							<td>{{en.createTime}}</td>
							<td>{{en.createId}}</td>
							<td>
								<a href="http://google.com" class="button"><small class="icon looking_glass"></small><span>查看执行记录</span></a>
								<a href="http://google.com" class="button"><small class="icon settings"></small><span>设置</span></a>
							</td>
						</tr>

					</table>
				</div>
			</div>
			<div class="clear"></div>

			<div >
				<vue-nav :cur.sync="cur" :all.sync="all" v-on:btn-click="listenDate"></vue-nav>
				<p style="margin-left:40px;">{{msg}}</p>
			</div>
		</div>

		</div>
		</div>
		<div id="footer">

		</div>
	</body>

	</body>
	<script src="<%=plugin%>/vue.min.js"></script>
	<script src="<%=plugin%>/jquery/dist/jquery.min.js"></script>
	<script>
		var barHtml = '<div class="page-bar">' +
			'<ul>' +
			'<li v-if="cur>1"><a v-on:click="cur--,pageClick()">上一页</a></li>' +
			'<li v-if="cur==1"><a class="banclick">上一页</a></li>' +
			'<li v-for="index in indexs"  v-bind:class="{ active: cur == index}">' +
			'<a v-on:click="btnclick(index)">{{ index }}</a>' +
			'</li>' +
			'<li v-if="cur!=all"><a v-on:click="cur++,pageClick()">下一页</a></li>' +
			'<li v-if="cur == all"><a class="banclick">下一页</a></li>' +
			'<li><a>共<i>{{all}}</i>页</a></li>' +
			'</ul>' +
			'</div>';
		var navBar = Vue.extend({
			template: barHtml,
			props: ['all', 'cur'],
			computed: {
				indexs: function() {
					var left = 1;
					var right = this.all;
					var ar = [];
					if(this.all >= 5) {
						if(this.cur > 3 && this.cur < this.all - 2) {
							left = this.cur - 2
							right = this.cur + 2
						} else {
							if(this.cur <= 3) {
								left = 1
								right = 5
							} else {
								right = this.all
								left = this.all - 4
							}
						}
					}
					while(left <= right) {
						ar.push(left)
						left++
					}
					return ar
				}
			},
			methods: {
				btnclick: function(data) {
					if(data != this.cur) {
						this.cur = data;
						this.$emit('btn-click', data);
					}
				},
				pageClick: function() {
					this.$emit('btn-click', this.cur);
				}
			},
		});
		window.pagenav = navBar;
	</script>

	<script>
		var pageBar = new Vue({
			el: '#page',
			data: {
				all: 8, //总页数
				cur: 1, //当前页码
				pageSize:10,
				msg: '',
				datas:[]
			},
			components: {
				'vue-nav': pagenav
			},
			watch: {
				cur: function(oldValue, newValue) {
					console.log('监听cur前与后的值：');
					console.log(arguments);
				}
			},
			methods: {
				listenDate: function(data) {
					this.cur = data;
					this.msg = '你点击了' + data + '页';

				},
				loadDate: function() {
					var parm={};
					parm.pageNo=this.cur;
					parm.pageSize=this.pageSize;
					$.post("${webRoot}/demo/getList",parm,function(data){
							if(data.code==800200){
								  alert("获取数据成功!");
								  debugger;
								 this.datas=data.obj.dataList;
							}else{
								alert("获取数据失败!");
							}
					},"json")
				}
			},
			created: function(){
				this.loadDate();

			}

		})
	</script>

</html>