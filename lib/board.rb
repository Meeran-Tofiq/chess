class Board
    @@layout = Array.new(8) {Array.new(8, nil)}

    def self.taken?(pos)
        !@@layout[pos[0]][pos[1]].nil?
    end

    def self.reset_board
        @@layout = Array.new(8) {Array.new(8, nil)}
    end

    def self.set_position(pos, symbol)
        @@layout[pos[0]][pos[1]] = symbol
    end

    def self.set_empty(pos)
        @@layout[pos[0]][pos[1]] = nil
    end

    def self.layout
        @@layout
    end

    def self.print
        @@layout.each do |row|
            str = ""
            puts ""
            row.each do |piece|
                if piece.nil?
                    piece = "  _  " 
                else
                    piece = "  #{piece}  "
                end
                str += piece
            end
            puts str
        end
    end

    def self.out_of_bounds?(pos)
        pos[0] > 7 || pos[1] > 7 || pos[0] < 0 || pos[1] < 0
    end
end