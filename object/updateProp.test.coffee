SI         = require 'seamless-immutable'
updateProp = require './updateProp'
expect     = require('chai').expect;

item = {}

describe 'updateProp', ->
	beforeEach ->
		item = SI
			a: 1

	it 'raises if given object is not an immutable', ->
		fn = ->
			updateProp({a: 1}, 'a', 2)
		expect(fn).to.throw

	it 'updates an existing prop', ->
		item = updateProp(item, 'a', 2)
		expect(item.a).to.eql(2)

	it 'add a new propery', ->
		item = updateProp(item, 'b', 2)
		expect(item.b).to.eql(2)
