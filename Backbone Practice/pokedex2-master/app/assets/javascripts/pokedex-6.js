Pokedex.Router = Backbone.Router.extend({
  routes: {
    "" : "pokemonIndex",
    "pokemon/:id" : "pokemonDetail",
    "pokemon/:pokemonId/toys/:toyId" : "toyDetail"
  },

  pokemonDetail: function (id, callback) {
    if (this._pokemonIndex) {
      var pokemon = this._pokemonIndex.collection.findWhere({id: parseInt(id)});
      this._pokemonDetail = new Pokedex.Views.PokemonDetail({model: pokemon});
      $("#pokedex .pokemon-detail").html(this._pokemonDetail.$el);
      this._pokemonDetail.refreshPokemon({}, callback);
    } else {
      var that = this;
      this.pokemonIndex(function(callback) { that.pokemonDetail(id, callback) }, callback);
    }
  },

  pokemonIndex: function (callbackPoke, callbackToy) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon({}, callbackPoke, callbackToy);
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
    this.pokemonForm();
  },

  toyDetail: function (pokemonId, toyId) {
    if (this._pokemonDetail) {
      var toy = this._pokemonDetail.model.toys().findWhere({id: parseInt(toyId)});
      this._toyDetail = new Pokedex.Views.ToyDetail({model: toy});
      $("#pokedex .toy-detail").html(this._toyDetail.$el);
      this._toyDetail.render();
    } else {
      var that = this;
      this.pokemonDetail(pokemonId, function() {that.toyDetail(pokemonId, toyId)});
    }
  },

  pokemonForm: function () {
    this._pokemonForm = new Pokedex.Views.PokemonForm({model: new Pokedex.Models.Pokemon(), collection: this._pokemonIndex.collection});
    this._pokemonForm.render();
    $("#pokedex .pokemon-form").html(this._pokemonForm.$el);
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
