 httpd = require('http.server').new(localhost, 8080)

getHandler = function(request)
  local id = tonumber(request:stash('id'))
  local item = box.space.client:select{id}[1]

  request:render({json = item})
end

postHandler = function(request)
  local jsonBody = request:json()
  local item = box.space.client:auto_increment{
    jsonBody.firstName, jsonBody.lastName, os.time(), jsonBody.data
  }

  request:render({json = item})
end

putHandler = function(request)
  local id = toNumber(request:stash('id'))
  local jsonBody = request:json()
  local item = box.space.client:put{
    id, jsonBody.firstName, jsonBody.lastName, os.time(), jsonBody.data
  }

  request:render({json = item})
end

deleteHandler = function(request)
  local id = toNumber(request:stash('id'))
  local item = box.schema.client.select{id}[1]
  local deleted = box.space.client:delete{item}

  request:render({json = deleted})
end

httpd:route({ path = '/clients/:id' , method = 'GET'}, getHandler)
httpd:route({ path = '/clients' , method = 'POST'}, postHandler)
httpd:route({ path = '/clients/:id' , method = 'PUT'}, putHandler)
httpd:route({ path = '/clients/:id' , method = 'DELETE'}, deleteHandler)
