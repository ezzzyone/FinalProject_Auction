console.log("modify.js");


function nullCheck(data, dest, kind){
    if(data == null || data == ''){
        $(dest)
        return false;
    }else{
        return true;
    }
}

function equals (data, checkDate) {
    if(data == checkDate) {
        return true;
    } else {
        return false;
    }
}


        
$("#memberFileAdd").change(function(){

    let mv = $("#memberFileAdd").val();
    console.log("mv : " , mv);
    console.log("확인");
    if(mv != null){
        console.log("사진이 있따");
    
        $("#spa").html("사진이 등록되었습니다.");
    }else if(mv == null){
        console.log("현재 없음");
        $("#spa").html("현재 첨부파일이 존재하지 않습니다.")
    }
});

$("#memberFileAdd").blur(function(){

    let mv = $("#memberFileAdd").val();

    if(mv == null){
        console.log("현재 없음")
        $("#spa").html("현재 첨부파일이 존재하지 않습니다.")
    }

});

// $("#membrerFileAdd").ready(function(){

//     let mv = $("#memberFileAdd").val();

//     if(mv == null){
//         console.log("현재 없음")
//         $("#spa").html("현재 첨부파일이 존재하지 않습니다.")
//     }

// })



$("#amd").click(function(){

    console.log("엘렐레렐레레레레");
    $("#md").trigger('click');

});





//마이페이지에서 수정쪽을 누르면 비밀번호 일치해야 수정페이지가 나오게 해주는 ajax

// $('#successBtn').click(function() {
//     const checkPassWord = $('#inputPassWord2').val();
//     const id = $("#thisId").val();
//     console.log("checkPassWord :", checkPassWord);
//     console.log("id: ", id);
//     if(checkPassWord == ""){
//         alert("비밀번호를 입력하세요.");
//     } else{
//         $.ajax({
//             type: 'GET',
//             url: '/members/modify1?id='+id+'&checkPassWord='+checkPassWord
            
//         }).done(function(check){
//             console.log(check);
//             if(check){  //비밀번호 비교가 true라면
//                 console.log("비밀번호 일치");
//                 alert("비밀번호가 일치하여 회원수정 페이지로 이동합니다..");
//                 // swal({
//                 //     title: "비밀번호 일치!",
//                 //     text: "수정 페이지로 넘어갑니다.",
//                 //     icon: "success",
//                 //     button: "확인",
//                 //   });
//                 window.location.href="./modify";
//             } else{
//                 console.log("비밀번호 틀림");
//                 // 비밀번호가 일치하지 않으면
//                 alert("비밀번호가 맞지 않습니다.");
//                 /* window.location.href="/"; */
//             }
//         }).fail(function(error){
//             alert(JSON.stringify(error));
//         })
//     }
// });


// 패스워드, 패스워드 체크, 닉네임, 이메일, 전화번호 
// let results = [false, false, false, false, false];
let results1 = [false, false, false];

//passWord체크

// $("#inputPassWord").on({
//     blur:function(){
//         let result = nullCheck($("#inputPassWord").val());
//         results[0] = result;
//         if(result){
//             $("#pwHelp").html("정상");
//         }else{
//             $("#pwHelp").html("패스워드는 필수입니다.");
//             $("#inputPassWord").focus();
//         }
//     },

//     change:function(){
//         let result = equals($("#inputPassWord").val(), $("#inputPassWordCheck").val());

//         if(result){ //패스워드와 확인이 같다면,
//             $("#pwCheckHelp").html("");
//         }else{
//             $("#pwCheckHelp").html("비밀번호가 일치하지 않습니다.")
//             $("#pwHelp").val("");   //비밀번호가 일치하지 않다면 비밀번호를 공백으로 바꾼다.
//             $("inputPassWordCheck").focus();

//             results[0] = result;
//         }
//     }
// });

// //패스워드 확인 검증
// $("#inputPassWordCheck").blur(function(){

//     let result = equals($("#inputPassWord").val(), $("#inputPassWordCheck").val());

//     results[1] = result;

//     if(result){
//         $("#pwCheckHelp").html("패스워드가 일치합니다.");
        
//     }else{
//         $("#pwCheckHelp").html("패스워드가 불일치 합니다.");
//     }

// });

//닉네임 검증
// $("#inputNickName").click(function(){

//     console.log("클릭");


// })

$("#inputNickName").blur(function(){

    let result = nullCheck($("#inputNickName").val());

    results1[0] = result;

    if(result){
        $("#nickNameHelp").html("정상입니다.");
    }else{
        $("#nickNameHelp").html("닉네임 입력은 필수입니다.");
    }

});

//이메일 정규식 검증
function isEmail(asValue) {
	var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;



	return regExp.test(asValue);

}

$("#inputEmail").blur(function(){

    let result = nullCheck($("#inputEmail").val());
    results1[1] = result;

    if($("#inputEmail").val() == ''){
        $("#inputEmail").focus();
        $("#emailHelp").html("이메일을 확인해주세요.");
    }else if(!isEmail($("#inputEmail").val())){
        $("#inputEmail").focus();
        $("#emailHelp").html("이메일 형식을 확인해주세요");
    }else{
        $("#emailHelp").html("정상입니다.");
    }

});



const autoHyphen = (target) => {
    target.value = target.value
      .replace(/[^0-9]/g, '')
     .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
   }



   function phoneFormat(phoneNumber){

    
    //특수문자 제거
    const value = phoneNumber.replace(/[^0-9]/g, '');

    // 00 또는 000 지정

    const firstLength = value.length > 9 ? 3 : 2;


  
    
        
        // ({2,3}) - ({3,4}) - ({4})
        return [
            //첫번째 구간 (00 or 000)
            value.slice(0, firstLength),
            //두번째 구간 (000 or 0000)
            value.slice(firstLength, value.length - 4),
            //남은 마지막 모든 숫자
            value.slice(value.length),
        ].join('-');
}


phoneFormat('01012345678');

//전화번호 중복검사
$("#inputPhone").blur(function(){
    let result = nullCheck($("#inputPhone").val());
    
    results1[2] = result;
    
        if($("#inputPhone").val() == ''){
            $("#phoneHelp").focus();
            $("#phoneHelp").html("휴대전화 번호를 입력해주세요.");
        }else{
            $("#phoneHelp").html("");
        }
    
        // if($("#inputPhone").val() != '1', '0', '2', '3', '4', '5', '6', '7', '8', '9', '-' ){
        //     $("#phoneHelp").html("숫자를 입력해주세요");
        // }else{
        //     $("#phoneHelp").html("");
        // }
    });

$("#signUpBtn").click(function(){

    if(results1.includes(false)){    //배열에 해당 (data)가 존재하는지 여부 판단
        alert("필수 입력 사항은 입력해주세요.")
    }else{
        //필수입력사항을 다 입력했다면 회원가입 폼으로 전송
        $("#signUpForm").submit();
    }

});



//회원탈퇴 버튼 클릭
$("#dropBtn").click(function(){

    console.log("버튼클릭");
    console.log($("#inputPassWord").val());

    $("#md").trigger('click');


});