var isImmutable    = require('../utils/isImmutable');
var addCId         = require('../object/addCId');

module.exports = function addCIds(records) {
	if (!isImmutable(records)) throw new Error('addCids: records must be immutable');
	return records.map(addCId);
};
