(function () {

  var View = Hanoi.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.render();
  };

  View.prototype.render = function () {
    for (var i = 0; i < this.game.towers.length; i++) {
      var $tower = $(".tower-" + i);
      $tower.empty()
      for (var j = this.game.towers[i].length - 1; j >= 0  ; j--) {
        $disk = $("<li></li>");
        $disk.addClass("disk");
        $disk.css("width", View.width * this.game.towers[i][j]);
        $disk.css("margin-left", 150 - .5 * View.width  * this.game.towers[i][j]);
        $disk.css("bottom", 30 * j + 3 * j);
        $disk.data("num", this.game.towers[i][j]);
        $tower.append($disk);
      }
    }
  };

  View.prototype.clickTower = function ($tower) {
    if (this.startTower === undefined) {
      this.startTower = $tower.data("val");
      $disk = $tower.children(".disk").first();
      console.log($disk);
      $disk.toggleClass("selected");
      console.log($disk);
    } else {
      this.endTower = $tower.data("val");
      if (!this.game.move(this.startTower, this.endTower)) {
        alert ("Not a valid move!");
      }
      $startTower = $(".tower-" + this.startTower)
      $disk = $startTower.children().last();
      $disk.toggleClass("selected");
      this.startTower = undefined;
      this.endTower = undefined;
      this.render();

      if (this.game.isWon()) {
        alert("Congrats!");
      }
    }


  }

  View.width = 90;

})();
