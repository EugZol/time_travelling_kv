# Challenge 1
#
# Implement simple key-value storage (KV class), like:
#
# kv = KV.new
# kv.set('foo', 'bar')
# kv.get('foo') # => returns "bar"

class KV1
  def initialize
    @store = {}
  end

  def set(k, v)
    @store[k] = v
  end

  def get(k)
    @store[k]
  end
end
