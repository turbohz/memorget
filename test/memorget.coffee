assert  =require 'assert'
memorget=require '../lib/main.js'
sinon   =require 'sinon'

class ValueProvider

	constructor:()->
		@counters={}

	get:(k)=>
		@counters[k]=0 unless @counters[k]? 
		++@counters[k]	

describe 'ValueProvider',->

	provider=new ValueProvider()

	it 'should return the number of times the function 
		has been called for a given k', ->
			
			assert.equal 1,provider.get('foo')
			assert.equal 2,provider.get('foo')
			
	it 'should keep a different counter for a different k',->

			assert.equal 1,provider.get('bar')
			assert.equal 2,provider.get('bar')

	it 'must not forget the counter once you query another k',->		

			assert.equal 3,provider.get('foo')
			assert.equal 3,provider.get('bar')

describe 'Memorget', ->

	ttl  =200
	clock=null
	get  =memorget(new ValueProvider().get,null,ttl)

	before ->clock=sinon.useFakeTimers()
	after  ->clock.restore()

	it 'should cache values younger than ttl',->
		
		assert.equal 1,get('foo')
		assert.equal 1,get('foo')
		clock.tick ttl-1
		assert.equal 1,get('foo')

	it 'should recompute values older than ttl',->
		
		assert.equal 1,get('bar')
		clock.tick ttl+1
		assert.equal 2,get('bar')