require 'kv_1'

describe KV1 do
  it 'works like Hash' do
    kv = KV1.new

    kv.set(:a, 1)
    kv.set(:b, 2)
    kv.set(:a, 3)

    expect(kv.get(:a)).to eq 3
    expect(kv.get(:b)).to eq 2
  end
end
