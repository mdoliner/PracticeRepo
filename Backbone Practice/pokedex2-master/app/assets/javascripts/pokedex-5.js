Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li" : "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
  },

  addPokemonToList: function (pokemon) {
    var template = JST['pokemonListItem']({pokemon: pokemon});
    this.$el.append(template);
    return this;

  },

  refreshPokemon: function (options, callbackPoke, callbackToy) {
    var that = this;
    this.collection.fetch({
      success: function () {
        that.render();
        callbackPoke && callbackPoke(callbackToy);
      }
    });
  },

  render: function () {
    this.$el.empty();
    var that = this;
    this.collection.each(function (poke){
      that.addPokemonToList(poke);
    })
  },

  selectPokemonFromList: function (event) {
    var $pokeLi = $(event.target);
    Backbone.history.navigate('/pokemon/' + $pokeLi.data("id"), {trigger: true});
  }

});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li" : "selectToyFromList"
  },

  refreshPokemon: function (options, callback) {
    var that = this;
    this.model.fetch({
      success: (function() {
        that.render();
        callback && callback();
      }).bind(this)
    });
  },

  render: function () {
    var content = JST['pokemonDetail']({pokemon: this.model});
    this.$el.html(content);

    this.model.toys().each((function(toy) {
      var toyListItem = JST["toyListItem"]({toy: toy});
      this.$el.find(".toys").append(toyListItem);
    }).bind(this));

    return this;
  },

  selectToyFromList: function (event) {
    var $toyLi = $(event.target);
    Backbone.history.navigate('pokemon/' + $toyLi.data("pokemon-id") + "/toys/" + $toyLi.data("id"), {trigger: true});
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    var content = JST["toyDetail"]({pokemon: [], toy: this.model});
    this.$el.html(content);
    return this;
  }
});



// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
