SI           = require 'seamless-immutable'
addCids      = require './addCIds'
expect       = require('chai').expect;

items = []

describe 'addCids', ->
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
			addCids([])
		expect(fn).to.throw

	it 'adds ids to items without it', ->
		item =
			label: 'Bill'
		items = SI([item])
		items = addCids(items)

		expect(items[0]).to.have.property('id')
		expect(items[0].id).to.match(/cid-/)

	it 'doesnt add to items with it', ->
		item =
			id:    123
			label: 'Bill'
		items = SI([item])
		items = addCids(items)

		expect(items[0].id).to.eql(123)

