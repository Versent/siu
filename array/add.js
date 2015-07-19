// var log            = require('loglevel');
var _              = require('lodash');
var isImmutable    = require('../utils/isImmutable');
var wrapAsArray    = require('../utils/wrapAsArray');
var asImm          = require('../utils/asImm');
var addCIds        = require('./addCIds');

/*
Add new records to a collection
Records are expected to not have an id
*/
module.exports = function add(currentRecords, recordOrRecords) {
	// log.debug('add', currentRecords, recordOrRecords);

	if (!isImmutable(currentRecords)) throw new Error('currentRecords must be immutable');

	var records = wrapAsArray(recordOrRecords);
	var ids = _.pluck(records, 'id');
	if (_.any(ids)) throw new Error('Records must not have ids', ids);

	records = asImm(records);
	records = addCIds(records);

	return currentRecords.concat(records);
}
