TrelloClone.Models.List = Backbone.Model.extend({

  urlRoot: "api/lists",

  toJSON: function () {
    return { list: _.clone(this.attributes) };
  },

  cards: function () {
    if (!this._cards) {
      this._cards = new TrelloClone.Collections.Cards([], {list: this});
    }

    return this._cards;
  },

  parse: function (payload) {
    if (payload.cards) {
      this.cards().set(payload.cards, { parse: true });
      delete payload.cards;
    }

    return payload;
  }


});
