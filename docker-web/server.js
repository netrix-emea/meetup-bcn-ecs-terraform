'use strict';

const express = require('express');
var AWS = require("aws-sdk");

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';
const TABLENAME = 'DemoTable'


AWS.config.update({
	  region: "us-east-1",
});


var docClient = new AWS.DynamoDB.DocumentClient();


// Eventuel Consistent increase of the counter value for the keys
var updateAndIncreaseCounter = function(ClientIP,ServerIP,callback) {
    var params = {
            TableName: TABLENAME,
            Key: {
                ClientIP : ClientIP,
                ServerIP : ServerIP
            },
            UpdateExpression: "ADD #counter :incva",
            ExpressionAttributeNames:{
                "#counter":"counter"
            },
            ExpressionAttributeValues:{
                ":incva":1
            },
            ReturnValues:"UPDATED_NEW"
        };

    docClient.update(params,callback);
}

// App
const app = express();
app.get('/', (req, res) => {

 {
  res.writeHead(200, {
    'Content-Type': 'text/html',
    'Expires': new Date().toUTCString()
  });

  updateAndIncreaseCounter(req.connection.remoteAddress,req.socket.localAddress, function(err, data) {
    if (err) console.log(err);
    else console.log(data);
  });




	// Return content of Dynamo DB Table and create HTML page
  var params = {
      TableName : TABLENAME,
  };
  docClient.scan(params, function(err, data) {
      if (err) {
          console.error("Unable to query. Error:", JSON.stringify(err, null, 2));
      } else {
          var highlight = ''
          res.write( '<!DOCTYPE html><html><head><link rel="stylesheet" href="https://unpkg.com/purecss@1.0.0/build/pure-min.css" integrity="sha384-nn4HPE8lTHyVtfCBi5yW9d20FjT8BJwUXyWZT9InLYax14RDjBj46LmSztkmNP9w" crossorigin="anonymous"></head><body><h1>Visitors</h1>')
          res.write('<table class="pure-table pure-table-bordered"><thead><tr><th>Server IP<th>Client IP<th> Visits</tr></thead><tbody>')
          console.log(data.Items)
          data.Items.forEach(function(item) {
              if(req.connection.remoteAddress == item.ClientIP && req.socket.localAddress == item.ServerIP)
              {
                highlight = 'class="pure-table-odd"'
              }
              else {
                highlight = ''
              }
              res.write(('<TR ' +highlight+'><TD >'+ item.ServerIP + "</td><td>" + item.ClientIP+ "</td><td>" +item.counter +"</TD></TR>"))
          });
          res.write("</tbody></table>")
          res.end('</body></html>')
      }
  });
}


});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
