require '/home/meeran/repos/chess/lib/player.rb'
require '/home/meeran/repos/chess/lib/board.rb'
require '/home/meeran/repos/chess/lib/pieces.rb'
require 'pry-byebug'

PIECE_LETTERS = ["K", "Q", "B", "N", "R"]
BOARD_LETTERS = ["a", "b", "c", "d", "e", "f", "g", "h"]
NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8]

class Game
    attr_accessor :white, :black, :game_end
    def initialize
        Board.reset
        @white = Player.new()
        @black = Player.new("b", false)
        @game_end = false
    end

    def play
        Board.print

        until game_end
            moved = false

            if white.turn
                player = white
                other = black
            elsif black.turn
                player = black 
                other = white
            end

            des, piece_to_move, takes, castles = get_move()
            binding.pry

            if castles != 0
                until castles == 0 || player.castle(castles)
                    des, piece_to_move, take, castles = get_move()
                end
                if castles != 0
                    moved = true
                    puts moved
                end
            else
                choices = player.get_pieces_with_des(des, piece_to_move, takes)

                until choices.length > 0
                    puts "You have no pieces that can move to the specified location. Please try again: "
                    des, piece_to_move, takes, castles = get_move()
                    choices = player.get_pieces_with_des(des, piece_to_move, takes)
                end
                choice = get_player_choice(choices)

                if takes
                    to_take = Board.get_piece_at(des)
                    if choice.take(des)
                        other.remove_piece(to_take)
                        moved = true
                    end
                end

                if choice.move(des)
                    moved = true
                end
            end

            if moved 
                player.turn = false
                other.turn = true
            end

            Board.print
        end
    end

    def get_move
        puts (white.turn ? "White to move: " : "Black to move: ")
        input = gets.chomp
        takes = false
        castles = 0

        until input_is_valid?(input)
            puts "Invalid input. Try again: "
            input = gets.chomp
        end

        if input == "O-O" || input == "O-O-O"
            if input.length == 3
                return [0, 0, 0, 1]
            else
                return [0, 0, 0, -1]
            end
        end

        if input[0].upcase == input[0]
            piece_to_move = input[0].to_sym
        else
            piece_to_move = :P
        end

        takes = true if input[-3] == "x"

        input = input.slice(-2..-1)

        des = [NUMBERS.index(input[1].to_i), BOARD_LETTERS.index(input[0])]

        [des, piece_to_move, takes, castles]
    end

    def get_player_choice(choices)
        if choices.length == 1
            choices[0]
        else
            puts "Which of these pieces do you want to move to the aloocated location: "

            choices.each_with_index do |piece, i|
                puts "#{i+1}- #{piece.pos}"
            end

            input = gets.chomp.to_i

            until input < choices.length && input > 0
                puts "Invalic input. Try again: "
                input = gets.chomp.to_i
            end

            choices[input - 1]
        end
    end

    def input_is_valid?(input)
        return ((PIECE_LETTERS.include?(input[0]) || input.length == 2 || 
            (input.length == 3 && input[0] == "x")) && 
            BOARD_LETTERS.include?(input[-2]) && 
            NUMBERS.include?(input[-1].to_i) || 
            input == "O-O" || input == "O-O-O")
    end
end

replay = true

while replay
    game = Game.new
    replay = game.play
end