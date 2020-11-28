/*db.auth('mongo', 'mongo')

db = db.getSiblingDB('test-database')

db.createUser({
  user: 'test-user',
  pwd: 'test-password',
  roles: [
    {
      role: 'root',
      db: 'test-database',
    },
  ],
});
*/


db.createUser({
  user: 'mongo',
  pwd: 'mongo',
  roles: [
    {
      role: 'readWrite',
      db: 'dbtest'
    }
  ]
})


/*db.createUser(
        {
            user: "usertest",
            pwd: "pwdtest",
            roles: [
                {
                    role: "readWrite",
                    db: "dbtest"
                }
            ]
        }
);
*/

/*
db.auth('mongo', 'mongo')

db = db.getSiblingDB('mongo')

db.createUser({
  user: 'mongo',
  pwd: 'mongo',
  roles: [
    {
      role: 'root',
      db: 'mongo',
    },
  ],
});*/
