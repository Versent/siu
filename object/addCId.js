var isImmutable    = require('../utils/isImmutable')
var uuid           = require('node-uuid');

module.exports = function addCId(record) {
	if (!record)              throw new Error('addCid: Expected record');
	if (!isImmutable(record)) throw new Error('addCid: record must be immutable');

	if (record.id) {
		return record;
	} else {
		var id = uuid.v1();
		var imm = isImmutable(record);
		if (imm) {
			return record.merge({id: id});
		} else {
			record.id = id;
			return record;
		}
	}

};
