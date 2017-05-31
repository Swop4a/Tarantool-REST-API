#!usr/bin/tarantool

box.cfg{
  listen = 3301,
  logger = '/home/swop4a/Tarantool-REST-API/log/tarantool.log'
}

box.schema.user.passwd('admin', 'root')

box.once('client_space', function()
  sp = box.schema.space.create('client')
  sp:create_index('primary', {
    type = 'tree',
    parts = {
      1, 'unsigned',
      2, 'str',
      3, 'str',
      4, 'unsigned'
    }
  })
end)


require 'webapp'
