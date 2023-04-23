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
            new_pos = pos
            7.times do |_|
                new_pos = [new_pos[0]+t[0], new_pos[1]+t[1]]
                
                break if Board.out_of_bounds?(new_pos) || Board.taken?(new_pos)
                
                if new_pos == des
                    Board.set_position(new_pos, symbol)
                    Board.set_empty(pos)
                    return (pos = new_pos)
                end
            end 
        end
        false
    end

end

class Pawn < Piece
    
    attr_reader :pos, :symbol
    def initialize(pos, side)
        @t = [[0, 1], [1, 1], [-1, 1]]
        @symbol = (side == "w" ?  "♙" : "♟︎")
        super(pos, @t[0..0], symbol)
        Board.set_position(pos, symbol)
    end

    def move(des)
        return false if Board.taken?(des)
        t[0..0].each do |t|
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

class Bishop < Piece
    
    attr_reader :pos, :symbol
    def initialize(pos, side)
        @t = [[1, 1], [-1, 1], [-1, -1], [1, -1]]
        @symbol = (side == "w" ?  "♗" : "♝")
        super(pos, @t, symbol)
        Board.set_position(pos, symbol)
    end

end

class Knight < Piece
    
    attr_reader :pos, :symbol, :t
    def initialize(pos, side)
        @t = [[1, 2], [2, 1], [-1, 2], [2, -1], [-1, -2], [-2, -1], [1, -2], [-2, 1]]
        @symbol = (side == "w" ?  "♘" : "♞")
        super(pos, @t, symbol)
        Board.set_position(pos, symbol)
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

class Rook < Piece
    
    attr_reader :pos, :symbol, :t
    def initialize(pos, side)
        @t = [[0, 1], [1, 0], [0, -1], [-1, 0]]
        @symbol = (side == "w" ?  "♖" : "♜")
        super(pos, @t, symbol)
        Board.set_position(pos, symbol)
    end
end

class Queen < Piece
    
    attr_reader :pos, :symbol, :t
    def initialize(pos, side)
        @t = [[0, 1], [1, 0], [0, -1], [-1, 0], [1, 1], [-1, 1], [-1, -1], [1, -1]]
        @symbol = (side == "w" ?  "♕" : "♛")
        super(pos, @t, symbol)
        Board.set_position(pos, symbol)
    end
end

class King < Piece
    
    attr_reader :pos, :symbol, :t
    def initialize(pos, side)
        @t = [[1, 0], [0, 1], [1, 1], [0, -1], [-1, 0], [-1, -1], [-1, 1], [1, -1]]
        @symbol = (side == "w" ?  "♔" : "♚")
        super(pos, @t, symbol)
        Board.set_position(pos, symbol)
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