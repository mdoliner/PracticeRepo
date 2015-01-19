NewsReader.Views.EntryItem = Backbone.View.extend({

  template: JST['feeds/entry_item'],

  tagName: 'li',

  className: "entry-item",

  render: function () {
    var content = this.template({model: this.model});
    this.$el.html(content);
    return this;
  },

  leave: function () {
    this.remove();
  }
});
