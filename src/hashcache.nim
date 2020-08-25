import asynchttpserver, asyncdispatch, cgi, httpClient, os, redis,
       std/sha1, strformat, strtabs, strutils, times, uri

proc retrieve(q: string): string =
  var params: StringTableRef
  try:
    params = readData(q)
  except:
    return "ERROR: Invalid query parameters."

  # Don't wait longer than 500 milliseconds.
  # This is just to help prevent abuse. Please be nice.
  var client = newHttpClient(timeout = 500)

  if params.hasKey("authorization") and len(params["authorization"]) > 0:
    client.headers = newHttpHeaders({
      "Authorization": params["authorization"]
    })

  try:
    let response = client.request(
      params["url"],
      httpMethod = params.getOrDefault("method", "GET"))

    if response.code() == HttpCode(200):
      return $secureHash(response.body())
    else:
      return "ERROR: Non-200 status."
  except:
    return "ERROR: Failed to retrieve content."

proc handler(req: Request) {.async.} =
  echo $now().utc & " " & req.hostname & " " & $req.url

  if req.url.path == "/":
    await req.respond(Http200, readFile("index.html"), newHttpHeaders([
      ("Content-Type", "text/html")
    ]))
  elif req.url.path == "/hash":
    let r = await openAsync(
      getEnv("REDIS_HOST", "127.0.0.1"),
      Port(parseInt(getEnv("REDIS_PORT", "6379"))))

    # Write the flag at the beginning of every request, just in case it gets
    # destroyed somehow. Note that on the production server, the flag has a
    # different value.
    let flag = getEnv("FLAG", "not_the_real_flag")
    discard r.setk("flag", fmt"flag{{{flag}}}")

    let hashOfParams = secureHash(req.url.query)

    var output = await r.get("hash:" & $hashOfParams)
    if output == redisNil:
      output = retrieve(req.url.query)

      # cache the result for 5 minutes == 300 seconds
      discard r.setex("hash:" & $hashOfParams, 300, output)

    await req.respond(Http200, output, newHttpHeaders([
      ("Content-Type", "text/plain")
    ]))
  else:
    await req.respond(Http404, "404", newHttpHeaders([
      ("Content-Type", "text/plain")
    ]))

when isMainModule:
  # restart server if it throws an exception
  while true:
    try:
      waitFor newAsyncHttpServer().serve(Port(8080), handler)
    except:
      discard
