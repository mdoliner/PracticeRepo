TrelloClone.Models.Card = Backbone.Model.extend({

  urlRoot: "api/cards",

  toJSON: function () {
    return { card: _.clone(this.attributes) };
  }

});
