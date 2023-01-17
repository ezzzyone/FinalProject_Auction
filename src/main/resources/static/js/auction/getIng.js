

function getIngAuction(data){
    

    $.ajax({
        type:"GET",
        url:"/auction/ing",
        success: function(result){
            if(result.length == 0){
                // 현재 진행중인 방송이 없으면

                location.href='/kdy/auctionAdd?product_num='+data;

            }else{
                // 현재 진행중인 방송이 있으면

                alert("현재 진행중인 방송이 있습니다.");

            }
        }
    })
}