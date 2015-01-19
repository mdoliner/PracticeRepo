window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var router = new TrelloClone.Routers.Boards();
    Backbone.history.start();
  }
};

$(document).ready(function(){
  TrelloClone.initialize();
});
