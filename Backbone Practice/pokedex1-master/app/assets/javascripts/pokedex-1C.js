Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var pokemon = new Pokedex.Models.Pokemon(attrs);
  var pokedex = this;

  pokemon.save( {}, {
    success: function () {
      pokedex.pokes.add(pokemon);
      pokedex.addPokemonToList(pokemon);
      callback(pokemon);
    }
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {

  var pokedata = $(event.target).serializeJSON();
  this.createPokemon(pokedata, this.renderPokemonDetail.bind(this));
};
