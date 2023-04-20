class Piece
    attr_reader :pos, :symbol, :t
    def initialize(pos, transformations = nil, symbol = "♙")
        @pos = pos
        @t = transformations
        @symbol = symbol
    end

    def move(des)
        t.each do |t|
            new_pos = [pos[0] + t[0], pos[1] + t[1]]
            new_pos == des ? (return (pos = new_pos)) : next
        end
        false
    end
end

class Pawn < Piece
    T = [[0, 1], [1, 1], [-1, 1]].freeze
    def initialize(pos)
        super(pos, transformations=T)
    end
end

