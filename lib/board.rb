class Board
    def initialize
        @@layout = Array.new(8) {Array.new(8, nil)}
    end

    def taken?(pos)
        !@@layout[pos[0]][pos[1]].nil?
    end
end