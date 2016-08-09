
function onAnswerReceived(ans){
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
        id: window.gameId
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
        id: window.gameId
    }, function (data, status) {
        if (status !== 'success') {
            console.error(status, data);
        }
    });
    showLoading();
}
