class Board
    @@layout = Array.new(8) {Array.new(8, nil)}

    def self.taken?(pos)
        !@@layout[pos[0]][pos[1]].nil?
    end

    def self.set_position(pos, symbol)
        @@layout[pos[0]][pos[1]] = symbol
    end

    def self.layout
        @@layout
    end
end