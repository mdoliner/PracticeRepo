TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({

  template: JST['boards/show'],

  tagName: "span",

  render: function () {
    var content = this.template({board: this.model});
    this.$el.html(content);
    var $lists = this.$el.find(".lists");
    var lists = this.model.lists().sortBy(function(list) { list.ord });
    lists.forEach(function (list) {
      var listView = new TrelloClone.Views.ListItem({model: list});
      this.attachSubview($lists, listView.render());
    }.bind(this));

    return this;
  }

});
