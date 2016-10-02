#!/usr/bin/env node

var oracledb = require('oracledb');

oracledb.getConnection(
  {
    user          : "hr",
    password      : "hr",
    connectString : "localhost/XE"
  },
  function(err, connection)
  {
    if (err) {
      console.error(err.message);
      return;
    }
    connection.execute(
      "SELECT * FROM jobs",
      function(err, result)
      {
        if (err) {
          console.error(err.message);
          return;
        }
        console.log(result.rows);
      });
  });
