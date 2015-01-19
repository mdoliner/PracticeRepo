TrelloClone.Collections.Lists = Backbone.Collection.extend({

  model: TrelloClone.Models.List,

  url: "api/lists",

  getOrFetch: function (id) {
    var list;
    if (!(list = this.get(id))) {
      list = new TrelloClone.Models.List({id: id});
      list.fetch({
        success: function () {
          this.add(list);
        }.bind(this)
      });
    }
    return list;
  }

});
