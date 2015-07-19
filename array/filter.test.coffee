SI           = require 'seamless-immutable'
filter       = require './filter'
expect       = require('chai').expect;

items = []

describe 'filter', ->
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

	it 'filters', ->
		fn = (item) ->
			item.name == 'Tess'
		items = filter(items, fn)
		expect(items.length).to.eql(1)
		expect(items[0].name).to.eql('Tess')

	it 'returns an immutable collection', ->
		fn = (item) ->
			item.name == 'Tess'
		items = filter(items, fn)
		expect(SI.isImmutable(items)).to.eq(true)

