Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $toys = this.$pokeDetail.find("ul.toys");
  var $toy = $("<li></li>");
  $toy.html("Name: " +  toy.get("name") +
            "<br>Happiness: " + toy.get("happiness") +
            "<br>Price: " + toy.get("price"));
  $toy.data("toy_id", toy.id).data("pokemon_id", toy.get("pokemon_id"));
  $toys.append($toy);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var $img = $("<img>");
  $img.attr("src", toy.get("image_url")).addClass("detail");

  var $select = $("<select></select>").data("pokemon_id", toy.get("pokemon_id")).data("toy_id", toy.id).addClass("owner");

  this.pokes.each(function(poke) {
    $option = $("<option></option>");
    $option.text(poke.get("name")).val(poke.id);
    if (poke.id === toy.get("pokemon_id")) {
      $option.attr("selected", "selected");
    }
    $select.append($option);
  })

  this.$toyDetail.html($img).append($select);

};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var $toy = $(event.target);
  var pokemon = this.pokes.findWhere({id: $toy.data("pokemon_id")});
  var toy = pokemon.toys().findWhere({id: $toy.data("toy_id")});
  this.renderToyDetail(toy);
};
