TrelloClone.Views.BoardCreate = Backbone.View.extend({

  template: JST['boards/form'],

  tagName: "form",

  events: {
    "submit": "createBoard"
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  createBoard: function (event) {
    event.preventDefault();

    var data = $(event.target).serializeJSON();
    var board = new TrelloClone.Models.Board();
    board.save(data, {
      success: function () {
        this.collection.add(board);
        Backbone.history.navigate("boards/" + board.id, {trigger: true});
      }.bind(this),
      error: function (model, response) {
        var $errors = this.$el.find(".errors");
        $errors.empty().html(response.responseJSON);
      }.bind(this)
    });
  }

});
