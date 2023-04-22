require 'pieces.rb'

describe Pawn do
    describe "#move" do
        it "moves the pawn when passed a correct space for movement" do
            pawn = Pawn.new([0, 1], "w")
            expect(pawn.move([0, 2])).to eq([0, 2])
        end

        it "returns false when the new destination given isn't available" do
            pawn = Pawn.new([7, 1], "w")
            expect(pawn.move([0, 2])).to eq(false)
        end

        it "returns false when you try to move a pawn diagonally without taking" do
            pawn = Pawn.new([5, 1], "w")
            expect(pawn.move([6,2])).to eq(false)
        end
    end
end

describe Bishop do
    describe "#move" do
        it "returns the position that it moves the q" do
            bishop = Bishop.new([0, 0], "w")
            expect(bishop.move([1,1])).to eq([1, 1])
        end
        
        it "returns the new position of the bishop after a very big move" do
            bishop = Bishop.new([0, 0], "w")
            expect(bishop.move([7,7])).to eq([7, 7])
        end
        
        it "returns false when trying to move it NOT along a diagonal" do
            bishop = Bishop.new([0,0], "w")
            expect(bishop.move([1, 5])).to eq(false)
        end
    end
end

describe Knight do
    describe "#move" do
        it "returns the position of the destination" do
            knight = Knight.new([0, 5], "w")
            expect(knight.move([1, 7])).to eq([1, 7])
        end

        it "returns false if the des is not possible to reach" do
            knight = Knight.new([0, 3], "w")
            expect(knight.move([0, 4])).to eq(false)
        end
    end
end

describe Rook do
    describe "#move" do
        it "returns the position of the detination, if des is possible" do
            r = Rook.new([0,0], "w")
            expect(r.move([7,0])).to eq([7, 0])
        end

        it "returns false when the des provided is ot reachable" do
            r = Rook.new([0,7], "w")
            expect(r.move([1, 1])).to eq(false)
        end

        it "returns the des, after a moving it's position there" do
            r = Rook.new([0, 0], "w")
            expect(r.move([0, 7])).to eq([0,7])
        end
    end
end

describe Queen do
    describe "#move" do
        it "returns the position that it moves the bishop" do
            q = Queen.new([0, 0], "w")
            expect(q.move([1,1])).to eq([1, 1])
        end
        
        it "returns the new position of the bishop after a very big move" do
            q = Queen.new([0, 0], "w")
            expect(q.move([7,7])).to eq([7, 7])
        end
        
        it "returns false when trying to move it NOT along a diagonal" do
            q = Queen.new([0,0], "w")
            expect(q.move([1, 5])).to eq(false)
        end

        it "returns the position of the detination, if des is possible" do
            q = Queen.new([0,0], "w")
            expect(q.move([7,0])).to eq([7, 0])
        end

        it "returns false when the des provided is ot reachable" do
            q = Queen.new([0,7], "w")
            expect(q.move([1, 1])).to eq(false)
        end

        it "returns the des, after a moving it's position there" do
            q = Queen.new([0, 0], "w")
            expect(q.move([0, 7])).to eq([0,7])
        end
    end
end

describe King do
    describe "#move" do
        it "returns the position the king moves to" do
            k = King.new([0,5], "w")
            expect(k.move([0,6])).to eq([0, 6])
        end
        
        it "returns false when the position provided is not somewhere the king can reach" do
            k = King.new([0, 5], "w")
            expect(k.move([0,7])).to eq(false)
        end
    end
end
        