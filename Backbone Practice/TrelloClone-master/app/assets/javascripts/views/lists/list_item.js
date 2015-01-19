TrelloClone.Views.ListItem = Backbone.CompositeView.extend({

  template: JST['lists/list_item'],

  tagName: "li",

  className: "list",

  events: {
    "click .new-card a": "newCard"
  },

  render: function () {
    var content = this.template({list: this.model});
    this.$el.html(content);
    var $cards = this.$el.find(".cards");
    var cards = this.model.cards().sortBy(function(card) { card.ord });
    cards.forEach(function (card) {
      var cardView = new TrelloClone.Views.CardItem({model: card});
      this.attachSubview($cards, cardView.render());
    }.bind(this));
    return this;
  },

  newCard: function () {
    var view = new TrelloClone.Views.CardCreate({ model: this.model});
    this.$el.find(".new-card").html(view.render().$el);
  }

});
