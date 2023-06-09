require_relative 'serializable.rb'
require_relative 'pieces.rb'

PIECES_SYM = {:P => Pawn, :R => Rook, :K => King, :N => Knight, :Q => Queen, :B => Bishop}

class Player
    include BasicSerializable
    attr_accessor :turn, :in_check, :pieces
    attr_reader :side, :king
    def initialize(side = "w", turn = true)
        @side = (side == "w" ? side : "b")
        @pieces = create_pieces
        @turn = turn
        @in_check = false
        @king = pieces[:K][0]
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

        if takes
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
        if piece.class == Ghost
            piece = piece.pawn
        end
        @pieces.each_value do |arr|
            arr.delete(piece)
        end
    end

    def castle(castles)
        return false if castles == 0 || in_check

        king = pieces[:K][0]
        if castles == 1
            rook = pieces[:R][1]
            puts Board.get_piece_at([king.pos[0], king.pos[1] + 1])
            if (!Board.taken?([king.pos[0], king.pos[1] + 1]) && 
                !Board.taken?([king.pos[0], king.pos[1] + 2]) &&
                rook.first_move && 
                king.first_move)
                rook.move([rook.pos[0], rook.pos[1] - 2])
                Board.set_empty(king.pos)
                king.pos = [king.pos[0], king.pos[1] + 2]
                Board.set_position(king.pos, king)
            else
                puts "You cannot castle king's side."
                return false
            end
        elsif castles == -1
            rook = pieces[:R][0]
            if (!Board.taken?([king.pos[0], king.pos[1] - 1]) && 
                !Board.taken?([king.pos[0], king.pos[1] - 2]) &&
                !Board.taken?([king.pos[0], king.pos[1] - 3]) &&
                rook.first_move && 
                king.first_move)
                rook.move([rook.pos[0], rook.pos[1] + 3])
                Board.set_empty(king.pos)
                king.pos = [king.pos[0], king.pos[1] - 2]
                Board.set_position(king.pos, king)
            else
                puts "You cannot castle queen's side."
                return false
            end
        end

        true
    end

    def can_pieces_check(other_king)
        pieces.each_value do |arr|
            arr.each do |piece|
                if piece.can_take?(other_king.pos)
                    return true
                end
            end
        end
        false
    end

    def remove_ghosts
        pieces[:P].each do |pawn|
            unless pawn.ghost == nil
                Board.set_empty(pawn.ghost.pos)
                pawn.ghost = nil
            end
        end
    end

    def to_s
        return (side == "w" ? "WHITE" : "BLACK")
    end

    def serialize
        obj = {}
        obj[:@pieces] =  pieces.map { |k,v| [k, v.map(&:serialize)] }.to_h
        instance_variables.each {|var| obj[var] = instance_variable_get(var) if obj[var] == nil || var == :@king}
        @@serializer.dump obj
    end

    def unserialize(string)
        obj = @@serializer.parse string
        @pieces = unserialize_pieces(obj["@pieces"])
        puts pieces
        king = pieces[:K][0]
        obj.each_key do |key|
            next if key == "@pieces" || key == "@king"
            instance_variable_set(key, obj[key])
        end
        load_pieces_on_board
    end

    def unserialize_pieces(hash)
        new_h = {}
        hash = hash.map { |k, v| [k.to_sym, v] }.to_h
        hash.each do |k, arr|
            new_h[k] = Array.new if new_h[k].nil?
            arr.each do |v|
                piece = PIECES_SYM[k].new(-1, side)
                piece.unserialize(v)
                new_h[k] << piece
            end
        end
        new_h
    end

    def load_pieces_on_board
        pieces.each_value { |arr| arr.each { |v| Board.set_position(v.pos, v) } }
    end
end