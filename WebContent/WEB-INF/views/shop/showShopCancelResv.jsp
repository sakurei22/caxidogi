<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ include file="./../../../include/header.jsp" %>
<%@ include file="./../../../include/left_frm.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="sweetalert2.all.min.js"></script>
<!-- Optional: include a polyfill for ES6 Promises for IE11 -->
<script src="https://cdn.jsdelivr.net/npm/promise-polyfill"></script>
<script src="sweetalert2.min.js"></script>
<link rel="stylesheet" href="sweetalert2.min.css">

<link href="./css/showShopResv.css" rel="stylesheet">
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.2/css/all.min.css'>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">


<div class="cusSec_right">

<div class="cusSec_tableWrap">
<ul class="mind_menu">
<li data-cat="item1">미용 예약 내역</li>
</ul>
<div class="mind_wrap">
  
 <c:forEach items="${cancelShopList }" var="cancelList">
 <input type="hidden" value="${cancelList.shop_resv_tel}" id="h_user_tel">

  <ul class="mind_booking_listings">
    <li>
      <div class="booking_list1">
      <c:if test="${cancelList.shop_photo == 'default' }">
							<img 
								src="./images/shopImg/default.png" alt="">
						</c:if>
						<c:if test="${cancelList.shop_photo != 'default' }">
							<img 
								src="<%=request.getContextPath() %>/images/shopImg/${cancelList.shop_photo }" alt="">
						</c:if>
  </div><!-- List 1 -->
  <div class="booking_list2 booking_tel">
    <div class="child1">
      <h2>${cancelList.shop_name }<i class="fa fa-angle-down" aria-hidden="true"></i>
 </h2>
      <h5> </h5>
    </div>
    <div class="child2" style="display:none;">
     <ul class="child_ul_1">
    	<li>예약자 명: ${cancelList.shop_resv_name}</li>
    	<li class="userTel" >예약자 연락처: <span>${cancelList.shop_resv_tel}</span></li>
    	<li>예약시간 : ${cancelList.shop_resv_time }</li>
    	<li>예약날짜 : ${cancelList.shop_resv_rday }</li>
    	<li>요청사항 : ${cancelList.shop_resv_comment }</li>
    	<li>예상 비용 : <fmt:formatNumber value="${cancelList.shop_resv_price }" pattern="###,###,###"/> 원</li>
    	<li>미용 받을 견종:
    	<c:choose>
							<c:when test="${cancelList.shop_resv_size == 0 }">
								소형견
							</c:when>
							
							<c:when test="${cancelList.shop_resv_size == 1 }">
								중형견
							</c:when>
							
							<c:when test="${cancelList.shop_resv_size == 2 }">
								대형견
							</c:when>
						
						</c:choose>
    	</li>
    </ul>
    <ul class="child_ul_2">
    	<li>가게 주소: ${fn:split(cancelList.shop_addr, '/')[1] } </li>
    	<li class="tel" >가게전화: <span>${cancelList.shop_tel}</span></li>
    	 <%-- <input type="hidden" value="${showList.shop_tel}" id="h_shop_tel"> --%>
    	 <%-- <input type="text" value="${showList.shop_tel}" id="h_shop_tel" class="h_shop_tel"> --%>
    	<li>영업 시간: ${cancelList.shop_time}</li>
    </ul>
   <%--  <p> 예약자 명: ${showList.shop_resv_name}  예약시간 : ${showList.shop_resv_time }
    </p> --%>
      <%-- <span>예약자 명: ${showList.shop_resv_name}</span>
      <span>예약시간 : ${showList.shop_resv_time }</span> --%>
      <span></span>
    </div>   
  </div> <!-- List 2 -->
   <div class="booking_list3">  
   <a href="shopDetail.do?shop_seq=${cancelList.shop_seq }"><button>shop</button></a>  
   </div>

    </li>
  </ul>
  <input type="hidden" id="">
</c:forEach>
<form name="frmForm1" id="_frmFormSearch" method="post">

 <input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage)?0:recordCountPerPage }">
 <input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber }">
</form>
 <jsp:include page="/include/paging.jsp" flush="false">
		<jsp:param name="totalRecordCount" value="${totalRecordCount }" />
		<jsp:param name="pageNumber" value="${pageNumber }" />
		<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }" />
		<jsp:param name="recordCountPerPage" value="${recordCountPerPage }" />
</jsp:include> 

</div>
</div>
</div>
</div>
 <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js'></script>
 <script src="<%=request.getContextPath() %>/js/showShopResv.js"></script>

<script>
// 전화번호들 수정해야함  포멧넘버 쓰기---------------------------------------------------------------------------
// 가제 전화 하이픈(-) 삽입
$('.booking_tel').click(function(){
	// 가게 전화
	var tel = $(this).find('li.tel span').text();
	tel = tel.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
	$(this).find('li.tel span').text(tel);

	// 예약자 연락처
	var userTel = $(this).find('li.userTel span').text();
	userTel = userTel.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
	$(this).find('li.userTel span').text(userTel);
	
});

</script>

<script>
function goPage( pageNumber ){
	alert(pageNumber);
	
	$("#_pageNumber").val(pageNumber);
	$("#_frmFormSearch").attr("action", "shopResvCancelList.do").submit();	
}
</script>



<%@ include file="./../../../include/footer.jsp" %>