# Ruby Bookmark Server

Servidor Ruby con WEBrick para guardar y listar marcadores.

```powershell
ruby server.rb
curl -X POST http://localhost:9292/bookmarks -H "Content-Type: application/json" -d '{"title":"Ruby","url":"https://ruby-lang.org"}'
```
