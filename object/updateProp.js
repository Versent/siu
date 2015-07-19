var isImmutable = require('../utils/isImmutable')

module.exports = function updateProp(object, prop, value) {
	if (!isImmutable(object)) throw new Error('object must be immutable');
	if (!prop) throw new Error('expected prop');
	if (value == null) throw new Error('expected value'); // 0 or "" are ok

	var merge = {
		[prop]: value
	}
	return object.without(prop).merge(merge);
}
