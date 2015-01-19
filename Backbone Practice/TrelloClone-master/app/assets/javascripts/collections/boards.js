TrelloClone.Collections.Boards = Backbone.Collection.extend({

  model: TrelloClone.Models.Board,

  url: "api/boards",

  getOrFetch: function (id) {
    var board;
    if (!(board = this.get(id))) {
      board = new TrelloClone.Models.Board({id: id});
      board.fetch({
        success: function () {
          this.add(board);
        }.bind(this)
      });
    }
    return board;
  }

});
