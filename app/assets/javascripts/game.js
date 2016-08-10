
$(document).ready(function(){
    var audio
    var board = localStorage.getItem(window.playerSlug+"gameboard");
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
    if(window.startingPlayer){
        onYourTurn();
    } else {
        showLoading();
    }

    $("#play-btn").on("click", function() {
      if($(this).hasClass("playing")) {
        pauseSong($(this).data().previewUrl);
      } else {
        playSong($(this).data().previewUrl);
      }
      $(this).toggleClass("playing");
      $(this).toggleClass("paused");
    });
});
function playSong(url){
    audio = new Audio();
    audio.src = url;
    audio.play();
}
function pauseSong(url){
    audio.pause();
}
function toggleBoardMarker(index){
    window.gameboard[index] = !window.gameboard[index];
    localStorage.setItem(window.playerSlug+"gameboard",JSON.stringify(window.gameboard));
    localStorage.setItem("playerSlug",window.playerSlug);
}
function onAnswerReceived(ans){
    $("#answer").text(ans.toUpperCase());
    showAnswer();
}
function onQuestionReceived(message){
    console.log(message);
    $("#question").text(message);
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
    $("#btn-answer-no").removeClass('selected');
    $("#btn-answer-yes").removeClass('selected');
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
    $("#question-input").val('');
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
