var _             = require('lodash');
var isImmutable   = require('../utils/isImmutable');
var updateObjProp = require('../object/updateProp');

module.exports = function updateProp(array, prop, value) {
	if (!isImmutable(array))     throw new Error('Expected array to be immutable');
	if (!_.isArray(array)) throw new Error('Expected an array');
	if (!prop)             throw new Error('Expected prop');
	if (value == null)     throw new Error('Expected value'); // 0 or "" are ok

	return array.map(function(item) {
		return updateObjProp(item, prop, value);
	});

}
