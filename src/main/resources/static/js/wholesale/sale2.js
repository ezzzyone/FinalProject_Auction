//api authURL : URL을 상수로 선언. 보통은 properies에 선언하여 사용함
let apiURL = 'https://at.agromarket.kr/openApi/price/sale.do';

//페이징 js에서 하는 이유 - 데이터를 js에서 가공하고 페이지이동없이 ajax로 처리하기 위함 
//json 호출하기 
//https://cors-anywhere.herokuapp.com/ 크로스 에러 떠서 프록시서버 설정 추가

function getJSON(i) {
    let pageNo = 1;
    let perPage = 10;
    let perBlock = 10;
    let startBlock = (i-1)*perBlock;
    let lastBlock = i*perBlock;
    let whsalCd = $("#whsalCd").val();
    let saleDate = $("#saleDate").val();
    let largeCd = $("#largeCd").val();
   let url = 'https://cors-anywhere.herokuapp.com/'+apiURL
        $.ajax({
        type:"get",
        url: url,
        data: {
            serviceKey:'9596499878664F83A1D560AE3808376E',
            apiType:'json',
            pageNo:pageNo,
            whsalCd:whsalCd,
            saleDate:saleDate
        },
        Headers:{
            "Access-Control-Allow-Origin":"*"
        },
        crossOrigin: true,
        dataType:"json",
        success: function(jsonData){
            let totPage = parseInt(jsonData.totCnt/1000) //필수 파라미터로 넘겨야하는 페이지수
            if(jsonData.totCnt%1000>0){ //나머지값이 있다면 뷰 추가
                totPage++
            }
            //
          let totalBlock = jsonData.dataCnt/perBlock //1페이지 당 페이징 블럭 수 
            if(jsonData.dataCnt%perBlock>0){ //나머지값이 있다면 뷰 추가
                totalBlock++
            }
            if(i<1){
                i =1;
            }

            let startRow =(i-1)*perPage;
            let lastRow = i*perPage;
            let pagings = '';
     

            dis='';
            blo='';
            dis2='';
          
            if(i<2){
              dis = '<li class="page-item disabled">' ;
           }else{
               dis ='<li class="page-item">' ;
           }
          
           for(let i=startBlock; i<lastBlock; i++){
              blo +=  '<li class="page-item"><a class="page-link" onclick="getJSON('+i+')">'+i+'</a></li>'
          }
          
          if(i>=totalBlock){
              dis2 = '<li class="page-item disabled">' 
           }else{
              dis2 = '<li class="page-item">' 
           }
          
          
              pagings += '<div class="chefs section-bg" style="padding-bottom: 10px;">' +
              '<nav aria-label="Page navigation example">' +
                '<ul class="pagination">'
                     + dis
                      +  '<a class="page-link" onclick=" getJSON(i)" aria-label="Previous">' +
                          '<span aria-hidden="true">&laquo;</span></a></li>' 
                          + blo
                           +dis2
                           + '<a class="page-link" onclick=" getJSON(i)" aria-label="Next">' +
                          '<span aria-hidden="true">&raquo;</span></a></li></ul></nav></div>'

            // for(let i=1; i<totalBlock; i++){
            //     pagings += '<button type="button" onclick="getJSON('+i+')">'+i+'</button>';
        
            // }
           
            console.log("통신성공");
            console.log(jsonData);
            console.log("cnt=="+jsonData.totCnt);//총데이터건수
            console.log("cnt=="+jsonData.dataCnt);//페이지데이터건수
            console.log("url=="+url);//요청 url
            console.log(totPage);
            console.log("totalBlock ="+totalBlock);
            console.log("startRow ="+startRow);
            console.log("lastRow ="+lastRow);
            console.log("startBlock ="+startBlock);
            console.log("lastBlock ="+lastBlock);
            console.log("pagingHtml ="+pagings);
            console.log("jsonData.data[2].saleDate"+jsonData.data[2].saleDate);

            $('.table_body').empty();
            $('.plsPage').empty();
            $('.paging').empty();

            str = '<TR>'; 
            for(let j=startRow; j<lastRow+1; j++){
             str += '<TD>' + jsonData.data[j].saleDate + '</TD>'+
                '<TD>' + jsonData.data[j].whsalName + '</TD>'+
                '<TD>' + jsonData.data[j].cmpName + '</TD>'+
                '<TD>' + jsonData.data[j].smallName + '</TD>';
             str += '</TR>';
             }



            $('.table_body').append(str);
            $('.plsPage').append('<h3>총페이지수:'+totPage+'</h3>');
            $('.paging').append(pagings);
           
        },
        error:function(){
            console.log("통신에러");
        }
    })
}


// function getBlock(startBlock){
//     $('.pagingFuntion').empty();
//     let totalBlocks = totalBlock;
    
//     console.log("bbbbbbbbbb=="+totalBlocks);
//     let perBlock = 10;
//     let startBlock = (i-1)*perBlock;
//     let lastBlock = i*perBlock;

//   dis='';
//   blo='';
//   dis2='';

//   if(i<2){
//     dis = '<li class="page-item disabled">' ;
//  }else{
//      dis ='<li class="page-item">' ;
//  }

//  for(let i=startBlock; i<lastBlock; i++){
//     blo +=  '<li class="page-item"><a class="page-link" onclick="getJSON('+i+')">'+i+'</a></li>'
// }

// if(i>=totalBlock){
//     dis2 = '<li class="page-item disabled">' 
//  }else{
//     dis2 = '<li class="page-item">' 
//  }


//     pagings += '<div class="chefs section-bg" style="padding-bottom: 10px;">' +
//     '<nav aria-label="Page navigation example">' +
//       '<ul class="pagination">'
//            + dis
//             +  '<a class="page-link" onclick="getBlock(i-1)" aria-label="Previous">' +
//                 '<span aria-hidden="true">&laquo;</span></a></li>' 
//                 + blo
//                  +dis2
//                  + '<a class="page-link" onclick="getBlock(i-1)" aria-label="Next">' +
//                 '<span aria-hidden="true">&raquo;</span></a></li></ul></nav></div>'

//                 $('.pagingFuntion').append(pagings2);

// }


