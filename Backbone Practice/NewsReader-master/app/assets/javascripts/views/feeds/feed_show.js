NewsReader.Views.FeedShow = Backbone.View.extend({

  template: JST['feeds/show'],

  events: {
    "click .refresh": "refresh"
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.subViews = [];
  },

  refresh: function () {
    this.model.fetch();
    this.render();
  },

  render: function () {
    var content = this.template({model: this.model});
    this.$el.html(content);
    var that = this;
    this.model.entries().each(function (entry) {
      var view = new NewsReader.Views.EntryItem({model: entry});
      that.$el.find("ul.entry-list").append(view.render().$el);
      that.subViews.push(view);
    });

    return this;
  },

  leave: function () {
    this.subViews.forEach( function (subView) {
      subView.leave();
    });
    this.remove();
  }
});
