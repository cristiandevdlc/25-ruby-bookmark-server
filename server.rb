require 'webrick'
require 'json'

bookmarks = []
server = WEBrick::HTTPServer.new(Port: 9292, BindAddress: '127.0.0.1', AccessLog: [], Logger: WEBrick::Log.new($stderr, WEBrick::Log::WARN))
server.mount_proc('/health') { |req, res| res['Content-Type'] = 'application/json'; res.body = {status: 'ok'}.to_json }
server.mount_proc('/bookmarks') do |req, res|
  res['Content-Type'] = 'application/json'
  if req.request_method == 'GET'
    res.body = bookmarks.to_json
  elsif req.request_method == 'POST'
    data = JSON.parse(req.body); raise 'url inválida' unless data['url'].to_s.start_with?('http')
    item = {id: bookmarks.length + 1, title: data['title'].to_s.strip, url: data['url']}; bookmarks << item; res.status = 201; res.body = item.to_json
  else res.status = 405; res.body = {error: 'Método no permitido'}.to_json end
end
trap('INT') { server.shutdown }; puts 'Bookmark Server: http://localhost:9292'; server.start
