TrelloClone.Views.BoardItem = Backbone.CompositeView.extend({

  template: JST['boards/board_item'],

  tagName: "li",

  render: function () {
    var content = this.template({board: this.model});
    this.$el.html(content);
    return this;
  }

});
