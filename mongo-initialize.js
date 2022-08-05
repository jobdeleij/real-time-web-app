db = db.getSiblingDB('admin');

db.auth('admin', 'Apo5TXKGL1cryp5HWKo5');

db = db.getSiblingDB('real-time-web-app');

db.createUser({
    user: 'main-user',
    pwd: '4ep6IgR3vwyBz2PQJlh8',
    roles: [
      {
        role: 'dbOwner',
        db: 'real-time-web-app',
      },
    ],
  });

db.createCollection("weather", {
    timeseries: {
        timeField: "ts",
        metaField: "source",
        granularity: "minutes"
    }
}); 

db.weather.insertMany([
  {
    "_id" : ObjectId("60c0d44894c10494260da31e"),
    "sensorId": 123,
    "windSpeed" : 20,
    "temp" : 20,
    "ts" : ISODate("2021-05-20T10:24:51.303Z")
 },
 {
  "_id" : ObjectId("61c0d44894c10494260da31f"),
  "sensorId": 123,
  "windSpeed" : 22,
  "temp" : 21,
  "ts" : ISODate("2021-05-20T10:25:51.303Z")
},
{
  "_id" : ObjectId("64c0d44894c10494260da31b"),
  "sensorId": 123,
  "windSpeed" : 18,
  "temp" : 22,
  "ts" : ISODate("2021-05-20T10:27:51.303Z")
}
]);