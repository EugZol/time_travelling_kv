# Write an in-memory, key-value value store that can "time travel." This
# can build off of Challenge #2.
#
# Support 'fuzzy' matching on a timestamp.
#
# kv = KV.new
# timestamp = kv.set('foo', 'bar')
# sleep(3)
# kv.set('foo', 'bar2')
#
# # The case of no timestamp should continue to return the latest
# # set value
# kv.get('foo') # => "bar2"
#
# # Fetch the key 'foo' with the 'now' timestamp, plus 2 seconds
# kv.get('foo', timestamp + 2) # => "bar"
# # returns the closest set value to that timestamp, but always in the past
#

class KV3
  def initialize
    @store = {}
  end

  # timestamp is dependency injection for testing
  def set(k, v, timestamp = nil)
    t = timestamp.to_i || Time.now.to_i

    # 'bundle' is a sorted array of [timestamp, value] records
    # for key == k
    @store[k] ||= []
    bundle = @store[k]

    bundle << [t, v]
  end

  def get(k, timestamp = nil)
    bundle = @store[k]

    # key is not set at all
    return nil unless bundle

    # timestamp is not set – return the last value
    return bundle.last[1] unless timestamp

    # timestamp is before the first value – return nil
    return nil if timestamp < bundle.first[0]

    # bsearch_index returns index of the next value
    v = bundle.bsearch_index { |x| x[0] > timestamp }

    # if v is nil then timestamp is ahead of last value –
    # shall return the last value
    return bundle[-1][1] unless v

    # shall return the element before v
    bundle[v - 1][1]
  end
end
