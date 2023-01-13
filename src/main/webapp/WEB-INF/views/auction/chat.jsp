<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>라이브 도매 경매 방송</title>

    <!--css-->

    <link rel="stylesheet" href="/static/css/auction/broadcast.css" type="text/css">
    <!-- <link rel="stylesheet" href="/static/css/auction/stylesheet.css" type="text/css"> -->
    <link rel="stylesheet" href="/static/css/auction/getHTMLMediaElement.css" type="text/css">


    <!--라이브러리 -->
    <!-- Jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <!-- Sock JS -->
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    
    <!-- Sweet Alert -->
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>


</head>
<body>
<c:import url="../common/header.jsp"></c:import>

    <!-- Principal 접속 아이디 -->
    <sec:authentication property="Principal" var="user"/>
    <input type="text" style="display: none;" id="username" value="${member}">
    <input type="hidden" value="${user.roleNum}">
    <!---->

    <!-- 옥션 번호 -->
    <input type="hidden" id="auction_num" value="${vo.auctionVO.auction_num}">

    <!-- 상품 번호 -->
    <input type="hidden" id="product_num" value="${vo.product_num}">

    <!-- 단위 가격 -->
    <input type="hidden" style="display: none;" value="5000">

    <!-- 전체 컨텐츠 -->
        <div id="broadcast-box" class="container container-fluid">
            <!-- 채팅포함 미디어 컨텐츠 (전체)-->
            <div id="media-box" class="row">
                <div id="video-box" class="col-8">
                    <div id="videos-container" style="background-color: black;">
                      <h1 style="color: white;">⌛ 준비 중...</h1>
                    </div>
                    <div id="broadcast-info" class="row">
                        <!-- <button class="col">방송 정보</button>
                        <button class="col">판매 상품 정보</button>
                        <button class="col">입찰 정보</button> -->
                        <ul class="nav nav-tabs row">
                            <li class="nav-item col">
                              <a class="nav-link active" style="cursor: pointer;" onclick="getInfo()">방송정보</a>
                            </li>
                            <sec:authorize access="hasAnyRole('ADMIN')">
                            <li class="nav-item col">
                              <a class="nav-link active" style="cursor: pointer;" onclick="getBroadControl()">방송 제어</a>
                            </li>
                            </sec:authorize>
                            <li class="nav-item col">
                              <a class="nav-link active" style="cursor: pointer;" onclick="getLawInfo()">경매 약관</a>
                            </li>
                        </ul>
                    </div>
                    <div class="row">
                        <!-- 방송 정보 -->
                        <div class="list-group" id="br-info">
                            <div class="list-group-item">
                              <div class="d-flex w-100 justify-content-between">
                                <h5 class="mb-1"><span class="opacity-50">제목</span>  ${vo.auctionVO.title}</h5>
                                <small>허용 인원 수 ${vo.auctionVO.head_count}</small>
                              </div>
                              <p class="mb-1"></p>
                              <small>${vo.auctionVO.sign_date}</small>
                            </div>
                        </div>

                        <!-- 판매 상품 정보 -->


                        <!-- 약관 -->
                        <div class="accordion accordion-flush" id="accordionFlushExample" style="display: none;">
                            <div class="accordion-item">
                              <h2 class="accordion-header" id="flush-headingOne">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                                  경매의 목적 및 정의
                                </button>
                              </h2>
                              <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                                <div class="accordion-body">
                                  1 목적<br>

                                  본 경매 약관과 관련하여 경매도록 등에 포함된 유의사항은 다음의 사항을 규율함을 목적으로 한다.<br>
                                  1.1 ㈜마이아트옥션(이하 "마이아트옥션"이라 한다)이 홈페이지(www.myartauction.com)상에서 실시하는 온라인 경매의 절차와 제반기준 및 관련자들의 권리・의무
                                  단, 마이아트옥션과 위탁자간의 위탁 계약에 관한 사항은 별도의 위탁계약서에서 규율한다.<br><br>
                                  
                                  
                                  2 정의<br><br>
                                  
                                  2.1 "경매"라 함은 경매약관과 경매도록 등에 따라 마이아트옥션이 실시하는 온라인 경매를 의미한다.<br>
                                  2.2 "물품"이라 함은 경매 및 일반적인 형태의 매매계약의 대상이 될 수 있는 모든 형태의 물품, 미술품, 창작물 등과 이용권, 교환권 등의 권리를 의미하고 "경매물품"이라 함은 마이아트옥션 경매에 출품되거나 경매 전 또는 후 세일, 상설 판매의 대상이 되는 모든 물품을 의미한다.<br>
                                  2.3 "경매도록"이라 함은, 마이아트옥션 경매와 관련하여, 마이아트옥션이 발간하는, 마이아트옥션 경매에서 경매될 예정인 경매물품에 관한 설명과 정보가 실린 도록(전자도록 포함)을 의미한다. "경매도록 등"이라 함은, 경매도록 및 해당 경매와 관련하여 마이아트옥션이 제공하는 모든 형태의 자료(홈페이지, 전자우편, 문자메세지, 스마트폰 앱, 리스트북, 브로셔, 컨디션리포트, 제안서, 리서치자료, 경매장의 스크린, 홍보물, 광고물, 인쇄물 등을 포함하며, 이에 한정하지 아니함)를 의미한다.<br>
                                  2.4 “경매마감일”이라 함은, 당사경매와 관련하여, 경매물품의 경매기간이 종료되는 일자를 의미한다.<br>
                                  2.5 “경매마감시간”이라 함은, 당사경매와 관련하여, 각 경매물품에 대한 경매기간이 종료될 것으로 예정된 시간을 의미한다.<br>
                                  2.6 “최종경매마감시간”이라 함은, 경매와 관련하여, 각 경매물품에 대한 경매기간이 실제로 종료된 시간을 의미한다.<br>
                                  2.7 "경매기간"이라 함은, 마이아트옥션 온라인 경매가 실시되는 일자 또는 기간을 의미한다.<br>
                                  2.8 "응찰자"라 함은, 마이아트옥션 경매에 응찰하기 위하여 마이아트옥션에 응찰 신청을 한 사람으로서 마이아트옥션이 그 신청을 접수했거나 만약 적용가능하다면, 경매약관과 경매도록 등에 따라 마이아트옥션으로부터 서면 확인서를 수령한 사람을 의미한다.<br>
                                  2.9 "영업일"이라 함은 토요일, 일요일 또는 공휴일을 제외한 월력일을 말한다.<br>
                                  2.10 "낙찰자"라 함은, 경매물품에 관하여, 경매 물품의 경매 가격으로서 경매 약관에 따라 해당 경매물품의 최종경매마감시간에 마이아트옥션에 의해 확정된 최고 응찰자를 의미한다.<br>
                                  2.11 "낙찰철회비"라 함은, 경매물품에 관하여, 낙찰자가 낙찰 받기를 포기함으로써 마이아트옥션에 지급하여야 하는, 낙찰가의 30%에 해당하는 금액을 의미한다.<br>
                                  2.12 "낙찰자비용"이라 함은, 경매물품에 관하여, 마이아트옥션, 그 관리자, 직원, 피용인, 대리인이 경매약관 및 경매도록 등에 따라 경매물품의 판매와 관련하여 지출한 환전수수료, 보관료, 포장, 인도 및 보험료를 포함한 모든 세금, 경비, 수수료 또는 비용으로서 낙찰자가 마이아트옥션에 지급하여야 하는 금액을 의미한다.<br>
                                  2.13 "구매수수료"라 함은, 경매물품에 관하여, 경매약관에 따라 경매물품의 매매와 관련하여 낙찰자가 마이아트옥션에 지급해야 하는 수수료를 의미한다.<br>
                                  2.14 "위탁자"라 함은, 경매물품에 관하여, 마이아트옥션 경매 시작일 이전에 경매물품을 마이아트옥션 경매에 출품하기 위하여 마이아트옥션과 위탁 계약을 체결하고, 이를 위탁한 사람을 의미한다.<br>
                                  2.15 "추정가"라 함은, 경매물품에 관하여, 경매를 통한 판매의 특성을 반영하여 마이아트옥션에게 위임된 단독적이고 절대적인 재량에 의해 결정된 경매물품의 추정된 가격을 의미한다.<br>
                                  2.16 "시작가"라 함은, 경매물품에 관하여, 경매를 통한 판매의 특성을 반영하여 마이아트옥션과 경매사에게 위임된 단독적이고 절대적인 재량에 의해 결정된 경매물품의 경매 시작 가격을 의미한다.<br>
                                  2.17 "낙찰가"라 함은, 경매약관에 따라 해당 경매물품의 최종경매마감시간에 마이아트옥션에 의해 확정된 최고 응찰가를 말한다.
                                  2.18 "구매가"라 함은, 경매물품에 관하여, 낙찰가에 구매수수료를 합한 가격을 의미한다.<br>
                                  2.19 "내정가"라 함은, 경매물품에 관하여, 경매물품의 경매 이전에, (만약 위탁자가 매도인인 경우) 위 경매 물품의 매도인과 마이아트옥션 간에 서면으로 합의된, 또는 (만약 마이아트옥션이 매도인인 경우) 마이아트옥션에 의해 결정된, 경매물품의 최저매도가격을 의미한다.<br>
                                  2.20 "매도인"이라 함은, 경매 등 계약의 상대방 당사자로서, 마이아트옥션 또는 위탁자를 의미한다.<br>
                                  2.21 "계열회사"라 함은 마이아트옥션, 자회사 또는 마이아트옥션에 의해 지배되거나 마이아트옥션과 같은 지배 하에 있는 회사를 말한다.<br>
                                  </div>
                              </div>
                            </div>
                            <div class="accordion-item">
                              <h2 class="accordion-header" id="flush-headingTwo">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
                                  구매가의 지급 및 경매물품의 인도
                                </button>
                              </h2>
                              <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
                                <div class="accordion-body">3.1 마이아트옥션은 낙찰받은 물품의 목록, 본 경매약관 및 경매도록 등에 따라 낙찰자가 마이아트옥션에 지급해야 하는 낙찰가, 구매수수료, 부가가치세 및 모든 낙찰자비용을 기재한 송장을 경매물품의 낙찰일 또는 그 낙찰일로부터 최대한 가능한 시기에 낙찰자에게 직접 또는 우편 또는 전자통신망(이메일, 문자메세지, sns 등)으로 제공한다.<br><br>
                                  3.2 낙찰자에 의해 구매된 경매물품에 관하여, 낙찰자는 경매약관과 경매도록 등에 따라 (마이아트옥션 및 위탁자에 대한 채무로서) 마이아트옥션에 다음 각호를 지급한다. 물품의 소유권은 마이아트옥션이 다음 각 호의 금액 전액을 수령하는 때까지는 이전되지 않는다.<br>
                                  3.2.1 송장에 기재된 총대금; 및
                                  3.2.2 송장이 낙찰자에게 발송된 이후에 발생한 낙찰자비용.
                                  낙찰자는 낙찰일로부터 7일 이내에 (또는 낙찰가가 3억원 이상인 경우 낙찰일로부터 21일 이내에, 단 구매가의 30%는 낙찰일로부터 7일 이내에 마이아트옥션에 지급하는 것을 조건으로) 마이아트옥션에 위 금액을 완납하여야 한다. 낙찰자가 납입기일까지 마이아트옥션에 위 금액을 납입하지 못한 경우, 납입기일(불산입)부터 연체대금 및 가산된 이자를 실제 납입하는 날(산입)까지 월 2%의 지연이자가 가산된다. 다만, 마이아트옥션의 재량에 의하여 지연이자의 전부 또는 일부를 면제할 수 있으며, 마이아트옥션과 낙찰자는 관련 경매물품의 경매 이전에 구매가를 분할지급하기로 서면으로 합의할 수 있다.<br><br>
                                  
                                  3.3 낙찰자와 마이아트옥션 사이에 별도로 서면으로 합의되지 않은 이상,<br>
                                  (i) 해당 경매물품 관련하여 낙찰자는 경매약관과 경매도록 등에 따라 (마이아트옥션 및 위탁자에 대한 채무로서) 마이아트옥션에 구매가 및 낙찰자비용을 지급할 책임이 있다.
                                  (ii) 마이아트옥션은 낙찰자가(마이아트옥션 및 위탁자에 대한 채무로서) 마이아트옥션에게 지급하여야 하는 대금을 낙찰자가 아닌 제3자로부터 지급받지 않는다.<br><br>
                                  
                                  3.4 경매물품과 관련하여, 만약 마이아트옥션이 (마이아트옥션 및 위탁자에 대한 채무로서) 각 경매물품의 낙찰일로부터 7일 이내에 제10조에 따른 금액을 낙찰자로부터 완납받지 못하는 경우, 낙찰자와 마이아트옥션 사이에 사전 서면 합의가 없는 이상, 마이아트옥션은 자신의 단독적이고 절대적인 재량에 따라 다음의 조치를 취할 수 있다. 본 항의 기간 계산에 있어 낙찰일 당일은 산입되지 않는다.<br>
                                  3.4.1 경매의 취소 및 마이아트옥션의 지급요구 시 바로 기한이 도래하는 낙찰철회비를 낙찰자에게 청구;<br>
                                  3.4.2 해당 경매물품을 다른 마이아트옥션 경매에 회부;<br>
                                  3.4.3 위탁자의 낙찰자에 대한 청구와 관련하여 요구되는 범위 내에서 낙찰자의 개인 정보를 위탁자에게 제공<br>
                                  3.4.4 기타 마이아트옥션이 판단하기에 필요하거나 적절하다고 고려되는 조치.<br>
                                  상기의 조치는 법에 의해 허용되는 마이아트옥션의 다른 권리나 구제조치에 영향을 미치지 않는다.<br><br>
                                  
                                  3.5 낙찰자는 당해 경매물품의 낙찰일로부터 7일 이내에 다음 각호의 조건 하에 경매를 취소할 수 있다.<br>
                                  3.5.1 마이아트옥션에게 서면에 의한 경매취소의 의사표시; 그리고<br>
                                  3.5.2 마이아트옥션에게 낙찰철회비용을 지급.<br>
                                  본 항의 기간 계산에 있어 낙찰일 당일은 산입되지 않는다. 마이아트옥션이 위 서면 및 낙찰철회비용을 수령하는 즉시 경매는 취소된다.<br><br>
                                  
                                  3.6 마이아트옥션과 응찰자 간에 별도의 서면 합의가 존재하지 않는 이상, 마이아트옥션은 제10.6조에 따라 해당 경매물품의 낙찰자 또는 그의 권한 있는 대리인에게만 경매물품을 인도한다. 낙찰자는 낙찰일로부터 7일 이내에 자신의 위험과 비용으로 자신이 매수한 경매물품을 직접 또는 권한 있는 대리인을 통해 인수한다. 본 항의 기간 계산에 있어 낙찰일 당일은 산입되지 않는다. 단, 다음 각호의 경우에는 마이아트옥션은 경매물품을 인도할 의무가 없다.<br>
                                  3.6.1 낙찰자가 마이아트옥션에 제10조에 따라 지급해야 하는 총대금을 마이아트옥션이 하자없이 완납받지 않은 경우; 그리고<br>
                                  3.6.2 마이아트옥션이 만족할 만한 수준의 인수인의 신원확인 증명 및 (권한있는 대리인의 경우) 그 대리권의 증명이 없는 경우.<br><br>
                                  
                                  3.7 마이아트옥션과 낙찰자 간에 별도의 서면 합의가 있는 경우, 마이아트옥션은 낙찰자의 위험부담 하에 낙찰자가 매수한 경매물품의 포장, 인도 및 운송보험의 가입을 위한 조치를 취할 수 있다. 사유를 불문하고, 마이아트옥션은 위 포장 및 인도 기간동안 발생한 어떠한 손해나 손실에 대해서도 책임을 지지 않는다.<br><br>
                                  
                                  3.8 마이아트옥션은 경매물품의 낙찰일로부터 7일이 도과되는 날까지 경매물품을 무료로 보관한다. 본 항의 기간 계산에 있어 낙찰일 당일은 산입되지 않는다. 경매물품은 위 기간이 도관된 이후 낙찰자의 위험부담 하에 마이아트옥션이 보관한다. 낙찰자가 (마이아트옥션 및 위탁자에 대한 채무로서) 마이아트옥션에 대금을 완납하지 않거나 제10.6조에 따라 마이아트옥션이 만족할 만한 수준의 서류를 제공받지 못하여 마이아트옥션이 경매물품의 인수를 거절한 경우를 불문하고, 낙찰자가 위 기간 이내에 경매물품을 인수하지 않은 경우, 낙찰자는 매 경매물품마다 위 기간이 도과된 날로부터 인수될 때까지 보관비용(운송료, 보험료 포함)을 부담하며, 이 때의 보관비용은 마이아트옥션이 운영하고 있는 보관을 위한 창고의 1일 이용료를 기준으로 계산된다.<br><br>
                                  
                                  3.9 낙찰자에 의해 회수되어야 할 경매물품이 당해 경매물품의 낙찰일로부터 21일 이내에 그 사유를 불문하고 낙찰자 또는 그 권한있는 대리인에 의해 회수되지 않는 경우, 마이아트옥션은 당해 경매물품에 대한 어떠한 손해나 손실에 대해서도 책임을 지지 않는다. 본 항의 기간 계산에 있어 낙찰일 당일은 산입되지 않는다.</div>
                              </div>
                            </div>
                            <div class="accordion-item">
                              <h2 class="accordion-header" id="flush-headingThree">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
                                  제한보증
                                </button>
                              </h2>
                              <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
                                <div class="accordion-body">4.1 마이아트옥션은, 경매물품에 대하여 경매도록 첫 줄에 굵게 검은색으로 인쇄된 표제사항 (이하 "표제 사항"이라 한다) (관련 경매기간동안 경매장에 전시되는 판매실 공지 사항에 따라 수정되는 대로)에 대하여 위 경매물품의 낙찰일을 기준으로, 위 사항이 진정하고 정확하다는 것을 보증한다 (이하 "제한보증"이라 한다). 다만 마이아트옥션은 일부 표제 사항에 대하여는 경매도록 및 경매도록 등에 사전 고지 후 보증을 제한할 수 있다.<br><br>

                                  4.2 낙찰자가 경매물품의 낙찰일로부터 3년 이내에 본 제14조에 따라 (이하에서 정의된) 청구서면을 마이아트옥션에 제시하지 않은 이상, 마이아트옥션은 제한보증 의무 위반에 대하여 책임을 부담하지 않는다 (이하 "보증 기간"이라 한다). 본 항의 기간 계산에 있어 낙찰일 당일은 산입되지 않는다.<br><br>
                                  
                                  
                                  4.3 제14.2조에 따를 것을 조건으로, 제한보증에 따른 책임을 추궁하길 원하는 낙찰자는<br>
                                  (i) 제한보증의 잠재적/현실적 위반이 있었음을 안 때로부터 3개월 이내에 경매물품의 낙찰일, 경매 번호와 청구 사유를 기재한 서면 (이하 "청구 서면"이라 한다)을 마이아트옥션에 제시하고,<br>
                                  (ii) 경매물품의 판매 당시와 같은 상태로 위 경매물품을 마이아트옥션에게 반환해야 한다. 본 항의 기간 계산에 있어 낙찰일 당일은 산입되지 않는다.<br><br>
                                  
                                  4.4 낙찰자와 마이아트옥션 사이에 제한보증에 근거한 낙찰자의 청구 사유에 대하여 분쟁이 있는 경우, 마이아트옥션은 낙찰자의 비용으로 마이아트옥션과 낙찰자 모두가 용인할 수 있는 두 명의 전문가의 서면 의견을 받을 것을 낙찰자에게 요구할 수 있다. 마이아트옥션은 낙찰자에 의해 제공된 서면 의견에 구속되지 않으며, 당사의 비용으로 다른 전문가로부터 추가적인 의견을 구할 수 있다.<br><br>
                                  
                                  4.5 낙찰자는 다음 각호의 경우에는 경매물품에 관하여 제한보증을 청구할 수 있는 자격이 없다.<br>
                                  4.5.1 낙찰일 당시에 관련 표제사항이 학자 또는 전문가의 일반적인 의견이었던 경우;<br>
                                  4.5.2 관련 표제사항에 대하여 학자 또는 전문가의 반대 의견이 존재한다는 사실이 경매도록 또는 경매장 전시된 판매실 공지에 표시된 경우; 또는<br>
                                  4.5.3 경매도록의 출판 당시에 일반적으로 사용되지 않는 방법 또는 비현실적으로 고가의 비용이 드는 방법이나 경매물품에 훼손을 가하는 방법으로만 제한보증 위반이 증명되는 경우.<br><br>
                                  
                                  4.6 제한보증 위반이 있는 경우, 마이아트옥션은 경매물품의 경매를 취소하고, 낙찰자에게 경매물품에 관하여 낙찰자가 지급한 구매가를 환불한다.<br><br>
                                  
                                  4.7 경매물품에 관하여 제한보증 위반이 있는 경우, 마이아트옥션 및 매도인에 대한 낙찰자의 유일하고 배타적인 구제 방법은 경매의 취소 및 위 경매물품에 관하여 낙찰자가 지급한 구매가의 반환청구이다. 마이아트옥션 및 매도인은 이익 또는 이자의 손실을 포함한, 어떠한 특별하고 간접적이며 후속적인 손해에 대해서도 책임을 부담하지 않는다. 의문의 소지를 없애기 위해, 마이아트옥션은 이자를 지급할 책임 또는 환율 변동 등에 의해 발생한 어떠한 손해에 대해서도 배상할 책임을 부담하지 않는다.<br><br>
                                  
                                  4.8 낙찰자는 제한보증으로 부여받은 이익을 양도하거나 이전할 수 없다. 마이아트옥션과 낙찰자 간에 별도의 서면 합의가 존재하지 않는 이상, 송장에 표시된 낙찰자 또는 그 상속인만이 제한보증 상의 청구를 할 수 있다. 단, 위 낙찰자 또는 그 상속인은 경매물품과 관련된 이익을 제3자에게 처분하지 않고 경매물품의 소유권을 보유하고 있어야 한다.<br><br>
                                  
                                  
                                  4.9 위탁자를 대신하여 마이아트옥션이 제한보증 의무 위반에 대한 책임을 포함하여 이와 유사한 책임을 부담한 경우, 위탁자는 해당 경매물품과 관련하여 마이아트옥션으로부터 지급받은 모든 금원을 즉시 마이아트옥션에 반환하여야 하며, 그 외에 마이아트옥션에 발생한 손해를 배상하여야 한다.<br><br>
                                  
                                  4.10 마이아트옥션이 경매 물품에 대하여 위탁자로부터 보증서 또는 감정서 등을 제출받아 이를 낙찰자에게 제공하는 경우, 마이아트옥션은 위탁자로부터 제출받은 보증서 또는 감정서 등이 낙찰자에게 제공되는 보증서 또는 감정서 등과 동일하다는 사실에 대하여만 이를 보증한다. 마이아트옥션은 위탁자로부터 제출받은 보증서 또는 감정서의 진위 또는 그 기재 내용에 대하여 어떠한 책임도 부담하지 않는다.</div>
                              </div>
                            </div>
                          </div>


                          <!-- 관리자 모드 -->
                          <sec:authorize access="hasAnyRole('ADMIN')">
                            <div id="control-broadcast" class="row" style="display: none;">
                              <p class="text-center" style="margin-top: 10px;">방송 제어</p>
                              <button type="button" class="btn btn-outline-secondary col-3" id="open-room">방송시작</button>
                              <button type="button" class="btn btn-outline-secondary col-3" id="pausevideo">방송 중지</button>
                              <button type="button" class="btn btn-outline-secondary col-3" id="restartvideo">방송 재개</button>
                              <select class="col-3" id="cameras">

                              </select>
                              <hr style="margin-top: 10px;">
                              <p class="text-center">경매 제어</p>
                              <button type="button" class="btn btn-outline-secondary col-4" id="startauction">경매 시작</button>
                              <button type="button" class="btn btn-outline-secondary col-4" id="pauseauction">경매 중지</button>
                              <button type="button" class="btn btn-outline-secondary col-4" id="pauseauction" id="terminateauction">경매 종료</button>
                          </div>
                          </sec:authorize>
                    </div>
                </div>
            
            
                <div id="chat-mainbox" class="col-4">
                    <div id="chat-header" class="row">
                        <!-- <div id="chat-info1" class="col"> -->
                            <button class="btn btn-outline-secondary col" id="chat-info1" onclick="getChattingList()"><img src="/assets/img/chatting.png" height="30px" width="30px"> 채팅</button>
                        <!-- </div> -->
                        <!-- <div id="chat-info2" class="col"> -->
                            <button class="btn btn-outline-secondary col" id="chat-info2" onclick="getParticipants()"><img src="/assets/img/users.png" height="30px" width="30px"> 참여자</button>
                        <!-- </div> -->
                        <!-- <div id="bid-btn" class="col"> -->
                            <button class="btn btn-outline-secondary col" id="bid-btn" onclick="getBidPage()"><img src="/assets/img/bidding.png" height="30px" width="30px"> 입찰</button>
                        <!-- </div> -->
                    </div>
                        
                        <div id="chat-frame">
                            <!-- 참여자 목록  -->
                            <div id="participants-box" class="border border-3" style="display: none;" onscroll="scrollFN()">
                                <ul class="list-group list-group-flush" id="participants" data-role="${user.roleNum}"></ul>
                            </div>
                            
                            <!-- 채팅 목록 -->
                            <div id="chat-box" class="border border-3" onscroll="scrollFN()">

                            </div>
                            <div id="chat-write" class="row">
                                <div class="col-10">
                                    <textarea class="form-control" id="chat-input" onkeyup="enterkey()" style="resize: none;"></textarea>
                                    <!-- <input type="text" class="input" id="chat-input" onkeyup="enterkey()"> -->
                                </div>
                                <div class="col-2">
                                    <button type="button" class="btn btn-success" onclick="send()">➤</button>
                                </div>
                               
                            </div>

                            <!-- 경매 참여 (입찰 )-->
                            <div id="bid-box" style="display : none;" class="row">
                                <div class="text-center">
                                    <img src="/assets/img/profle.png" class="rounded">
                                </div>

                                <div>
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item"><div class="opacity-50">상품명</div>${vo.name}</li>
                                        <li class="list-group-item">
                                          <div class="row">
                                            <div class="opacity-50 col-4">현재가</div>
                                          </div>
                                          <span id="currentprice">${vo.auctionVO.init_price}</span>
                                        </li>
                                        <li class="list-group-item">
                                          <div class="row">
                                            <div class="opacity-50 col-4">중량</div>
                                            <div class="opacity-50 col-4">등급</div>
                                            <div class="opacity-50 col-4">수량</div>
                                          </div>
                                          <div class="row">
                                            <span class="col-4">${vo.quantity} kg</span>
                                            <span class="col-4">${vo.productGradeVO.grade_name}</span>
                                            <span class="col-4">${vo.quantity} (개)</span>
                                          </div>
                                    
                                        </li>
                                        <li class="list-group-item"><div class="opacity-50">원산지</div>${vo.product_address}</li>
                                        <li class="list-group-item"><div class="opacity-50">입찰 단위 가격</div><span id="unitprice"><fmt:formatNumber value="5000" pattern="#,###"/></span></li>
                                    </ul>
                                  <div class="row">
                                      <input class="col-8" type="text" id="inputfree" disabled onkeyup="getCalculate(this)" onblur="getCalculate2(this)">
                                      <button type="button" class="btn btn-outline-secondary col-4" disabled id="free-bidding" onclick="setFreeBidding()">입찰</button>
                                      <button type="button" class="btn btn-outline-secondary" disabled id="unit-bidding" onclick="setUnitBidding()">단위 가격 자동 입찰</button><br>
                                      <span>보유포인트 : <span id="mypoint"><fmt:formatNumber value="400000" pattern="#,###"/></span></span>
                                  </div>
                                 
                                </div>
                            </div>


                        </div>
                </div>
            </div>
        </div>

    <!-- 전체 컨텐츠 -->
    <!-- 비디오 -->
    <div class="row" style="display: none;">
        <h1>
            Video OneWay Broadcasting using RTCMultiConnection
            <p class="no-mobile">
            Multi-user (one-to-many) video broadcasting using star topology.
            </p>
        </h1>
            
        <section class="make-center">
            <input type="text" id="room-id" value="abcdef" autocorrect=off autocapitalize=off size=20>
            <!-- <button id="open-room">Open Room</button> -->
            <button id="join-room">Join Room</button>
            <button id="open-or-join-room">Auto Open Or Join Room</button>

            <!-- <div id="videos-container" style="margin: 20px 0;"></div> -->

            <div id="room-urls" style="text-align: center;display: none;background: #F1EDED;margin: 15px -10px;border: 1px solid rgb(189, 189, 189);border-left: 0;border-right: 0;"></div>
        </section>
  </div>


<!-- <c:import url="../common/footer.jsp"></c:import> -->


  <!-- 자바스크립트 파일 , socket.io 서버 -->
  <script src="/static/js/auction/chat.js"></script>
  <script src="/static/js/auction/getHTMLMediaElement.js"></script>
  <script src="/static/js/auction/RTCMultiConnection.js"></script>
  <script src="https://192.168.50.172:9001/socket.io/socket.io.js"></script>
  <script src="/static/js/auction/multi.js"></script>
  <script src="https://www.webrtc-experiment.com/common.js"></script>

</body>
</html>