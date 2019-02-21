# Challenge 2
#
# Write an in-memory, key-value store that can "time travel."
# This can build off of Challenge #1
#
# If a timestamp is provided for a given key, fetch the value for
# key at that particular time. If no timestamp is supplied, fetch the
# most recently set value for that key. In Ruby, this might look like:
#
# kv = KV.new
# timestamp = kv.set('foo', 'bar')
# sleep(1)
# kv.set('foo', 'bar2')
#
# # Fetch the key 'foo' with the correct timestamp
# kv.get('foo', timestamp) # => "bar"
#
# # Fetch the key 'foo' without a timestamp
# kv.get('foo') # => returns the last set value
#

class KV2
  def initialize
    @store = {}
  end

  def set(k, v, timestamp = nil)
    t = timestamp.to_i || Time.now.to_i

    @store[k] ||= {}
    @store[k][t] = v

    t
  end

  def get(k, timestamp = nil)
    return nil unless @store[k]
    return @store[k].values.last unless timestamp

    @store[k][timestamp]
  end
end
