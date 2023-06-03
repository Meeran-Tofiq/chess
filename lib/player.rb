class Player
    attr_reader :side, :pieces
    def initialize(side = "w", turn = true)
        @side = (side == "w" ? side : "b")
        @pieces = create_pieces
        @turn = turn
    end

    def create_pieces
        first_line, second_line = (side == "w" ? [0, 1] : [7, 6])

        h = Hash.new(6)

        h[:P] = create_piece_type(Pawn, second_line, [0,1,2,3,4,5,6,7])
        h[:Q] = create_piece_type(Queen, first_line, [3])
        h[:K] = create_piece_type(King, first_line, [4])
        h[:R] = create_piece_type(Rook, first_line, [0, 7])
        h[:N] = create_piece_type(Knight, first_line, [1, 6])
        h[:B] = create_piece_type(Bishop, first_line, [2, 5])

        h
    end

    def create_piece_type(p_class, row, col)
        arr = []

        col.length.times do |i|
            piece = p_class.new([row, col[i]], side)
            arr << piece
        end

        arr
    end

    def get_pieces_with_des(des, type)
        arr = []

        pieces[type].each do |piece|
            if piece.can_move_to?(des)
                arr << piece
            end
        end
        
        arr
    end
            
end