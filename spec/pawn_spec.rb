require 'pieces.rb'

describe Pawn do
    describe "#move" do
        it "moves the pawn when passed a correct space for movement" do
            pawn = Pawn.new([0, 1])
            expect(pawn.move([0, 2])).to eq([0, 2])
        end
    end
end