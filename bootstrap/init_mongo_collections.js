var COLLECTIONS = ['authors', 'works', 'editions'];

COLLECTIONS.forEach(collection => {
  db.createCollection(collection);
  db.getCollection(collection).createIndex({ key: 1 }, { unique: true });
  db.getCollection(collection).createIndex({ "created.value": 1 });
  db.getCollection(collection).createIndex({ "last_modified.value": 1 });
});