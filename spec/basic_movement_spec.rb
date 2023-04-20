require 'pieces.rb'

describe Pawn do
    describe "#move" do
        it "moves the pawn when passed a correct space for movement" do
            pawn = Pawn.new([0, 1])
            expect(pawn.move([0, 2])).to eq([0, 2])
        end

        it "returns false when the new destination given isn't available" do
            pawn = Pawn.new([7, 1])
            expect(pawn.move([0, 2])).to eq(false)
        end

        it "returns false when you try to move a pawn diagonally without taking" do
            pawn = Pawn.new([5, 1])
            expect(pawn.move([6,2])).to eq(false)
        end
    end
end

describe Bishop do
    describe "#move" do
        it "returns the position that it moves the bishop" do
            bishop = Bishop.new([0, 0])
            expect(bishop.move([1,1])).to eq([1, 1])
        end
    end

    describe "#move" do
        it "returns the new position of the bishop after a very big move" do
            bishop = Bishop.new([0, 0])
            expect(bishop.move([7,7])).to eq([7, 7])
        end
    end

    describe "#move" do
        it "returns false when trying to move it NOT along a diagonal" do
            bishop = Bishop.new([0,0])
            expect(bishop.move([1, 5])).to eq(false)
        end
    end
end

describe Knight do
    describe "#move" do
        it "returns the position of the destination" do
            knight = Knight.new([0, 5])
            expect(knight.move([1, 7])).to eq([1, 7])
        end
    end

    describe "#move" do
        it "returns false if the des is not possible to reach" do
            knight = Knight.new([0, 3])
            expect(knight.move([0, 4])).to eq(false)
        end
    end
end