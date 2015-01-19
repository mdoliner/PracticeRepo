TrelloClone.Views.CardCreate = Backbone.View.extend({

  template: JST['cards/form'],

  tagName: "form",

  events: {
    "submit": "createCard"
  },

  render: function () {
    var content = this.template({list: this.model});
    this.$el.html(content);
    return this;
  },

  createCard: function (event) {
    event.preventDefault();

    var data = $(event.target).serializeJSON();
    var card = new TrelloClone.Models.Card();
    card.save(data, {
      success: function () {
        Backbone.history.navigate("boards/" + this.model.get("board_id"), {trigger: true});
      }.bind(this),
      error: function (model, response) {
        var $errors = this.$el.find(".errors");
        $errors.empty().html(response.responseJSON);
      }.bind(this)
    });
  }

});
