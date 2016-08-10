
$('#top-panel').ready(function(){
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
        console.log('a')
        onYourTurn();
    } else {
        console.log('b')
        showLoading();
    }
});
function playSong(url){
    var audio = new Audio();
    audio.src = url;
    audio.play();
}
function newGame(same){
    var playlist_uri = window.playlist_uri;
    if(!same) {
        playlist_uri = $('#new-game-input').val();
    }
    $.post('/newgame', {
        playlist_uri: playlist_uri,
    }, function (newGame, status) {
        if (status !== 'success') {
            console.error(status, newGame);
        } else {
        $.post('/questions', {
            type: 'newgame',
            msg: newGame.guest_player_slug,
            id: window.gameId,
            slug: window.playerSlug
        }, function (data, status) {
            if (status !== 'success') {
                console.error(status, data);
            } else {
                window.location.href = '/games/' + newGame.init_player_slug;
            }
        });
        }
    });

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
    if (cleanCompare(message,window.artistName)){
        onLose();
    }
    $("#question").text(message);
    onNotYourTurn();
}
function cleanCompare(a1,a2){
    return a1.replace('-',' ').toUpperCase().contains(a2.replace('-',' ').toUpperCase());
}
function onLose() {
    window.lost = true;
}
function onLossAccepted() {
    $(".lost").fadeIn("slow");
    $(".answer").hide();
    $(".not-your-turn").hide();
    $(".your-turn").hide();
    $(".loading").hide();
}
function onWin() {
    $(".won").fadeIn("slow");
    $(".loading").hide();
    $(".answer").hide();
    $(".not-your-turn").hide();
    $(".your-turn").hide();
    $(".lost").hide();
}
function showLoading(){
    $(".loading").fadeIn("slow");
    $(".answer").hide();
    $(".not-your-turn").hide();
    $(".your-turn").hide();
    $(".lost").hide();
    $(".won").hide();
}
function showAnswer(){
    $(".answer").fadeIn("slow");
    $(".loading").hide();
    $(".not-your-turn").hide();
    $(".your-turn").hide();
    $(".lost").hide();
    $(".won").hide();
}
function onYourTurn(){
    $(".your-turn").fadeIn("slow");
    $(".loading").hide();
    $(".not-your-turn").hide();
    $(".answer").hide();
    $(".lost").hide();
    $(".won").hide();
    $("#btn-answer-no").removeClass('selected');
    $("#btn-answer-yes").removeClass('selected');
}
function onNotYourTurn(){
    $(".not-your-turn").fadeIn("slow");
    $(".loading").hide();
    $(".your-turn").hide();
    $(".answer").hide();
    $(".lost").hide();
    $(".won").hide();
}
function answer(ans){
    if(ans==="yes"){
        $("#btn-answer-yes").addClass('selected');
        $("#btn-answer-no").removeClass('selected');
    } else {
        $("#btn-answer-yes").removeClass('selected');
        $("#btn-answer-no").addClass('selected');
    }
    if(window.lost){
        if(ans==="yes"){
            $.post('/questions', {
                type: 'lost',
                msg: ans,
                id: window.gameId,
                slug: window.playerSlug
            }, function (data, status) {
                onLossAccepted();
                if (status !== 'success') {
                    console.error(status, data);
                }
            });
        } else {
            alert("Really? Trying to cheat? Come on! D:");  
        }
    } else {
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
function showTrivia() {
    $('#your-artist-box').fadeOut('fast', function () {
        $('#your-artist-trivia').fadeIn('fast');
    });
}
function hideTrivia() {
    $('#your-artist-trivia').fadeOut('fast', function () {
        $('#your-artist-box').fadeIn('fast');
    });
}
