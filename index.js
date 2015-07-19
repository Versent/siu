module.exports = {
	isImmutable: require('./utils/isImmutable'),
	asImmutable: require('./utils/asImmutable'),
	o: {
		addCId:       require('./object/addCId'),
		updateProp:   require('./object/updateProp'),
		merge:        require('./object/merge')
	},
	a: {
		addOrReplace: require('./array/addOrReplace'),
		addCIds:      require('./array/addCIds'),
		get:          require('./array/get'),
		filter:       require('./array/filter'),
		find:         require('./array/find'),
		reject:       require('./array/reject'),
		updateProp:   require('./array/updateProp')
	}
}
