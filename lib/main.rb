require '/home/meeran/repos/chess/lib/player.rb'
require '/home/meeran/repos/chess/lib/board.rb'
require '/home/meeran/repos/chess/lib/pieces.rb'
require 'pry-byebug'

PIECE_LETTERS = ["K", "Q", "B", "N", "R"]
BOARD_LETTERS = ["a", "b", "c", "d", "e", "f", "g", "h"]
NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8]
GAME_CHOICES = ["draw", "resign", "save"]

def deep_copy(o)
    Marshal.load(Marshal.dump(o))
end



class Game
    attr_accessor :white, :black, :game_end
    def initialize
        Board.reset
        @white = Player.new()
        @black = Player.new("b", false)
        @game_end = false
    end

    def play
        load_game if user_load_game?
        until game_end
            moved = false
            
            if white.turn
                player = white
                other = black
            elsif black.turn
                player = black 
                other = white
            end
            
            Board.print

            player.remove_ghosts

            player.in_check = other.can_pieces_check(player.king)

            des, piece_to_move, takes, castles = get_move(player.in_check)

            if GAME_CHOICES.include?(des)
                game_end = true
                if des == GAME_CHOICES[0]
                    if offer_draw(player)
                        puts "It's a draw."
                        return replay?
                    else
                        puts "Opponent declines the draw"
                        des, piece_to_move, takes, castles = get_move(player.in_check)
                    end
                elsif des == GAME_CHOICES[1]
                    puts "#{player} has resgined, #{other} wins."
                    return replay?
                else
                    save_game
                    des, piece_to_move, takes, castles = get_move(player.in_check)
                end
            end


            if castles != 0
                until castles == 0 || player.castle(castles)
                    des, piece_to_move, take, castles = get_move(player.in_check)
                end
                if castles != 0
                    moved = true
                    puts moved
                end
            else
                layout = deep_copy(Board.layout)
                player_pieces = deep_copy(player.pieces)
                other_pieces = deep_copy(other.pieces)
                
                loop do
                    choices = player.get_pieces_with_des(des, piece_to_move, takes)
                    
                    until choices.length > 0
                        puts "You have no pieces that can move to the specified location. Please try again: "
                        des, piece_to_move, takes, castles = get_move(player.in_check)
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
                    
                    still_in_check = other.can_pieces_check(player.king)
                    
                    if still_in_check
                        player.pieces = player_pieces.clone
                        other.pieces = other_pieces.clone
                        Board.layout = layout.clone
                        puts "You are under check, you must move to stop being under check"
                        des, piece_to_move, take, castles = get_move(player.in_check)
                    else
                        break
                    end

                    break unless player.in_check
                end
            end

            if moved 
                player.turn = false
                other.turn = true
            end
        end
    end

    def get_move(in_check)
        str = (in_check ? "You are in check! " : "")
        puts "#{str}#{(white.turn ? "White to move: " : "Black to move: ")}"
        input = gets.chomp
        takes = false
        castles = 0

        until input_is_valid?(input)
            puts "Invalid input. Try again: "
            input = gets.chomp
        end

        return input if GAME_CHOICES.include?(input)

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

            until input <= choices.length && input > 0
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
            input == "O-O" || input == "O-O-O" ||
            GAME_CHOICES.include?(input))
    end

    def offer_draw(player)
        puts "#{player} has offered a draw, do you accept or decline? (y/n)"
        input = gets.chomp

        until input == "n" || input == "y"
            puts "Invalid input. Try again: "
            input = gets.chomp
        end

        input == "y"
    end

    def save_game
        unless Dir.exists? "saves"
            Dir.mkdir "saves"
        end

        puts "what do you want to name the save file? "
        input = gets.chomp
        input = (input.length > 0 ? input : Time.now.strftime("%d_%m_%Y %H_%M"))

        save = File.open("saves/".concat(input), "w+") 
        save.write(Marshal.dump(self))
    end

    def user_load_game?
        puts "Do you want to load a game? (y/n)"
        input = gets.chomp

        until input == "n" || input == "y"
            puts "Invalid input. Try again: "
            input = gets.chomp
        end

        input == "y"
    end

    def load_game
        unless Dir.exists? "saves"
            puts "There are no saves folder."
            return false
        end

        saves = Dir.children("saves")
        
        puts "Which of these files do you want to open: "

        saves.each_with_index do |file, i|
            puts "#{i+1}- #{file}"
        end

        input = gets.chomp.to_i

        until input <= saves.length && input > 0
            puts "Invalic input. Try again: "
            input = gets.chomp.to_i
        end

        save = File.open("saves/".concat(saves[input-1]), "r")
        marshal_load File.binread(save)
    end

    def replay?
        puts "Do you want to play again? (y/n)"
        input = gets.chomp

        until input == "n" || input == "y"
            puts "Invalid input. Try again: "
            input = gets.chomp
        end

        input == "y"
    end
end

replay = true

while replay
    game = Game.new
    replay = game.play
end