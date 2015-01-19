NewsReader.Views.FeedsIndex = Backbone.View.extend({

  template: JST['feeds/index'],

  events: {
    "click .delete": "deleteFeed"
  },

  initialize: function () {
    this.listenTo(this.collection, 'sync destroy', this.render);
  },

  deleteFeed: function (event) {
    event.preventDefault();

    var $target = $(event.target);
    var id = $target.data('id');
    var model = this.collection.get(id);
    model.destroy();
  },

  render: function () {
    var content = this.template({ collection: this.collection});
    this.$el.html(content);
    return this;
  }
});
