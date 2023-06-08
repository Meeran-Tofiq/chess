require 'pry-byebug'

class Piece
    attr_reader :symbol
    attr_accessor :t, :pos, :first_move
    def initialize(pos)
        @pos = pos
        @first_move = true
        Board.set_position(pos, symbol)
    end

    def take(des)
        return false unless Board.taken?(des)
        Board.set_empty(des)
        move(des)
    end

    def move(des)
        return false if Board.taken?(des)
        if can_move_to?(des) || can_take?(des)
            Board.set_position(des, symbol)
            Board.set_empty(pos)
            @first_move = false
            puts first_move

            return (@pos = des)
        end
        false
    end

    def can_move_to?(des)
        t.each do |t|
            new_pos = pos
            7.times do |_|
                new_pos = [new_pos[0]+t[0], new_pos[1]+t[1]]
                
                break if Board.out_of_bounds?(new_pos) || Board.taken?(new_pos)
                
                if new_pos == des
                    return true
                end
            end 
        end
        false
    end

    def to_s
        return symbol
    end

end

class Pawn < Piece
    attr_accessor :t
    attr_reader :pos, :symbol
    def initialize(pos, side)
        @t = [[2, 0], [1, 0], [1, 1], [1, -1]]
        @symbol = (side == "w" ?  "♙" : "♟︎")
        super(pos)
    end

    def can_move_to?(des)
        transforms = (first_move ? t[0..1] : t[1..1])
        transforms.each do |t|
            new_pos = [pos[0] + t[0], pos[1] + t[1]]

            if new_pos == des
                return true
            end
        end
        false
    end

    def can_take?(des)
        transforms = t[2..3]
        transforms.each do |t|
            new_pos = [pos[0] + t[0], pos[1] + t[1]]

            if new_pos == des
                return true
            end
        end
        false
    end

    def reverse_pawn_direction
        @t.each do |transform|
            transform[0] = transform[0] * (-1)
        end
    end
end

class Bishop < Piece
    
    attr_reader :pos, :symbol
    def initialize(pos, side)
        @t = [[1, 1], [-1, 1], [-1, -1], [1, -1]]
        @symbol = (side == "w" ?  "♗" : "♝")
        super(pos)
    end

end

class Knight < Piece
    
    attr_reader :pos, :symbol, :t
    def initialize(pos, side)
        @t = [[1, 2], [2, 1], [-1, 2], [2, -1], [-1, -2], [-2, -1], [1, -2], [-2, 1]]
        @symbol = (side == "w" ?  "♘" : "♞")
        super(pos)
    end

    def can_move_to?(des)
        t.each do |t|
            new_pos = [pos[0] + t[0], pos[1] + t[1]]

            if new_pos == des
                return true
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
        super(pos)
    end
end

class Queen < Piece
    
    attr_reader :pos, :symbol, :t
    def initialize(pos, side)
        @t = [[0, 1], [1, 0], [0, -1], [-1, 0], [1, 1], [-1, 1], [-1, -1], [1, -1]]
        @symbol = (side == "w" ?  "♕" : "♛")
        super(pos)
    end
end

class King < Piece
    attr_accessor :first_move
    attr_reader :pos, :symbol, :t 
    def initialize(pos, side)
        @t = [[1, 0], [0, 1], [1, 1], [0, -1], [-1, 0], [-1, -1], [-1, 1], [1, -1]]
        @symbol = (side == "w" ?  "♔" : "♚")
        super(pos)
    end

    def can_move_to?(des)
        t.each do |t|
            new_pos = [pos[0] + t[0], pos[1] + t[1]]

            if new_pos == des
                return true
            end
        end
        false
    end
end