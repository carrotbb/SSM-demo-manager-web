<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
String webRoot = request.getContextPath();
String css = request.getContextPath()+"/"+"static/css";
String images = request.getContextPath()+"/"+"static/images";
String js = request.getContextPath()+"/"+"static/js";
String plugin = request.getContextPath()+"/"+"static/plugin";
String webRootPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+webRoot+"/";
pageContext.setAttribute("webRoot",webRootPath);
%>
