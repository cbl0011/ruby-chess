require './piece.rb'

describe Piece do
    describe '#initialize' do
        it 'correctly initializes a white piece' do
            p = Piece.new(:white, [0,0])
            expect(p.color).to eq(:white)
        end
    end
end