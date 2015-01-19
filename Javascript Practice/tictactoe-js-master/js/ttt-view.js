(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
  };

  View.prototype.bindEvents = function () {
  };

  View.prototype.makeMove = function ($cell) {
    var row = $cell.data("row");
    var col = $cell.data("col");
    try {
      this.game.playMove([row, col]);
      if (this.game.currentPlayer === "x") {
        $cell.addClass("x-played");
      } else {
        $cell.addClass("o-played");
      }
    } catch (e){
      if (e instanceof TTT.MoveError) {
        alert("Not a valid move!");
      } else {
        throw e;
      }
    }

    if (this.game.winner() !== null) {
      alert("Nice Job!");
    }

  };

  View.prototype.setupBoard = function () {
    for (var i = 0; i < 3; i++) {
      var $row = $("<ul></ul>");
      $row.addClass("row");
       for (var j = 0; j < 3; j++) {
         var $cell = $("<li></li>");
         $cell.addClass("cell");
         $cell.data("row", i);
         $cell.data("col", j);
         $row.append($cell);
       }
      this.$el.append($row);
    }
  };

})();
