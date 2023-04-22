require 'board.rb'

describe Board do
    describe ".layout" do
        it "returns nil when trying to access a spot on the board that isn't taken" do
            Board.reset_board
            expect(Board.layout[0][7]).to eq(nil)
        end

        it "returns nil when trying to access a spot on the board" do
            expect(Board.layout[7][0]).to eq(nil)
        end
    end

    describe ".set_position" do
        it "sets the piece at the provided position" do
            Board.set_position([0, 0], "P")
            expect(Board.layout[0][0]).to eq("P")
        end
    end

    describe ".taken?" do
        it "returns true when the position is taken" do
            Board.set_position([0, 0], "P")
            expect(Board.taken?([0, 0])).to eq(true)
        end

        it "returns true when the position is taken" do
            expect(Board.taken?([0, 6])).to eq(false)
        end
    end
end