# Utilities for Seamless Immutable

## Install

```
npm install siu --save-dev
```

## Dependencies

```
npm install lodash --save-dev
npm install node-uuid --save-dev
npm install seamless-immutable --save-dev
```

## API

### Arrays

#### a.addCIds

Add a client generated id

```
items = siu.a.addCIds(items, 'cid');
```

#### a.merge

Merges two arrays

- Existing records are replaced in place
- New records added to the end

```
var newItems = siu.a.merge(items, moreItems, 'id');
```


