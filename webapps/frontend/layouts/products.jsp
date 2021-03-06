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
	request.setCharacterEncoding("UTF-8");
	String url = "";
	String driver = "com.mysql.jdbc.Driver";
  String query = request.getParameter("query");
  int pcount  = 0;
	ResultSet rs = null;
  int rowLimit=3;
  int rowCount=1;

	try{
	 database.connectDB();
     String sql = "select * from FPinventory;"; // Catch every data from 'person'
     if(query!="" && query!=null){
      sql = "select * from FPinventory where platform='"+query+"' or name like '%"+query+"%';";
     }
     database.query(sql);
     rs = database.getRS();
     if(rs!=null){	//Start loading data
      while(rs.next()){
      pcount++;
      String name = rs.getString("name");
      String id = rs.getString("id");
      String price = rs.getString("price");
      String pict = rs.getString("picture");
      String video = rs.getString("video");
      String type = rs.getString("platform");
        if(rowCount==rowLimit){
          out.print("<div class='row'>");
        }
%>
  <div class='col-sm-4 portfolio-item' id='div_index20'>
    <div class="header-margin"></div>
    <h2 class="ui header"><%=name%><a class="ui red label"><%=type%></a>

</h2>
    <a href="<%=video%>"><img class='img-responsive' src='<%=pict%>'/></a>
    <h3 id='price' class="ui header">Price</h3><h3 class="ui header" style="text-align: right; ">NT$ <%=price%></h3>   
    	<form action="#" >	
    	<input type="hidden" value='<%=id%>'> 	
        <select class="ui compact selection dropdown">
    		  <option value="1">1</option>
    		  <option value="2">2</option>
    		  <option value="3">3</option>
    		</select>
	    <button class='ui labeled icon button' style='font-family: "Microsoft JhengHei";' onclick="AddToCart(this.form)">
	    <i class="shop icon"></i>加入購物車</button>
  	 </form>
  </div>


<%
        if(rowCount==rowLimit){
          out.print("</div>");
          rowCount=0;
        }
        rowCount++;

      }
      if(pcount==0){%>
        <h1>No result found</h1>
      <%}
    }else{
      out.print("keyword:");
      out.print(query);
      out.print(", No result found!");

    }
  

}catch(Exception e){
	out.println(e);
}
%>

<script type="text/javascript">
<%
if(session.getAttribute("login")=="ok"){
%>
	function AddToCart(Tform){
    var productid = Tform[0].value;
    var purchasenum = Tform[1].value;
    console.log(productid+", "+purchasenum);

		$.get('carts/addtocart.jsp', {
                pid: productid,
                pnum: purchasenum
            },
            function(data){
                swal("Add to cart!", data, "success");
            }
        );
		return null;	
	}
<%
}
else{
%>
	function AddToCart(){
		//not logged in
		swal("Error!", "Please login first to add things to cart.", "error");
	}
<%
}
%>




</script>

