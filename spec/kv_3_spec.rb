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

  it 'returns key by timetsamp' do
    t1 = kv.set(:a, 1)
    sleep(0.001)
    kv.set(:a, 2)

    expect(kv.get(:a, t1)).to eq 1
  end

  it 'returns the last set key if key is set multiple times' do
    kv.set(:a, 1)
    sleep(0.001)
    kv.set(:a, 2)
    sleep(0.001)
    kv.set(:a, -1)

    expect(kv.get(:a)).to eq -1
  end

  it 'returns the last set key if timestamp is in the future' do
    kv.set(:a, 1)
    sleep(0.001)
    kv.set(:a, 2)
    sleep(0.001)
    t3 = kv.set(:a, -1)

    expect(kv.get(:a, t3 + 10000)).to eq -1
  end

  it 'returns key which is closest to timestamp (in the past)' do
    t1 = kv.set(:a, 1)
    sleep(0.001)
    t2 = kv.set(:a, 2)

    middle_t = ((t1 + t2)/2.0).round
    expect(kv.get(:a, middle_t)).to eq 1
  end
end
