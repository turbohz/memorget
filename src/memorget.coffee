###*
	Memorget

	Memoize an expensive function by storing its results.
	After ttl time, the value will be "forgotten" (recomputed)

###

identity=(x)->x

module.exports=(func,hasher=identity,ttl=0)->
	
	memoize=(args...)->
		cache=memoize.cache
		key  =hasher.apply @,arguments
		now  =Date.now()

		if not cache[key]? or now>cache[key].expires

			# (re)compute

			cache[key]=
				value  :func.apply @,args
				expires:now+ttl

		cache[key].value
	
	memoize.cache={}

	memoize