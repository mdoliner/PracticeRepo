Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $li = $("<li></li>");
  $li.html("Name: " + pokemon.escape("name") + "<br>" +
  "Poketype: " + pokemon.escape("poke_type"));
  $li.addClass("poke-list-item");
  $li.data("id", pokemon.id);
  this.$pokeList.append($li);
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  var rootView = this;
  this.pokes.fetch({
    success: function () {
      rootView.pokes.each(rootView.addPokemonToList.bind(rootView));
    }
  });
};
