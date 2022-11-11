import std/httpclient
import std/uri
import std/json
import std/options

proc get_weather(location: string): Option[JsonNode] =
  let wttr_uri = parseUri("https://wttr.in")
  var client = newHttpClient()
  # let format = {"format": r"Temperature at %l is %t\n"}
  let format = {"format": "j1"}

  try:
    return some(parse_json(client.getContent(wttr_uri/location ? format)))
  except HttpRequestError as e:
    echo "failed to get weather in " & location & " with the error: " & e.msg
    return none(JsonNode)

proc parse_json(data: string): JsonParser =
  return parseJson(data)

let locations = @["Frankfurt", "Bangalore", "Barcelona", "xxxsadfasdx"]
for location in locations:
  var weather_at_location = get_weather(location)
  if weather_at_location.isSome:
    let output = location & ": " & weather_at_location.get()[
        "current_condition"][0]["temp_C"].getStr()
    echo output
