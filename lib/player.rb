class Player
    attr_accessor :turn
    attr_reader :side, :pieces
    def initialize(side = "w", turn = true)
        @side = (side == "w" ? side : "b")
        @pieces = create_pieces
        @turn = turn
    end

    def create_pieces
        first_line, second_line = (side == "w" ? [0, 1] : [7, 6])

        pieces = Hash.new(6)

        pieces[:P] = create_piece_type(Pawn, second_line, [0,1,2,3,4,5,6,7])
        pieces[:Q] = create_piece_type(Queen, first_line, [3])
        pieces[:K] = create_piece_type(King, first_line, [4])
        pieces[:R] = create_piece_type(Rook, first_line, [0, 7])
        pieces[:N] = create_piece_type(Knight, first_line, [1, 6])
        pieces[:B] = create_piece_type(Bishop, first_line, [2, 5])

        pieces[:P].each { |pawn| pawn.reverse_pawn_direction } if side == "b"

        pieces
    end

    def create_piece_type(p_class, row, col)
        arr = []

        col.length.times do |i|
            piece = p_class.new([row, col[i]], side)
            arr << piece
        end

        arr
    end

    def get_pieces_with_des(des, type, takes)
        arr = []

        if takes && type == :P
            pieces[type].each do |piece|
                if piece.can_take?(des)
                    arr << piece
                end
            end
        else
            pieces[type].each do |piece|
                if piece.can_move_to?(des)
                    arr << piece
                end
            end
        end
        
        arr
    end

    def remove_piece(piece)
        @pieces.each_value do |arr|
            arr.delete(piece)
        end
    end
            
end