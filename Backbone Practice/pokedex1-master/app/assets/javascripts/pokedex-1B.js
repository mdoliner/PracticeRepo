Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $ul = $("<ul></ul>").addClass("detail");
  var $img = $("<img>").attr('src', pokemon.get("image_url"));
  $ul.append($img);
  _.each(pokemon.attributes, function(value, attr) {
    if (attr === "image_url"){
      return
    };
    var $li = $("<li></li>");
    $li.text(attr + ": " + value);
    $ul.append($li);
  });

  var $toys = $("<ul></ul>").addClass("toys");
  $ul.append($toys);
  this.$pokeDetail.html($ul);

  var pokedex = this;
  pokemon.fetch({
    success: function () {
      pokemon.toys().each(function (toy){
        pokedex.addToyToList(toy);
      })
    }
  })
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.target).data("id");
  var pokemon = this.pokes.findWhere({id: id});
  this.renderPokemonDetail(pokemon);
};
