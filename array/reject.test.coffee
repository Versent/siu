SI           = require 'seamless-immutable'
reject       = require './reject'
expect       = require('chai').expect;

items = []

describe 'reject', ->
	beforeEach ->
		item1 =
			id:   1
			name: 'Sara'
		item2 =
			id:   2
			name: 'Tess'
		items = SI([item1, item2])

	it 'raises if given object is not an immutable', ->
		fn = ->
			filter([], [])
		expect(fn).to.throw

	it 'rejects', ->
		fn = (item) ->
			item.name == 'Tess'
		items = reject(items, fn)
		expect(items.length).to.eql(1)
		expect(items[0].name).to.eql('Sara')

	it 'returns an immutable collection', ->
		fn = (item) ->
			item.name == 'Tess'
		items = reject(items, fn)
		expect(SI.isImmutable(items)).to.eq(true)

