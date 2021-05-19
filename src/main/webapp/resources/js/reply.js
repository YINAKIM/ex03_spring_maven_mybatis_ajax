console.log("Reply Module...............!!!!");

//  즉시실행함수 : 함수 정의하자마자 즉시 실행하는 함수
// (function(){})(); ---> 첫번째 괄호 안에 익명함수 선언, 함수 내부에 선언되 변수는 외부에서 접근불가 /
//                          함수의 return값은 함수실행 결과값이고 밖에 선언한 변수에 바로 값을 담는다
//                        두번째 괄호(빈괄호) 보고 js엔진이 함수를 즉시 해석하고 실행시킨다


// ajax를 이용해서 POST방식으로 호출하는 add함수
var replyService = (function(){
    function add(reply, callback, error){
        console.log("reply..................add");

        $.ajax({
            type:'post',
            url:'/replies/new',
            data:JSON.stringify(reply), // js객체를 String으로 변환(서버로 전송할 데이터)
            contentType : "application/json; charset=utf-8",
            success:function(result,status,xhr){
                //요청 성공 시 콜백할 함수
                if(callback){
                    callback(result);
                }
            },  //success
            error:function(xhr,status,er){
                //에러발생시 콜백할 함슈
                if(error){
                    error(er);
                }

            }//error
        })//ajax

    }//add

    return {add:add};   // 함수가 아니라 값을 리턴하는게 [즉시실행함수]의 문법,
                        // 여기서는 add함수 자체를 객체로 리턴하는 것 ---> add()가 아니라 add



})();


