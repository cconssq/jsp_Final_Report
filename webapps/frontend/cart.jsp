<%@ page language="java" contentType="text/html;charset=UTF-8;" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="database" class="com.database.Database">
  <jsp:setProperty property="ip" name="database" value="140.120.49.205" />
  <jsp:setProperty property="port" name="database" value="3306" />
  <jsp:setProperty property="db" name="database" value="4103028026" />
  <jsp:setProperty property="user" name="database" value="4103028026" />
  <jsp:setProperty property="password" name="database" value="Ss4103028026!" />
</jsp:useBean>

<%
if(session.getAttribute("login")!="ok"){
	//redirect to login page
	%><script>window.open('./membership/login.html','_self')</script>
<%
}else{

    request.setCharacterEncoding("UTF-8");
    String url = "";
    String driver = "com.mysql.jdbc.Driver";
    ResultSet rs = null;
    int count=0;

    //userdata
    String uid = session.getAttribute("id").toString();
    try{
     database.connectDB();
     String sql = "SELECT inv.name, inv.price, inv.picture, ord.`order_num` from `FPorder` as ord, `FPpersonal` as per, `FPinventory` as inv where per.`id` = ord.`person_id` and inv.id = ord.`product_id` and ord.`person_id`='"+uid+"';"; 
     database.query(sql);
     rs = database.getRS();

     if(rs!=null){  //Start loading data
      while(rs.next()){
      count++;
      String name = rs.getString("name");
      String price = rs.getString("price");
      String pict = rs.getString("picture");
      String pnum = rs.getString("order_num");
        
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Shopping cart</title>
    <!-- 最新編譯和最佳化的 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
    <!-- 選擇性佈景主題 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">

</head>

<body>
    <!-- Navigation -->
    <jsp:include page="./layouts/navbar.jsp"/>
    <!-- divider -->
    <div style="height: 100px;"></div>
    <!-- Main shopping cart list -->
    <div class="container">
        <h1>購物車清單</h1>
        <table class="table table-striped">
            <tr>
                <th>#</th>
                <th>產品名稱</th>
                <th>購買數量</th>
                <th>刪除</th>
            </tr>

            <tr>
                <td><%=count%></td>
                <td><a><%=name%></a></td>
                <td><%=pnum%></td>
                <td>  <button class="ui icon button">
                      <i class="remove icon"></i></button>
                </td>
            </tr>
        </table>
        <button type="button" class="btn btn-primary">Purchase</button>
    </div>


    <!-- jQuery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <!-- bootstrap JavaScript plugin -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
    <!-- Semantic UI -->
    <link rel="stylesheet" type="text/css" href="./plugins/semantic-ui/semantic.min.css">
    <script type="text/javascript" src="./plugins/semantic-ui/semantic.min.js"></script>
</body>

</html>


<%
}}}catch(Exception ex){
    out.print(ex);
}
}

%>