App.cable.subscriptions.create({
  channel: "QuestionsChannel",
  // TODO: change so that this is per game and not hard coded
  id: "2",
}, {
  received: function(data) {
    console.log(data);
    if (data.type === 'answer') {
      // show answer
      // onAnswerReceived(data.msg);
    } else {
      // show questsion
      // onQuestionReceived(data.msg);
    }
  },
});
