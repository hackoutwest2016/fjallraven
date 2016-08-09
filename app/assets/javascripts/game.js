function onYourTurn(){
    $(".your-turn").fadeIn("slow");
    $(".not-your-turn").hide();
}
function onNotYourTurn(){
    $(".not-your-turn").fadeIn("slow");
    $(".your-turn").hide();
}
function answer(ans){
    if(ans==="yes"){
        $("#btn-answer-yes").addClass('selected');
        $("#btn-answer-no").removeClass('selected');
    } else {
        $("#btn-answer-yes").removeClass('selected');
        $("#btn-answer-no").addClass('selected');
    }
    setTimeout(function(){onYourTurn()},2000);
    setTimeout(function(){onNotYourTurn()},4000);
}