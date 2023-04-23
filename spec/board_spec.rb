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
            Pawn.new([3, 3], "w")
            expect(Board.layout[3][3]).to eq("♙")
        end
    end

    describe ".taken?" do
        it "returns true when the position is taken" do
            Pawn.new([0, 0], "b")
            expect(Board.taken?([0, 0])).to eq(true)
        end

        it "returns true when the position is taken" do
            expect(Board.taken?([0, 6])).to eq(false)
        end
    end

    describe ".set_empty" do
        it "returns a layout that has the specified position as nil" do
            p = Pawn.new([3, 3], "w")
            Board.set_empty([3, 3])
            expect(Board.layout[3][3]).to eq(nil)
        end
    end

    describe ".print" do
        it "prints the correct version of the board" do
            Board.reset_board
            q = Queen.new([0, 1], "w")
            k = King.new([2, 7], "b")

            expect(Board.print).to eq([[nil, "♕", nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, "♚"],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil]])
        end
    end
end