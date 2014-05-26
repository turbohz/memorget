
/**
	Memorget

	Memoize an expensive function by storing its results.
	After ttl time, the value will be "forgotten" (recomputed)
 */
var identity,
  __slice = [].slice;

identity = function(x) {
  return x;
};

module.exports = function(func, hasher, ttl) {
  var memoize;
  if (hasher == null) {
    hasher = identity;
  }
  if (ttl == null) {
    ttl = 0;
  }
  memoize = function() {
    var args, cache, key, now;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    cache = memoize.cache;
    key = hasher.apply(this, arguments);
    now = Date.now();
    if ((cache[key] == null) || now > cache[key].expires) {
      cache[key] = {
        value: func.apply(this, args),
        expires: now + ttl
      };
    }
    return cache[key].value;
  };
  memoize.cache = {};
  return memoize;
};
