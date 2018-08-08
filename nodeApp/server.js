const http = require('http')
const port = 8080



const requestHandler = (request, response) => {
  var os = require( 'os' );
  var result = 'Hello Node.js Server 2!'
  console.log(request.url)
  if(request.url=="/isActive")
  {
     result="true";
  }
  response.end(result)


}

const server = http.createServer(requestHandler);

server.listen(port, (err) => {
  if (err) {
    return console.log('something bad happened', err)
  }

  console.log(`server is listening on ${port}`)
})