require 'player.rb'
require 'board.rb'

describe Player do
    describe "#can_pieces_check" do
        it "returns true if the pieces can check your opponent's king right now" do
            player = Player.new()
            enemy = Player.new("b", false)
            des_arr_white = [[3, 4], [3, 3], [4, 7]]
            piece_type_arr_white = [:P, :P, :Q]
            des_arr_black = [[4, 4], [4, 5]]
            des_arr_white.each_with_index do |des, i|
                player.get_pieces_with_des(des, piece_type_arr_white[i], false)[0].move(des)
            end
            des_arr_black.each do |des|
                enemy.get_pieces_with_des(des, :P, false)[0].move(des)
            end
            expect(player.can_pieces_check(enemy.king)).to eq(true)
        end
    end
end