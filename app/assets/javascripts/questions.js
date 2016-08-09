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
        } else {
          // show questsion
          onQuestionReceived(data.msg);
        }
      }
    },
  });
});
