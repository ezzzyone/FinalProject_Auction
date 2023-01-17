const websocket = new WebSocket("wss://192.168.0.38:80/chat");

websocket.onmessage = onMessage;
websocket.onopen = onOpen;
websocket.onclose = onClose;


$(window).on('beforeunload', function(){
    onClose();
});


//경매 시작 버튼 클릭 시 실행
$("#startauction").click(function(){
        
    // //입찰 disabled 풀기
    // $("#inputfree").removeAttr('disabled');
    // $("#free-bidding").removeAttr('disabled');
    // $("#unit-bidding").removeAttr('disabled');



    //ajax AUCTION 테이블 ING 컬럼 update 0으로 (경매 시작 후 입장 불가능)
    $.ajax({
        type:"POST",
        url:"/auction/change",
        data: {
            "auction_num": auction_num
        },
        success: function(result){
            // 성공 시 약관 팝업창

        }
    })

    $("#startauction").attr("disabled","");
    $("#pauseauction").removeAttr('disabled');

    websocket.send("[start]:[경매시작]");

})


// 추가 인원 허용 버튼 

// 경매 중지
$("#pauseauction").click(function(){

    // //입찰 disabled 적용
    // $("#inputfree").attr('disabled',"");
    // $("#free-bidding").attr('disabled',"");
    // $("#unit-bidding").attr('disabled',"");

    $("#startauction").removeAttr('disabled');

    $("#pauseauction").attr('disabled','');

    websocket.send("[중지]:[일시]");

})



// 경매 종료

$("#terminateauction").click(function(){

    let award = $("#currentprice").html();

    let awardarr = award.split("(");

    let lastprice = awardarr[0].replace(/,/g, "");
    lastprice *= 1;

    let user = awardarr[1].replace("입찰자 : ","");
    user = user.replace(" 님 )","");



    // 1. Product 테이블 id 값에 최종 입찰가 (현재가)로 입찰한 사람 식별해서 update , auction 테이블 bidding,award 도 업데이트 
    //최종 입찰가 현재가로 받아오고, id 를 받아와야함, members 테이블에서 포인트 - 로 업데이트
    $.ajax({
        type:"POST",
        url:"/auction/terminate",
        data: {
            "product_num":product_num,
            "auction_num":auction_num,
            "id":user,
            "award":lastprice,

        },
        success:function(result){
            
            console.log("경매종료 ajax 결과 값 : ", result);
            
            websocket.send("[낙찰자판별]:[종료]"+":"+result);
        }
    })

    // 2. location.replace 현재 사용자 (관리자 제외) 방출

})



  
  //경매 번호 
  let auction_num = $("#auction_num").val();
  //상품 번호 
  let product_num = $("#product_num").val();    

  let init = $("#currentprice").html();
  init += "";
  init = init.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
  $("#currentprice").html(init);

  let unitprice = $("#unitprice").html();
  unitprice = unitprice.replace(/,/g, "");
  unitprice *= 1;

  let checkmybidding = false;


  //내 보유 포인트
  let myinitpoint=$("#mypoint").html();

  //참여자 리스트
  let participants = [];

  //본인 id
  const username = $("#username").val();

  $("#disconn").on("click", (e) => {
      disconnect();
  })
  
  $("#send-msg").on("click", (e) => {
      send();
  });




  function send(){

      let msg = document.getElementById("chat-input");

      if(msg.value == '' || msg.value == ''+'\n'+''){
        Swal.fire({
            icon: 'error',
            text: '내용을 입력해주세요!'
          })
      }else{
        console.log(username + ":" + msg.value);
        websocket.send(username + ":" + msg.value);
        msg.value = '';
      }
  }
  
  //경매에서 나갔을 때
  function onClose(evt) {
      
    console.log("연결 해제 : " + evt);
    //현재가 currentprice에서 가져와서 숫자로 변경
    let curprice = $("#currentprice").html();
        curprice = curprice.split("(");
        curprice = curprice[0];

        curprice = curprice.replace(/,/g, "");
        curprice *=1;
    
    var str = "[퇴장]:"+ username + ": 님이 방을 퇴장하셨습니다."+":"+curprice;
    //   participants = participants.filter((element)=> element !== username);
    //   console.log(participants);
      websocket.send(str);
  }
  
  //경매에 들어왔을 때
  function onOpen(evt) {
      var str = "[입장]:"+username + ": 님이 입장하셨습니다.";
    //   participants.push(username);
    //   console.log(participants);
      websocket.send(str);
  }

  function onMessage(msg) {
    
      var data = msg.data;
      var sessionId = null;
      //데이터를 보낸 사람
      var message = null;
      var arr = data.split(":");

      var cur_session = username;

      //현재 세션에 로그인 한 사람
      sessionId = arr[0];
      message = arr[1];

      //로그인 한 클라이언트와 타 클라이언트를 분류(나)
      if(sessionId == cur_session){
          var str = "<div class='mymsg'>";
          str += "<span class='anothername'>"+sessionId+"(나)"+"</span>";
          str += "<span class='msg'>"+message +"</span>";
          str += "</div>";
          $("#chat-box").append(str);
      }else if(sessionId == '현재가'){
        // 입찰 상태 
        // 1. 현재가에 입찰가 입력
        $("#currentprice").html(arr[1]+"(입찰자 : "+arr[2]+" 님 )");
        // 2. 입찰자 판별 
            if(arr[2] != username){
                $("#mypoint").html(myinitpoint);
                checkmybidding = false;
            }
            var str = "<div class='d-flex justify-content-center'>";
            str +="<span>"+arr[2]+"님이 입찰하셨습니다."+"(현재가 : "+arr[1]+" 원)"+"</span>"
            str += "</div>";
            $("#chat-box").append(str);
      }else if(sessionId == '[입장]' || sessionId == '[퇴장]'){
        var str = "<div class='d-flex justify-content-center'>";
        str +="<span>"+arr[1]+arr[2]+"</span>"
        str += "</div>";
        $("#chat-box").append(str);
            if(sessionId == '[퇴장]'){
                for(var i = 0; i < participants.length; i++){ 
                    if (participants[i] === arr[1]) { 
                      participants.splice(i, 1); 
                      i--; 
                    }
                  }
                  
            }
      }else if(sessionId == '강퇴'){
        if(message == username){
            Swal.fire({
                icon: 'warning',
                text: '퇴장당하셨습니다.'
              })
            // location.replace("/");
        }
      }else if(sessionId == '[중지]'){
        var str = "<div class='d-flex justify-content-center'>";
        str +="<span>"+'경매가 일시중지 되었습니다.'+"</span>"
        str += "</div>";
        $("#chat-box").append(str);
        //입찰 disabled 적용
        $("#inputfree").attr('disabled',"");
        $("#free-bidding").attr('disabled',"");
        $("#unit-bidding").attr('disabled',"");
      }else if(sessionId == '[start]'){
        var str = "<div class='d-flex justify-content-center'>";
        str +="<span>"+'경매가 시작 되었습니다.'+"</span>"
        str += "</div>";
        $("#chat-box").append(str);
        //입찰 disabled 풀기
        $("#inputfree").removeAttr('disabled');
        $("#free-bidding").removeAttr('disabled');
        $("#unit-bidding").removeAttr('disabled');
      }else if(sessionId == "[낙찰자판별]"){
        //낙찰자일때
        if(arr[2] == username){
            alert("경매가 종료되었습니다. 최종 낙찰자로 선정되었습니다. 내 낙찰 목록을 확인해주세요.");
            location.replace("/auction/getmyproduct");
        }else if(username == "dw"){

        }else{
            alert("경매가 종료되었습니다. 최종 낙찰자로 선정되지 못했습니다. 홈으로 이동합니다.");
            location.replace("/");
            
        }
      }else if(sessionId == "[방송시작]"){
        if(username != message){

            setTimeout(() => $("#join-room").trigger('click'), 5000);
        }
      }else if(sessionId == "[전체참여자]"){
        for(let i = 1; i<arr.length; i++){
            participants[i-1] = arr[i];
        }
      }else if(sessionId == "[방송정지]"){
        // $("#videos-container").prepend('<h1 style="color: white;" id="realPause">⚠ 일시 중지</h1>');
        // $("#videos-container").attr("style","background-color: black;");
      }else if(sessionId == "[방송재개]"){
        
      }else if(sessionId == "[재조정]"){
        if(message == "[초기화]"){
            $("#currentprice").html(init);
            var str = "<div class='d-flex justify-content-center'>";
                str +="<span>"+"최고가 입찰자 퇴장으로 인해 현재가가 초기화 되었습니다"+" (현재가 : "+init+" 원)"+"</span>"
                str += "</div>";
            $("#chat-box").append(str);
        }else{
            let renewalprice = arr[2];
            renwalprice_number = renewalprice;
            renewalprice += "";
            renewalprice = renewalprice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            $("#currentprice").html(renewalprice+"(입찰자 : "+arr[1]+" 님 )");
            // 2. 입찰자 판별 
                if(arr[1] == username){
                    minusPoint(renwalprice_number);
                }
            var str = "<div class='d-flex justify-content-center'>";
                str +="<span>"+"최고가 입찰자 퇴장으로 인해 현재가/입찰자가 조정되었습니다."+" (현재가 : "+renewalprice+" 원,"+ arr[1]+" 님)"+"</span>"
                str += "</div>";
            $("#chat-box").append(str);

        }
      }
      else{
            var str = "<div class='anothermsg'>";
            str += "<span class='anothername'>"+sessionId+"</span>";
            str += "<span class='msg'>"+message +"</span>";
            str += "</div>"
          $("#chat-box").append(str);
      }
  }
  
    function enterkey(){
        if (window.event.keyCode == 13) {
            // 엔터키가 눌렸을 때
            send();

            $("#chat-input").val("");
        
        }
    }


    // =============================================================== UI 버튼 태그 함수 ===========================================================



    //경매 참여자 불러오기
    function getParticipants(){
        $("#chat-write").attr("style","display : none;");
        $("#chat-box").attr("style","display : none;");
        $("#bid-box").attr("style","display : none;");
        $("#participants-box").removeAttr("style");
        $("#participants").empty();
        let roleNum = $("#participants").attr("data-role");

        for(let i=0; i<participants.length; i++){
            
            if(roleNum == 0){
                if(participants[i] == username){
                    let code = '<li class="list-group-item d-flex justify-content-between align-items-center">'
                    +participants[i]+" 님 (관리자)"+'</li>';
                    $("#participants").prepend(code);
                }else{
                    let code = '<li class="list-group-item d-flex justify-content-between align-items-center">'
                    +participants[i]+
                    '<span class="badge bg-success rounded-pill" onclick="setBan(event)" style="cursor: pointer;" data-id='+""+participants[i]+""+'>강퇴</span></li>';
                    $("#participants").prepend(code);
                }
            }else{
                if(participants[i] == username){
                    let code = '<li class="list-group-item d-flex justify-content-between align-items-center">'
                    +participants[i]+" 님 (나)"+'</li>';
                    $("#participants").prepend(code);
                }else{
                    let code = '<li class="list-group-item d-flex justify-content-between align-items-center">'
                    +participants[i]+
                    '<span class="badge bg-success rounded-pill" onclick="setReport(event)" style="cursor: pointer;" data-id='+""+participants[i]+""+'>신고</span></li>';
                    $("#participants").prepend(code);
                }
            }
        

        }
    }

    //채팅 목록 불러오기
    function getChattingList(){
        $("#participants-box").attr("style","display : none;");
        $("#bid-box").attr("style","display : none;");
        $("#chat-write").removeAttr("style");
        $("#chat-box").removeAttr("style");



    }

    //입찰 페이지 불러오기
    function getBidPage(){
        $("#participants-box").attr("style","display : none;");
        $("#chat-write").attr("style","display : none;");
        $("#chat-box").attr("style","display : none;");
        $("#bid-box").removeAttr("style");
    }

    //방송 제어 화면 불러오기
    function getBroadControl(){
        $("#br-info").attr("style","display : none;");
        $("#accordionFlushExample").attr("style","display : none;");
        $("#control-broadcast").removeAttr("style");
    }

    //방송 정보 화면 불러오기
    function getInfo(){
        $("#control-broadcast").attr("style","display : none;");
        $("#accordionFlushExample").attr("style","display : none;");
        $("#br-info").removeAttr("style");
    }

    //경매 약관 불러오기
    function getLawInfo(){
        $("#br-info").attr("style","display : none;");
        $("#control-broadcast").attr("style","display : none;");
        $("#accordionFlushExample").removeAttr("style");
    }

    //================================================================= 동작 함수 ===============================================================

    //입찰 시 포인트 차감 함수
    function minusPoint(currentprice){
        //숫자타입으로 변환
        let mypoint = $("#mypoint").html();
        mypoint = mypoint.replace(/,/g, "");
        mypoint *= 1;

        mypoint = mypoint - currentprice;

        //스트링 타입으로 변환
        mypoint += "";

        //차감한 포인트 천단위 변환 후 표출
        mypoint = mypoint.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
        $("#mypoint").empty();
        $("#mypoint").text(mypoint);
        
    }

    //현재가 변경 함수(자유입찰)
    function changeCurPriceFree(finalinput){

        //포인트 차감
        minusPoint(finalinput);

        //스트링 타입으로 변환
        finalinput += "";
        //현재가 천단위 변환 후 return
        finalinput = finalinput.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");

        return finalinput;
    }


    //현재가 변경 함수(단위입찰)
    function changeCurPrice(unitprice){
        
        //넘버타입으로 변경
        let currentprice = $("#currentprice").html();
        currentprice = currentprice.split("(");
        currentprice = currentprice[0];

        console.log("단위입찰 시 현재가 변경함수 : ", currentprice);

        currentprice = currentprice.replace(/,/g, "");
        currentprice *=1;

        //계산
        currentprice = currentprice + unitprice;

        minusPoint(currentprice);


        //스트링 타입으로 변환
        currentprice += "";
        //현재가 천단위 변환후 return
        currentprice = currentprice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");



        return currentprice;
    }


    // 입찰하려는 가격과 내 보유 포인트 비교
    function getCompare(inputprice){
        //내 보유 포인트 넘버타입으로 변경
        let mypoint = $("#mypoint").html();
            mypoint = mypoint.replace(/,/g, "");
            mypoint *= 1;

        if(mypoint < inputprice){
            return false;
        }else{
            return true;
        }

    }



    // 자유입찰 input 태그 천단위 콤마 찍기 (keyup) 
    function getCalculate(obj) {
        obj.value = comma(uncomma(obj.value));
    }
   
    function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    }
   
    function uncomma(str) {
        str = String(str);
        return str.replace(/[^\d]+/g, '');
    }


    //천단위 절사 (change 이벤트)
    function getCalculate2(obj){
        let cal = uncomma(obj.value);
        if(cal*1 > 1000){
            cal = Math.floor(cal/1000) * 1000;
            obj.value = comma(cal);
        }
    }



    //1. 자유 가격 입찰 버튼 클릭 시 실행
    function setFreeBidding(){
        
        //현재가
        let curprice = $("#currentprice").html();
        curprice = curprice.split("(");
        curprice = curprice[0];

        curprice = curprice.replace(/,/g, "");
        curprice *=1;

        //검증 1 : 보유포인트와 입찰하려는 가격 비교
        //보유포인트와 가격 비교
        //inputfree 계산
        let inputfree = $("#inputfree").val();
        inputfree = inputfree.replace(/,/g, "");
        inputfree *= 1;
        
        let compare = getCompare(inputfree);

        if(!compare){
            alert("보유 포인트가 부족합니다.");
            return;
        }

        //검증 2 : 현재가와 입찰하려는 가격 비교
        if(inputfree < curprice){
            alert("입찰가격은 현재가 보다 높아야 합니다.");
            return;
        }


        //검증 3 : 현재 내가 입찰 중인 가격이 최고가 인지 확인
        if(checkmybidding){
            alert("현재 "+username+"님이 최고가로 입찰 중입니다.");
            return;
        }

        //검증 4 : 자유 입찰 여부 확인
        let result = window.confirm("입찰가 "+$("#inputfree").val()+"으로 입찰 하시겠습니까?");
        if(!result){
            return;
        }


        // ==== 검증 끝 =====

        let finalinput = $("#inputfree").val();
        finalinput = finalinput.replace(/,/g, "");
        finalinput *= 1;

        let finalinput_number=finalinput;

         //현재가 변경 및 포인트 차감(천단위 변경 후 리턴)
         finalinput = changeCurPriceFree(finalinput);


         //내 입찰상태 변경 => true
         checkmybidding = true;
 
         websocket.send("현재가:"+finalinput+":"+username+":"+finalinput_number);


    }


    //2.단위 가격 입찰 버튼 클릭 시 실행
    function setUnitBidding(){
        

        //검증 1 : 보유포인트와 입찰하려는 가격 비교
        //보유포인트와 가격 비교
        //inputprice 계산 
        let inputprice = $("#currentprice").html();

        inputprice = inputprice.split("(");
        inputprice = inputprice[0];


        inputprice = inputprice.replace(/,/g, "");
        inputprice *=1;
        inputprice = inputprice + unitprice;

        let compare = getCompare(inputprice);

        if(!compare){
            alert("보유 포인트가 부족합니다.");
            return;
        }

        //검증 2 : 현재 내가 입찰 중인 가격이 최고가 인지 확인
        if(checkmybidding){
            alert("현재 "+username+"님이 최고가로 입찰 중입니다.");
            return;
        }

        // 검증 3 : 단위가격으로 입찰 여부 확인
        let result = window.confirm("단위가격으로 입찰 하시겠습니까?");
        if(!result){
            return;
        }

        let inputprice_number = inputprice;

        // 검증 완료 시 진행

        //현재가 변경 및 포인트 차감
        let currentprice = changeCurPrice(unitprice);


        //내 입찰상태 변경 => true
        checkmybidding = true;

        websocket.send("현재가:"+currentprice+":"+username+":"+inputprice_number);

    }

    //신고하기 버튼 클릭
    function setReport(event){

        let user = event.target.getAttribute('data-id');

        let result = window.confirm(user+"님을 신고하시겠습니까?");

        if(result){
            let link ="/kdy/reportRequest?report_id="+user;

            window.open(link);
        }
    }


    // 강퇴하기 버튼 클릭 이벤트
    function setBan(event){
        
        let result = window.confirm("강퇴하시겠습니까?");

        if(result){
        
        let user = event.target.getAttribute('data-id');

        websocket.send("강퇴:"+user);
        }

    }

//})

