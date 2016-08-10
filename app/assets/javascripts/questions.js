$(document).ready(function () {
  
  App.cable.subscriptions.create({
    channel: "QuestionsChannel",
    id: window.gameId,
  }, {
    received: function(data) {
      if(data.slug!=window.playerSlug){
        console.log(data);
        if (data.type === 'answer') {
          // show answer
          onAnswerReceived(data.msg);
        } else if (data.type === 'lost' && data.slug!=window.playerSlug) {
          onWin();
        } else if(data.type === 'newgame'){
          window.location.href = '/games/' + data.msg;
        } else {
          // show questsion
          onQuestionReceived(data.msg);
        }
      }
    },
  });
});
