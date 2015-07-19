SI           = require 'seamless-immutable'
addOrReplace = require './addOrReplace'
expect       = require('chai').expect;

items = []

describe 'addOrReplace', ->
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
			addOrReplace([], [])
		expect(fn).to.throw

	it 'updates an existing item', ->
		expect(items.length).to.eql(2)

		# When we add an item that is already there
		item =
			id:    2
			label: 'Bill'
		items = addOrReplace(items, item)

		# Then it is replaced
		expect(items.length).to.eql(2)
		expect(items[1].id).to.eq(2)

	it 'adds a new item', ->
		expect(items.length).to.eql(2)

		# When we add a new item
		item =
			id:    3
			label: 'Bill'

		items = addOrReplace(items, item)

		# Then it is added
		expect(items.length).to.eql(3)
		expect(items[2].id).to.eql(3)

	it 'adds items without ids', ->
		item = {label: 'Anna'}

		# Given we add an item without an id
		items = addOrReplace(items, item)

		# Then it is added
		expect(items.length).to.eql(3)
		
		# And if we add the same item again
		items = addOrReplace(items, item)

		# Then it is also added
		expect(items.length).to.eql(4)

	it 'updates and adds', ->
		# Given there is an item to merge that already exists
		item1 =
			id:    2
			label: 'Jon'
		# And there is an item to merge which doesnt
		item2 =
			id:    3
			label: 'Bill'
		additions = SI([item1, item2])

		expect(items.length).to.eq(2)

		# When merged
		items = addOrReplace(items, additions)

		# Then only one item would be added
		expect(items.length).to.eq(3)

		# And the updated and the new items are there
		expect(items[1].id).to.eq(2)
		expect(items[2].id).to.eq(3)

	it 'adds id if not there', ->
		# Given there is an item to merge without an id
		items = SI([])
		item =
			label: 'Sally'

		# When merged
		items = addOrReplace(items, item)

		# Then the merged item has a client generated id
		expect(items[0]).to.have.property('id')
		expect(items[0].id).to.match(/cid-/)

	it 'updates an item using the cid then discards it', ->
		# Given there is an item with a cid
		item =
			id: 'cid-1'
		items = SI([item])

		# And the updated data has the server id
		# and the cid in cid
		updatedItem =
			id: 22
			cid: 'cid-1'
		updatedItems = SI([updatedItem])

		# When merged
		items = addOrReplace(items, updatedItems)

		# Then the item in the collection is replaced
		# With the updated item from the server
		# Using the cid as merge key
		expect(items.length).to.eq(1)
		expect(items[0].id).to.eq(22)
		expect(items[0].cid).to.eq(undefined)
