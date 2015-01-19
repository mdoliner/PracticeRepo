TrelloClone.Views.ListCreate = Backbone.View.extend({

  template: JST['lists/form'],

  tagName: "form",

  events: {
    "submit": "createList"
  },

  render: function () {
    var content = this.template({board: this.model});
    this.$el.html(content);
    return this;
  },

  createList: function (event) {
    event.preventDefault();

    var data = $(event.target).serializeJSON();
    var list = new TrelloClone.Models.List();
    list.save(data, {
      success: function () {
        this.collection.add(list);
        Backbone.history.navigate("boards/" + list.get("board_id"), {trigger: true});
      }.bind(this),
      error: function (model, response) {
        var $errors = this.$el.find(".errors");
        $errors.empty().html(response.responseJSON);
      }.bind(this)
    });
  }

});
