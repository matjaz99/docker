# callGenerator

This simulates calls. Each call has:
- A number
- B number
- nodeId
- start time
- duration
- releaseCause (answered, busy, noreply, error)

Each call is pushed to ElasticSearch:

`curl -XPOST "http://[localhost]:9200/indexname/typename/optionalUniqueId" -d '{ "field" : "value" }'`
