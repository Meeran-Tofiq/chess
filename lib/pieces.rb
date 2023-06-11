require 'pry-byebug'

class Piece
    attr_reader :symbol, :side
    attr_accessor :t, :pos, :first_move
    def initialize(pos, side)
        @pos = pos
        @first_move = true
        @side = side
        Board.set_position(pos, self)
    end

    def take(des)
        return false unless (Board.taken?(des) &&
                            Board.get_piece_at(des).side != @side)
        if can_take?(des)
            Board.set_empty(des)
            change_pos_to(des)
            @pos = des
            return true
        end
        false
    end

    def move(des)
        if can_move_to?(des)
            change_pos_to(des)
            @pos = des
            return true
        end
        false
    end

    def can_move_to?(des)
        return false if Board.taken?(des)
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

    def can_take?(des)
        t.each do |t|
            new_pos = pos
            7.times do |_|
                new_pos = [new_pos[0]+t[0], new_pos[1]+t[1]]
                
                if new_pos == des
                    return true
                end
                
                break if Board.out_of_bounds?(new_pos) || Board.taken?(new_pos)
            end 
        end
        false
    end

    def change_pos_to(des)
        Board.set_position(des, self)
        Board.set_empty(pos)
        @first_move = false
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
        super(pos , side)
    end

    def can_move_to?(des)
        transforms = (first_move ? t[0..1] : t[1..1])
        transforms.each do |tr|
            new_pos = [pos[0] + tr[0], pos[1] + tr[1]]

            if new_pos == des
                if tr == t[0]
                    g = Ghost.new([new_pos[0] - t[1][0], new_pos[1]], side, self)
                end
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
        super(pos , side)
    end

end

class Knight < Piece
    
    attr_reader :pos, :symbol, :t
    def initialize(pos, side)
        @t = [[1, 2], [2, 1], [-1, 2], [2, -1], [-1, -2], [-2, -1], [1, -2], [-2, 1]]
        @symbol = (side == "w" ?  "♘" : "♞")
        super(pos , side)
    end

    def can_move_to?(des)
        return false if Board.taken?(des)
        t.each do |t|
            new_pos = [pos[0] + t[0], pos[1] + t[1]]

            if new_pos == des
                return true
            end
        end
        false
    end

    def can_take?(des)
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
        super(pos , side)
    end
end

class Queen < Piece
    
    attr_reader :pos, :symbol, :t
    def initialize(pos, side)
        @t = [[0, 1], [1, 0], [0, -1], [-1, 0], [1, 1], [-1, 1], [-1, -1], [1, -1]]
        @symbol = (side == "w" ?  "♕" : "♛")
        super(pos , side)
    end
end

class King < Piece
    attr_accessor :first_move
    attr_reader :pos, :symbol, :t 
    def initialize(pos, side)
        @t = [[1, 0], [0, 1], [1, 1], [0, -1], [-1, 0], [-1, -1], [-1, 1], [1, -1]]
        @symbol = (side == "w" ?  "♔" : "♚")
        super(pos , side)
    end

    def can_move_to?(des)
        return false if Board.taken?(des)
        t.each do |t|
            new_pos = [pos[0] + t[0], pos[1] + t[1]]

            if new_pos == des
                return true
            end
        end
        false
    end

    def can_take?(des)
        t.each do |t|
            new_pos = [pos[0] + t[0], pos[1] + t[1]]

            if new_pos == des
                return true
            end
        end
        false
    end
end

class Ghost < Piece
    attr_reader :pawn, :side, :pos
    def initialize(pos, side, pawn)
        @pawn = pawn
        @symbol = "G"
        super(pos, side)
    end
end