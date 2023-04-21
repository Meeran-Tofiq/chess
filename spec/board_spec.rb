require 'board.rb'

describe Board do
    describe ".layout" do
        it "returns nil when trying to access a spot on the board that isn't taken" do
            expect(Board.layout[0][7]).to eq(nil)
        end

        it "returns nil when trying to access a spot on the board" do
            expect(Board.layout[7][0]).to eq(nil)
        end
    end
end