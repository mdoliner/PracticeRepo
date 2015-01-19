NewsReader.Routers.Feeds = Backbone.Router.extend({
  routes: {
    "" : "feedIndex",
    "feeds/new" : "feedNew",
    "feeds/:id" : "feedShow"

  },

  initialize: function (options) {
    this._feedsCollection = new NewsReader.Collections.Feeds();
    this._feedsCollection.fetch();
    this.$el = options.$rootEl;
  },

  feedIndex: function (){
    var indexView = new NewsReader.Views.FeedsIndex({collection: this._feedsCollection});
    this.$el.html(indexView.render().$el);
  },

  feedShow: function (id) {
    var model = this._feedsCollection.getOrFetch(id);
    model.fetch();
    var showView = new NewsReader.Views.FeedShow({model: model});
    this.$el.html(showView.render().$el);
  },

  feedNew: function () {
    var newView = new NewsReader.Views.FeedForm({collection: this._feedsCollection});
    this.$el.html(newView.render().$el);
  }
});
