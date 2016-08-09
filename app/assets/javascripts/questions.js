App.cable.subscriptions.create({
  channel: "QuestionsChannel",
  // TODO: change so that this is per game and not hard coded
  id: "2",
}, {
  received: function(data) {
    // do something sane with the data here, separate if question or answer etc
    console.log(data);
  },
});
