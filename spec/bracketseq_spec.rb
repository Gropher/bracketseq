# frozen_string_literal: true

require './bracketseq'

RSpec.describe 'Bracketseq' do
  it 'can validate string format' do
    expect(Bracketseq.valid_symbols?('({}[[]])')).to be_truthy
    expect(Bracketseq.valid_symbols?('({qwe}[[123]])')).to be_falsey
  end

  it 'can validate brackets sequence' do
    expect(Bracketseq.valid_brackets?('({}[[]])')).to be_truthy
    expect(Bracketseq.valid_brackets?('[][[[]]]')).to be_truthy
    expect(Bracketseq.valid_brackets?('{}()[]')).to be_truthy
    expect(Bracketseq.valid_brackets?('(((()')).to be_falsey
    expect(Bracketseq.valid_brackets?('[{]}')).to be_falsey
    expect(Bracketseq.valid_brackets?('{{{}}}}')).to be_falsey
  end

  it 'can identify longest correct brackets sequence' do
    expect(Bracketseq.longest_sequence('({}[[]])')).to eq('({}[[]])')
    expect(Bracketseq.longest_sequence('{{{}}}}')).to eq('{{{}}}')
    expect(Bracketseq.longest_sequence('((}{))()[()]')).to eq('()[()]')
    expect(Bracketseq.longest_sequence('(()]{[()]}}}}')).to eq('{[()]}')
  end
end
