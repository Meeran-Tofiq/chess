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
            if white.turn
                player = white
                other = black
            elsif black.turn
                player = black 
                other = white
            end

            des, piece_to_move, takes = get_move()
            choices = player.get_pieces_with_des(des, piece_to_move)

            until choices.length > 0
                puts "You have no pieces that can move to the specified location. Please try again: "
                des, piece_to_move, takes = get_move()
                choices = player.get_pieces_with_des(des, piece_to_move)
            end

            choice = get_player_choice(choices)

            if choice.move(des) == des
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

        until (PIECE_LETTERS.include?(input[0]) || input.length == 2) && BOARD_LETTERS.include?(input[-2]) && NUMBERS.include?(input[-1].to_i)
            puts "Invalid input. Try again: "
            input = gets.chomp
        end

        if input.length > 2
            piece_to_move = input[0].to_sym
        else
            piece_to_move = :P
        end

        takes = true if input[1] == "x"

        input = input.slice(-2..-1)

        des = [NUMBERS.index(input[1].to_i), BOARD_LETTERS.index(input[0])]

        [des, piece_to_move, takes]
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
                input = gets.chomp
            end

            choices[input]
        end
    end
end

replay = true

while replay
    game = Game.new
    replay = game.play
end