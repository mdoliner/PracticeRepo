NewsReader.Views.FeedForm = Backbone.View.extend({

  template: JST['feeds/form'],

  events: {
    "submit": "newFeed"
  },

  newFeed: function (event) {
    event.preventDefault();

    var $target = $(event.target);
    var data = $target.serializeJSON().feed;

    var model = new NewsReader.Models.Feed();

    if (data.title === "" || data.url === "") {
      var errors = "Cannot leave fields blank!";
      this.$('.errors').empty().append(errors);
    } else {
      model.save(data, {
        success: function () {
          this.collection.add(model);
          Backbone.history.navigate('', {trigger: true});
        }.bind(this),
        error: function (model, resp) {
          var errors = "Incorrect Data!";
          this.$('.errors').empty().append(errors);
        }.bind(this)
      });
    }

  },

  render: function () {
    var content = this.template({feed: new NewsReader.Models.Feed()});
    this.$el.html(content);
    return this;
  }
});
