require 'player.rb'

describe Player do
    describe "#castle" do
        it "Castles king side when the requirements of castling is met" do
            Board.reset
            player = Player.new
            des_arr = [[3, 4], [3, 2], [2, 5]]
            piece_arr = [:P, :B, :N]
            des_arr.length.times do |i|
                choice = player.get_pieces_with_des(des_arr[i], piece_arr[i], false)[0]
                choice.move(des_arr[i])
            end
            Board.print
            expect(player.castle(1)).to eq(true)
        end

        it "Castles queen side when the requirements are met" do
            Board.reset
            player = Player.new
            des_arr = [[3, 3], [3, 5], [2, 2], [1, 3]]
            piece_arr = [:P, :B, :N, :Q]
            des_arr.length.times do |i|
                puts i
                choice = player.get_pieces_with_des(des_arr[i], piece_arr[i], false)[0]
                choice.move(des_arr[i])
            end
            expect(player.castle(-1)).to eq(true)
            puts "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
            Board.print
        end
    end
end