require 'pry-byebug'

class Piece
    attr_reader :symbol
    attr_accessor :t, :pos
    def initialize(pos, transformations = nil, symbol)
        @pos = pos
        @t = transformations
        @symbol = symbol
    end

    def move(des)
        return false if Board.taken?(des)
        t.each do |t|
            new_pos = [pos[0] + t[0], pos[1] + t[1]]

            if new_pos == des
                Board.set_position(new_pos, symbol)
                Board.set_empty(pos)
                return (pos = new_pos)
            end
        end
        false
    end

end

class Pawn < Piece
    @@t = [[0, 1], [1, 1], [-1, 1]]
    
    attr_reader :pos, :symbol
    def initialize(pos, side)
        @symbol = (side == "w" ?  "♙" : "♟︎")
        super(pos, @@t[0..0], symbol)
        Board.set_position(pos, symbol)
    end
end

class Bishop < Piece
    @@t = [[1, 1], [-1, 1], [-1, -1], [1, -1]]
    @@t[0..4].each do |t|
        p = t
        7.times { p = [p[0] + t[0], p[1] + t[1]]; @@t << p}
    end
    
    attr_reader :pos, :symbol
    def initialize(pos, side)
        @symbol = (side == "w" ?  "♗" : "♝")
        super(pos, @@t, symbol)
        Board.set_position(pos, symbol)
    end

    def self.t
        @@t
    end
end

class Knight < Piece
    @@t = [[1, 2], [2, 1], [-1, 2], [2, -1], [-1, -2], [-2, -1], [1, -2], [-2, 1]]
    
    attr_reader :pos, :symbol
    def initialize(pos, side)
        @symbol = (side == "w" ?  "♘" : "♞")
        super(pos, @@t, symbol)
        Board.set_position(pos, symbol)
    end
end

class Rook < Piece
    @@t = [[0, 1], [1, 0], [0, -1], [-1, 0]]
    @@t[0..4].each do |t|
        p = t
        7.times { p = [p[0] + t[0], p[1] + t[1]]; @@t << p}
    end

    attr_reader :pos, :symbol
    def initialize(pos, side)
        @symbol = (side == "w" ?  "♖" : "♜")
        super(pos, @@t, symbol)
        Board.set_position(pos, symbol)
    end

    def self.t
        @@t
    end
end

class Queen < Piece
    @@t = Rook.t + Bishop.t

    attr_reader :pos, :symbol
    def initialize(pos, side)
        @symbol = (side == "w" ?  "♕" : "♛")
        super(pos, @@t, symbol)
        Board.set_position(pos, symbol)
    end
end

class King < Piece
    @@t = [[1, 0], [0, 1], [1, 1], [0, -1], [-1, 0], [-1, -1], [-1, 1], [1, -1]]
    
    attr_reader :pos, :symbol
    def initialize(pos, side)
        @symbol = (side == "w" ?  "♔" : "♚")
        super(pos, @@t, symbol)
        Board.set_position(pos, symbol)
    end
end