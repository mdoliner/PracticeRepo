window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(options) {
    var router = new NewsReader.Routers.Feeds(options);
    Backbone.history.start();
  }
};
