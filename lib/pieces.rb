require 'pry-byebug'

class Piece
    attr_reader :symbol
    attr_accessor :t, :pos 
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
        super(pos, transformations=T[0..0])
    end
end

