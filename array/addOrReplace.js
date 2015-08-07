var isImmutable    = require('../utils/isImmutable');
var wrapAsArray    = require('../utils/wrapAsArray');
var asImmutable    = require('../utils/asImmutable');
var addCIds        = require('./addCIds');

/**
If a record has a cid then it is coming from the server
in this case it needs to replace a record in the store with with id set to cid
cid should be discarded after use otherwise it will trigger further 'creates'

@param  {array} records Records to process
@return {object}        Records processed into a map based on cid/id
*/
function asMap(records) {

	var map = {};

	records.forEach(function(record) {
		var key = record.cid || record.id;
		if (!key) throw new Error('record must have a cid or id');
		map[key] = {
			record: record.without('cid')
		}
	});

	return map;
}

function addOrReplace(array, recordOrRecords) {
	if (!isImmutable(array)) throw new Error('array must be immutable');

	var updatedRecords    = wrapAsArray(recordOrRecords);
	updatedRecords        = asImmutable(updatedRecords);
	updatedRecords        = addCIds(updatedRecords);
	var updatedRecordsMap = asMap(updatedRecords);

	// add existing
	array = array.map(function(existingRecord) {
		if (!existingRecord.id) throw new Error('Expected exiting record.id');

		var existingId = existingRecord.id;
		var isUpdated = !!updatedRecordsMap[existingId];
		if (isUpdated) {
			var entry = updatedRecordsMap[existingId];
			entry.used = true;
			return entry.record;
		} else {
			return existingRecord;
		}
	});

	// insert new ones
	var newRecords = [];
	Object.keys(updatedRecordsMap).forEach(function(key) {
		var entry = updatedRecordsMap[key];
		if (!entry.used) {
			newRecords.push(entry.record);
		}
	});

	array = array.concat(newRecords);

	return array;
}

module.exports = addOrReplace;

