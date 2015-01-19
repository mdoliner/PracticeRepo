TrelloClone.Views.BoardsIndex = Backbone.CompositeView.extend({

  template: JST['boards/index'],

  tagName: "main",

  render: function () {
    var content = this.template();
    this.$el.html(content);
    var $boardList = this.$el.find(".board-list");
    this.collection.forEach(function (board) {
      var boardView = new TrelloClone.Views.BoardItem({model: board});
      this.attachSubview($boardList, boardView.render());
    }.bind(this));

    return this;
  }

});
