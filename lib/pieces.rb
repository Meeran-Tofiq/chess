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
        binding.pry
        t.each do |t|
            new_pos = [pos[0] + t[0], pos[1] + t[1]]
            new_pos == des ? (return (pos = new_pos)) : next
        end
        false
    end
end

class Pawn < Piece
    def initialize(pos)
        @@t = [[0, 1], [1, 1], [-1, 1]].freeze
        super(pos, @@t[0..0])
    end
end

class Bishop < Piece
    
    def initialize(pos)
        @@t = [[1, 1], [-1, 1], [-1, -1], [1, -1]]
        @@t[0..4].each do |t|
            p = t
            7.times { p = [p[0] + t[0], p[1] + t[1]]; @@t << p}
        end
        super(pos, @@t)
    end
end
