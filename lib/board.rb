class Board
    @@layout = Array.new(8) {Array.new(8, nil)}

    def self.taken?(pos)
        !@@layout[pos[0]][pos[1]].nil?
    end

    def self.reset
        @@layout = Array.new(8) {Array.new(8, nil)}
    end

    def self.set_position(pos, piece)
        @@layout[pos[0]][pos[1]] = piece
    end

    def self.set_empty(pos)
        @@layout[pos[0]][pos[1]] = nil
    end

    def self.layout
        @@layout
    end

    def self.layout(pos)
        @@layout[pos[0]][pos[1]]
    end

    def self.print
        puts "      A    B    C    D    E    F    G    H"
        puts "  ____________________________________________"
        (1..@@layout.length).reverse_each do |i|
            str = "#{i}|  "
            puts " |"
            @@layout[i-1].each do |piece|
                if piece.nil?
                    piece = "  _  " 
                else
                    piece = "  #{piece}  "
                end
                str += piece
            end
            str += "  | #{i}"
            puts str
        end
        puts "  ____________________________________________"
        puts "      A    B    C    D    E    F    G    H"
    end

    def self.out_of_bounds?(pos)
        pos[0] > 7 || pos[1] > 7 || pos[0] < 0 || pos[1] < 0
    end
end