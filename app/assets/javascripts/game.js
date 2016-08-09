
var board = localStorage.getItem("gameboard");
$(document).ready(function(){
    if(board) {
        window.gameboard = JSON.parse(board);
        var cards = $('.flip-container');
        for(var i = 0; i<window.gameboard.length; i++){
            if(window.gameboard[i]){
                $(cards[i]).addClass('flipped');
            }
        }
    } else {
        window.gameboard = [];
    }
});
function toggleBoardMarker(index){
    window.gameboard[index] = !window.gameboard[index];
    localStorage.setItem("gameboard",JSON.stringify(window.gameboard));
}
function onAnswerReceived(ans){
    console.log(ans);
    $("#answer").text("YES");
    showAnswer();
}
function onQuestionReceived(message){
    $("#question").text("Hej?");
    onNotYourTurn();
}
function showLoading(){
    $(".loading").fadeIn("slow");
    $(".answer").hide();
    $(".not-your-turn").hide();
    $(".your-turn").hide();
}
function showAnswer(){
    $(".answer").fadeIn("slow");
    $(".loading").hide();
    $(".not-your-turn").hide();
    $(".your-turn").hide();
}
function onYourTurn(){
    $(".your-turn").fadeIn("slow");
    $(".loading").hide();
    $(".not-your-turn").hide();
    $(".answer").hide();
}
function onNotYourTurn(){
    $(".not-your-turn").fadeIn("slow");
    $(".loading").hide();
    $(".your-turn").hide();
    $(".answer").hide();
}
function answer(ans){
    if(ans==="yes"){
        $("#btn-answer-yes").addClass('selected');
        $("#btn-answer-no").removeClass('selected');
    } else {
        $("#btn-answer-yes").removeClass('selected');
        $("#btn-answer-no").addClass('selected');
    }
    // send to server
    $.post('/questions', {
        type: 'answer',
        msg: ans,
        id: window.gameId,
        slug: window.playerSlug
    }, function (data, status) {
        if (status !== 'success') {
            console.error(status, data);
        }
    });
    onYourTurn();
}
function ask(){
    var question = $("#question-input").val();
    $.post('/questions', {
        type: 'question',
        msg: question,
        id: window.gameId,
        slug: window.playerSlug
    }, function (data, status) {
        if (status !== 'success') {
            console.error(status, data);
        }
    });
    showLoading();
}
