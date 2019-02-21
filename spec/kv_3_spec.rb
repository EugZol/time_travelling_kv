require 'kv_3'

describe KV3 do
  let(:kv) { KV3.new }

  it 'returns nil for unset key' do
    expect(kv.get(:a)).to eq nil
  end

  it 'returns the set key' do
    kv.set(:a, 1)
    kv.set(:b, 2)

    expect(kv.get(:a)).to eq 1
  end

  it 'returns the last set key if key is set multiple times' do
    kv.set(:a, 1)
    kv.set(:a, 2)
    kv.set(:a, -1)

    expect(kv.get(:a)).to eq -1
  end

  it 'returns the last set key if timestamp is in the future' do
    kv.set(:a, 1)
    kv.set(:a, 2)
    kv.set(:a, -1)

    expect(kv.get(:a, Time.now.to_i + 10000)).to eq -1
  end

  it 'returns key which is closest to timestamp (in the past)' do
    t = Time.now.to_i

    kv.set(:a, 1, t)
    kv.set(:a, 2, t + 2)
    kv.set(:a, 3, t + 4)

    expect(kv.get(:a, t)).to eq 1
    expect(kv.get(:a, t + 1)).to eq 1
    expect(kv.get(:a, t + 3)).to eq 2
  end
end
