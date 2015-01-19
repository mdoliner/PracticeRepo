Pokedex.RootView.prototype.reassignToy = function () {
  var $select = $(event.target);

  var oldPoke = this.pokes.findWhere({id: $select.data("pokemon_id")});
  var toy = oldPoke.toys().findWhere({id: $select.data("toy_id")});
  toy.set({pokemon_id: $select.val()});
  var pokedex = this;
  toy.save({},{
    success: function(){
      oldPoke.toys().remove(toy);
      pokedex.renderToysList(oldPoke.toys());
      pokedex.$toyDetail.empty();
    }
  });
}

Pokedex.RootView.prototype.renderToysList = function(toys) {
  this.$pokeDetail.find(".toys").empty();
  var pokedex = this;
  toys.each(function(toy) {
    pokedex.addToyToList(toy);
  })
};
