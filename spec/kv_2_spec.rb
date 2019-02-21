require 'kv_2'

describe KV2 do
  let(:kv) { KV2.new }

  it 'works like Hash' do
    kv.set(:a, 1)
    kv.set(:b, 2)
    kv.set(:a, 3)

    expect(kv.get(:a)).to eq 3
    expect(kv.get(:b)).to eq 2
  end

  it 'returns key by timestamp' do
    t1 = kv.set(:a, 1)
    sleep(0.001)
    kv.set(:a, 2)

    expect(kv.get(:a, t1)).to eq 1
  end
end
