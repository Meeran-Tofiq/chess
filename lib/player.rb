class Player
    attr_reader :side
    def initialize(side = "w", turn = true)
        @side = (side == "w" ? side : "b")
        @pieces = create_pieces
        @turn = turn
    end

    def create_pieces
        first_line, second_line = (side == "w" ? [7, 6] : [0, 1])

        h = Hash.new(6)

        h[:P] = create_piece_type(Pawn, second_line, [0,1,2,3,4,5,6,7])
        h[:Q] = create_piece_type(Pawn, first_line, [3])
        h[:K] = create_piece_type(Pawn, first_line, [4])
        h[:R] = create_piece_type(Pawn, first_line, [0, 7])
        h[:N] = create_piece_type(Pawn, first_line, [1, 6])
        h[:B] = create_piece_type(Pawn, first_line, [2, 5])
    end

    def create_piece_type(p_class, row, col)
        arr = []

        col.length.times do |i|
            piece = p_class.new([row, col[i]], side)
            arr << piece
        end

        arr
    end
            
end