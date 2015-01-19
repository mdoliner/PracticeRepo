NewsReader.Collections.Feeds = Backbone.Collection.extend({

  model: NewsReader.Models.Feed,

  url: "api/feeds",

  getOrFetch: function (id) {
    var feeds = this;
    var feed;
    if (!(feed = feeds.get(id))) {
      feed = new NewsReader.Models.Feed({id: id});
      feed.fetch({
        success: function () {
          feeds.add(feed);
        }
      });
    }

    return feed;
  }

});
