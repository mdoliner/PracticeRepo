TrelloClone.Routers.Boards = Backbone.Router.extend({
  initialize: function () {
    this.$el = $("#main");
    this._boards = new TrelloClone.Collections.Boards();
    this._lists = new TrelloClone.Collections.Lists();
  },

  routes: {
    "": "boardsIndex",
    "boards/new": "newBoard",
    "boards/:id/lists/new" : "newList",
    "boards/:id/delete" : "deleteBoard",
    "boards/:id": "showBoard",
    "lists/:id/cards/new": "newCard"

  },

  boardsIndex: function () {
    this._boards.fetch({
      success: function () {
        var view = new TrelloClone.Views.BoardsIndex({ collection: this._boards });
        this.$el.html(view.render().$el);
      }.bind(this)
    });

  },

  newBoard: function () {
    var view = new TrelloClone.Views.BoardCreate({collection: this._boards});
    this.$el.html(view.render().$el);
  },

  showBoard: function (id) {
    var board = this._boards.getOrFetch(id);
    board.fetch( {
      success: function () {
        var view = new TrelloClone.Views.BoardShow({model: board});
        this.$el.html(view.render().$el);
      }.bind(this)
    });
  },

  deleteBoard: function (id) {
    this._boards.getOrFetch(id).destroy();
    this.boardsIndex();
  },

  newList: function (id) {
    var board = this._boards.getOrFetch(id);
    board.fetch({
      success: function () {
        var view = new TrelloClone.Views.ListCreate({ model: board, collection: board.lists() });
        this.$el.html(view.render().$el);
      }.bind(this)
    })
  }
});

//swap view
