var Piece = require("./piece");

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid () {
  grid = [];
  for (var i = 0; i < 8; i++) {
    grid.push([]);
  }

  for (var i = 0; i < 8; i++) {
    for (var j = 0; j < 8; j ++) {
      grid[i][j] = null;
    }
  }

  grid[3][4] = new Piece("black");
  grid[4][3] = new Piece("black");
  grid[3][3] = new Piece("white");
  grid[4][4] = new Piece("white");

  return grid;
}

/**
 * Constructs a Board with a starting grid set up.
 */
function Board () {
  this.grid = _makeGrid();
}

Board.prototype.DIRS = [
  [ 0,  1], [ 1,  1], [ 1,  0],
  [ 1, -1], [ 0, -1], [-1, -1],
  [-1,  0], [-1,  1]
];

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function (pos) {
  if (!this.isValidPos(pos)) {
    throw new Error('Not valid pos!');
  }

  return this.grid[pos[0]][pos[1]];
};

/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function (color) {
  return this.validMoves(color).length != 0;
};

/**
 * Checks if every position on the Board is occupied.
 */
Board.prototype.isFull = function () {
  for (var i=0; i < 8; i++) {
    for (var j=0; j < 8; j++) {
      if (this.grid[i][j] === null) {
        return false;
      }
    }
  }

  return true;
};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function (pos, color) {
  var piece = this.getPiece(pos);
  return (piece !== null && piece.color === color);
};

/**
 * Checks if a given position has a piece on it.
 */
Board.prototype.isOccupied = function (pos) {
  return (this.grid[pos[0]][pos[1]] === null) ? false : true;
};

/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function () {
  return (this.validMoves("black").length === 0 && this.validMoves("white").length === 0);
};

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function (pos) {
  if (pos[0] < 0 || pos[0] > 7 || pos[1] < 0 || pos[1] > 7) {
    return false;
  }

  return true;
};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns null if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns null if it hits an empty position.
 *
 * Returns null if no pieces of the opposite color are found.
 */

function _positionsToFlip (board, pos, color, dir) {
  pos = pos.addDelta(dir);
  if (!board.isValidPos(pos)) { return null; }

  var piece = board.getPiece(pos);
  if (piece === null) { return null; }
  if (piece.color === color) { return []; }

  var flips = [pos].concat(_positionsToFlip(board, pos, color, dir));
  if (flips[flips.length-1] === null) {
    return null;
  }

  return flips;
}

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function (pos, color) {
  if (!this.validMove(pos, color)) {
    throw new Error("Invalid Move");
  }
  var flips = [];
  for (var i=0; i < this.DIRS.length; i++) {
    var toFlips = _positionsToFlip(this, pos, color, this.DIRS[i]);
    if (toFlips !== null && toFlips.length > 0) {
      flips = flips.concat(toFlips);
    }

  }

  for (var i = 0; i < flips.length; i++) {
    this.getPiece(flips[i]).flip();
  }

  this.grid[pos[0]][pos[1]] = new Piece(color);
};

/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function () {
  console.log("   0   1   2   3   4   5   6   7")
  console.log("---------------------------------");
  for (var i = 0; i < 8; i++) {
    var row = "" + i + "|";
    for (var j = 0; j < 8; j++) {
      var piece = this.getPiece([i,j])
      if (piece === null) {
        row += "   |";
      }
      else if (piece.color === "black") {
        row += " ● |";
      } else if (piece.color === "white") {
        row += " ○ |";
      }
    }
    console.log(row);
    console.log("----------------------------------");
  }
};

/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function (pos, color) {
  if (this.isOccupied(pos)) { return false };

  for (var i = 0; i < this.DIRS.length; i++) {
    var flips = _positionsToFlip(this, pos, color, this.DIRS[i]);
    if (flips !== null && flips.length !== 0) {
      return true;
    }
  }


  return false;
};

Array.prototype.addDelta = function (delta) {
  return [this[0] + delta[0], this[1] + delta[1]];
}

/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */
Board.prototype.validMoves = function (color) {
  var vmoves = [];
  for (var i = 0; i < 8; i++) {
    for (var j = 0; j < 8; j++) {
      if (this.validMove([i,j], color)) {
        vmoves.push([i,j]);
      }
    }
  }

  return vmoves;
};

module.exports = Board;
