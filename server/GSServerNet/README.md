```lua
-- ┌───┐                ┌───┐ --
-- │ ┌─┘ ┌─────┐┌─────┐ └─┐ │ --
-- │ │   │ ┌───┘│ ────┤   │ │ --
-- │ │   │ ├───┐└───┐ │   │ │ --
-- │ │   │ └── │┌───┘ │   │ │ --
-- │ └─┐ └─────┘└─────┘ ┌─┘ │ --
-- └───┘                └───┘ --
---@module  "Figura ServerNet Datapack" <gs_svnet>
---@version v1.1.0
---@see     GrandpaScout @ https://github.com/GrandpaScout
-- Allows communication between the server and a Figura user.
```

# What Is This?
This is a datapack that allows Figura avatars to communicate with the Minecraft server.

This can be used to send information to clients or to allow the server to (indirectly) control features of the avatar.

&nbsp;
# How Do I Use This?
**Start by making a datapack.**  
*It is not recommended to edit this datapack to add your own features as it will make updating much harder if it is ever
needed.*

A sample datapack is given next to this README file. Feel free to copy it and use it as a template.

The structure of your datapack should look like the following:  
&emsp;📁 `<datapack_folder>`  
&emsp;┗ 📁 `data`  
&emsp;&emsp; ┣ 📁 `<your_namespace>`  
&emsp;&emsp; ┃ ┗ 📁 `functions`  
&emsp;&emsp; ┃ &emsp; ┗ 📄 `<your_functions>.mcfunction`  
&emsp;&emsp; ┗ 📁 `svnet`  
&emsp;&emsp; &emsp; ┗ 📁 `tags`  
&emsp;&emsp; &emsp; &emsp; ┗ 📁 `functions`  
&emsp;&emsp; &emsp; &emsp; &emsp; ┣ 📄 `register.json`  
&emsp;&emsp; &emsp; &emsp; &emsp; ┣ 📄 `start.json`  
&emsp;&emsp; &emsp; &emsp; &emsp; ┗ 📄 `tick.json`


## Do Something When a New Client Connects
Create a function and add it to the start tag.  
Open `data/svnet/tags/functions/start.json` and put this in the file:
```json
{
  "values": [
    "your_namespace:your_function",
    "your_namespace:your_other_function",
    "your_namespace:yet_another_function",
    "your_namespace:etcetera"
  ]
}
```
This will add the listed functions as start functions and will run whenever a new client connects to ServerNet.  
This is a good time to send any information that clients will always need as any clients that connect to ServerNet will
have forgotten everything from their last connection.


## Add New Messages to the Registry
The first step is to add message names to the registry. This allows clients connecting through ServerNet to know what
messages your server will send to them and what messages they are allowed to send to your server.

```ps1
# Create a new message name for a message that will be sent to clients.
# Note that *receive* is for messages *received* by the client.
#
# Replace `message_name` with the name of your message!

data modify storage svnet:registry receive append value "message_name"
```
```ps1
# Create a new message name for a message that will be sent to the server.
# Note that *send* is for messages *sent* by the client.
#
# Replace `message_name` with the name of your message!

scoreboard objectives add svnet.message_name trigger "[ServerNet] Your Description Here"
data modify storage svnet:registry send append value "message_name"
```
A message name can be both received and sent. They will not conflict.

Once you have created a registry function, you will need to add it to the register tag.  
Open `data/svnet/tags/functions/register.json` and put this in the file:
```json
{
  "values": [
    "your_namespace:your_function",
    "your_namespace:your_other_function",
    "your_namespace:yet_another_function",
    "your_namespace:etcetera"
  ]
}
```
This will add the listed functions as registry functions and will run whenever ServerNet needs to build the registry.  
This is also a good time to intialize anything that your messages may need to function properly.


## Create Messages for Clients to Receive
To write a ServerNet message, use `/tellraw`.  
It is a good idea to only send ServerNet messages to clients connected to ServerNet to avoid spamming other players'
chats with blank lines.

There are two types of messages: Simple and Standard.

Both have some rules they must follow:
* A ServerNet message is *only* the content of a tellraw message that contains information about the ServerNet message.
  Any other content is not considered a ServerNet message and does not conflict with a ServerNet message.
* A ServerNet message must *never* print actual text and must *never* contain an `"extra"` tag. If it does, it is not
  considered a ServerNet message.  
  Again, other content of a tellraw that is not part of a ServerNet message does not invalidate a ServerNet message.  
  &nbsp;  
  This means that a ServerNet message must either be the only component or *not* the first component in an array of
  components.

Multiple ServerNet messages may be contained in one tellraw message as long as they follow both of of the rules listed
above.

Examples of valid ServerNet messages:
```json
// This is the only content of the tellraw message and it does not print anything, so it is fine.
{"text": "", "font": "svnet:message_name"}

// The ServerNet message is not the first component of an array and it does not print anything, so it is fine.
["Hello World!", {"text": "", "font": "svnet:message_name"}]

// This is the same thing as the above example.
{"text": "Hello World!", "extra": [{"text": "", "font": "svnet:message_name"}]}

// This is fine and will send multiple ServerNet messages at once.
["Multiple Messages!", {"text": "", "font": "svnet:message_name"}, {"text": "", "font": "svnet:other_message_name"}]
```

Examples of *invalid* ServerNet messages:
```json
// This will cause the ServerNet message to print actual text, which is not allowed.
{"text": "Hi!", "font": "svnet:message_name"}

// The ServerNet message is the first component in an array of components, which is not allowed.
[{"text": "", "font": "svnet:message_name"}, "Hello"]

// Even though this will not print actual text, it still contains an `"extra"` tag, which is not allowed.
{"text": "", "font": "svnet:message_name", "extra": [""]}
```


### Simple Messages
To create a simple message, use the following [Raw JSON Text](https://minecraft.fandom.com/wiki/Raw_JSON_text_format) as
a base.
```json
{"text": "", "font": "svnet:message_name/param1/param2/paramN"}
```
`"text"` *must* be empty. `"font"` is the message name and the parameters to send through the message.

The parameters will send different types of values depending on what they contain.  
* If a parameter can be turned into a Lua number, a number will be sent.
* If a parameter is either `true` or `false`, a boolean will be sent.
* If a parameter is either `nil`, `null`, or completely empty, a `nil` will be sent.
* If a parameter starts with `.`, the dot will be removed and the parameter will always be sent as a string.
#### An example of a simple message:
```json
{
  "text": "",
  "font": "svnet:my_message/abc//123/./.3/-5.2/.."
}
```
This will send `"abc"`, `nil`, `123`, `""`, `"3"`, `-5.2`, and `"."` over the `my_message` message.  
&nbsp;


### Standard Messages
To create a standard message, use the following [Raw JSON Text](https://minecraft.fandom.com/wiki/Raw_JSON_text_format)
as a base.
```json
{"translate": "", "font": "svnet:message_name", "with": [param1, param2, paramN]}
```
`"translate"` *must* be empty. `"text"` and `"fallback"` must not exist.  
`"font"` is the message name. `"with"` is optional and contains the parameters to send through the message.

Any other text-like tags such as `"nbt"`, `"selector"`, or `"score"` *never* reach the client, instead being converted
into a `"text"` tag (and sometimes an `"extra"` tag, which a few parameters use) before being sent to clients. If a
parameter mentions a `"text"` tag, these tags also create a `"text"` tag and count for those parameters.

The parameters are a bit more complex with this method.


> ### String Parameters
> These are just a string. They follow the same rules that the parameters in simple messages do:
> * If the parameter can be turned into a Lua number, a number will be sent.
> * If the parameter is either `true` or `false`, a boolean will be sent.
> * If the parameter is either `nil`, `null`, or completely empty, `nil` will be sent.
> * If the parameter starts with `.`, the dot will be removed and the parameter will always be sent as a string.
>
> Some examples of string parameters and what they return:
> ```json
> "foobar" -> "foobar"
> "13.7"   -> 13.7
> "null"   -> nil
> ".33"    -> "33"
> ```
#### An example using some string parameters:
```json
{
  "translate": "",
  "font": "svnet:my_message",
  "with": ["hello", "world", "12.3", "", ".5"]
}
```
This will send `"hello"`, `"world"`, `12.3`, `nil`, and `"5"` over the `my_message` message.
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > ***
&nbsp;


> ### Standard Parameters
> These are similar to string parameters but are complete objects instead.  
> Before these parameters are read, they are first converted to plain text, translating any `"translate"` or `"keybind"`
> tags if found. The plain text then follows the same rules as string parameters.
> * If the parameter can be turned into a Lua number, a number will be sent.
> * If the parameter is either `true` or `false`, a boolean will be sent.
> * If the parameter is either `nil`, `null`, or completely empty, `nil` will be sent.
> * If the parameter starts with `.`, the dot will be removed and the parameter will always be sent as a string.
>
> Some examples of standard parameters and what they return:
> ```json
> {"text": "foobar"}   ·   ·   ·   ·   ·   ·   ·   -> "foobar"
> {"translate": "invalid.key", "fallback": "13.7"} -> 13.7
> {"text": ""} ·   ·   ·   ·   ·   ·   ·   ·   ·   -> nil
> {"keybind": "key.inventory"} ·   ·   ·   ·   ·   -> "E"
> ```
#### An example using some standard parameters:
```json
{
  "translate": "",
  "font": "svnet:my_message",
  "with": [
    {"text": "foo"},
    {"keybind": "key.jump"},
    {"text": "7"}
  ]
}
```
This will send `"foo"`, `"Space"`, and `7` over the `my_message` message.
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > ***
&nbsp;


> ### Advanced Parameters
> These allow the most control over what is sent to clients. The type of the parameter is controlled by the `"font"`
> tag.  
> Before these parameters are read, they are first converted to plain text, translating any `"translate"` or `"keybind"`
> tags if found.
>
> * ### `svnet:nil`
>   Simply sends a `nil` value, no matter the text of the parameter.
>   ```json
>   {"font": "svnet:nil", "text": ""}    ·   ·   ·   -> nil
>   {"font": "svnet:nil", "text": "not nil i swear"} -> nil
>   ```
>   &nbsp;
> * ### `svnet:boolean`
>   Sends a boolean value depending on the text of the parameter.  
>   If the text contained in the parameter is empty, `false`, `nil`, `null`, or can be converted into the number `0`,
>   `false` will be sent.  
>   `true` is sent for everything else.
>   ```json
>   {"font": "svnet:boolean", "text": "true"}  -> true
>   {"font": "svnet:boolean", "text": "1.3"}   -> true
>   {"font": "svnet:boolean", "text": "Words"} -> true
>   {"font": "svnet:boolean", "text": "false"} -> false
>   {"font": "svnet:boolean", "text": "0"} ·   -> false
>   {"font": "svnet:boolean", "text": ""}  ·   -> false
>   ```
>   &nbsp;
> * ### `svnet:number`
>   Sends a number value depending on the text of the parameter.  
>   If the text in the parameter cannot be converted into a number, `NaN` is sent instead.  
>   The two exceptions are `true` and `false` which become `1` and `0` respectively.
>   ```json
>   {"font": "svnet:number", "text": "123"}    -> 123
>   {"font": "svnet:number", "text": "-4.6"}   -> -4.6
>   {"font": "svnet:number", "text": ".2"} ·   -> 0.2
>   {"font": "svnet:number", "text": "0xAF"}   -> 175
>   {"font": "svnet:number", "text": "-1.5e7"} -> -15000000
>   {"font": "svnet:number", "text": "true"}   -> 1
>   {"font": "svnet:number", "text": "false"}  -> 0
>   {"font": "svnet:number", "text": "foo"}    -> NaN
>   {"font": "svnet:number", "text": "three"}  -> NaN
>   ```
>   &nbsp;
> * ### `svnet:string`
>   Sends a string value containing the literal text of the parameter.
>   ```json
>   {"font": "svnet:string", "text": "Foobar"} -> "Foobar"
>   {"font": "svnet:string", "text": "123"}    -> "123"
>   {"font": "svnet:string", "text": "false"}  -> "false"
>   {"font": "svnet:string", "text": ""}   ·   -> ""
>   ```
>   &nbsp;
> * ### `svnet:array`
>   Sends an array value containing the values of the parameters stored in it.  
>   This parameter uses the `"extra"` tag to create an array. Each of the values in the `"extra"` tag is another
>   parameter and follows all of the rules of string, standard, and advanced parameters.  
>   If this parameter contains text, it is treated as a string parameter and placed at the beginning of the array.  
>   &nbsp;  
>   *(Due to how long these values can get, any containing `"text": ""` have it removed. It is still there, just
>   hidden.)*
>   ```json
>   {"font": "svnet:array", "extra": ["hello", "world"]} ·   ·   ·   ·   ·   ·   ·   ·   -> {"hello", "world"}
>   {"font": "svnet:array", "extra": ["12.3", "", "x"]}  ·   ·   ·   ·   ·   ·   ·   ·   -> {12.3, nil, "x"}
>   {"font": "svnet:array", "extra": [{"text": "true", "font": "svnet:boolean"}, "str"]} -> {true, "str"}
>   {"font": "svnet:array", "text": "just", "extra": ["some", "string"]} ·   ·   ·   ·   -> {"just", "some", "string"}
>   ```
>   &nbsp;
> * ### `svnet:keyvalue`
>   Sends a table value containing the keys and values of the parameters stored in it.  
>   This parameter uses the `"extra"` tag to create a table. Each of the values in the `"extra"` tag is another
>   parameter and follows all of the rules of string, standard, and advanced parameters.  
>   The parameters are split into pairs of two, the first of a pair becomes the key and the second becomes the value.  
>   If this parameter contains text, it is completely ignored. Only the `"extra"` tag matters.  
>   &nbsp;  
>   *(Due to how long these values can get, the `"text": ""` has been removed from all of them. It is still there, just
>   hidden.)*
>   ```json
>   {"font": "svnet:keyvalue", "extra": ["hello", "world"]} ·   ·   ·   ·   ·   ·   ·   -> {["hello"] = "world"}
>   {"font": "svnet:keyvalue", "extra": ["12.3", "x", "foo", "bar"]}    ·   ·   ·   ·   -> {[12.3] = "x", ["foo"] = "bar"}
>   {"font": "svnet:keyvalue", "extra": [{"text": "", "font": "svnet:nil"}, "a_value"]} -> {}
>   {"font": "svnet:keyvalue", "extra": ["x", {"text": "12", "font": "svnet:number"}]}  -> {["x"] = 12}
>   ```
>   &nbsp;
> * ### `svnet:vector`
>   Sends a vector or array of vectors containing the values of the parameters stored in it.  
>   This parameter uses the `"extra"` tag to create an array. Each of the values in the `"extra"` tag is another
>   parameter and follows all of the rules of string, standard, and advanced parameters.  
>   If this parameter contains text, it is treated as a string parameter and placed at the beginning of the array.  
>   &nbsp;  
>   The only difference between this and `svnet:array` is how the client handles the values. All values are expected to
>   be numbers and the array must either be 2, 3, or 4 values long to successfully become a vector.  
>   If the array is 6 values long, an array of two `Vector3`s is returned to represent a bounding box.  
>   If the array is 0 values long, a `nil` value is returned. If the array is 1 value long, that value is returned.  
>   If a different number of values is given, the vector is converted into a `svnet:array` of `svnet:number`s.  
>   &nbsp;  
>   *(Due to how long these values can get, any containing `"text": ""` have it removed. It is still there, just
>   hidden.)*
>   ```json
>   {"font": "svnet:vector", "extra": ["1", "3.3", "-1.3"]}   ·   ·   ·   ·   ·   ·   -> vec(1, 3.3, -1.3)
>   {"font": "svnet:vector", "extra": ["12.3", "", "x"]}  ·   ·   ·   ·   ·   ·   ·   -> vec(12.3, NaN, NaN)
>   {"font": "svnet:vector", "text": "12", "extra": ["34", "56", "78"]}   ·   ·   ·   -> vec(12, 34, 56, 78)
>   {"font": "svnet:vector", "extra": [{"text": ".2", "font": "svnet:number"}, "55"]} -> vec(0.2, 55)
>   {"font": "svnet:vector", "extra": ["1", "2", "3", "q", "5"]}  ·   ·   ·   ·   ·   -> {1, 2, 3, NaN, 5}
>   ```
>   &nbsp;
> * ### `svnet:selector`
>   This is a unique parameter that makes use of the `"selector"` tag to send entities over a message.  
>   Using this parameter type with custom built JSON text is undefined behavior and is not supported.  
>   If multiple entities are found, an array of the found entities is sent, otherwise the only entity found is sent by
>   itself. If no entities are found, a `nil` is sent.  
>   If an entity sent by this parameter is not in the client's render distance, it is instead send as a string UUID for
>   the client to use to get the entity later.
>   ```json
>   {"font": "svnet:selector", "selector": "@e[type=creeper]"}        -> {Creeper, Creeper, Creeper, ...}
>   {"font": "svnet:selector", "selector": "@e[type=zombie,limit=1]"} -> Zombie
>   {"font": "svnet:selector", "selector": "@r"}                      -> Player
>   {"font": "svnet:selector", "selector": "@e[type=doesnt_exist]"}   -> nil
>   ```
#### An example using some advanced parameters:
```json
{
  "translate": "",
  "font": "svnet:my_message",
  "with": [
    {"text": "yes", "font": "svnet:boolean"},
    {"text": "4", "font": "svnet:number"},
    {"text": "", "font": "svnet:array", "extra": ["foo", "bar", {"text": "42", "font": "svnet:number"}]}
  ]
}
```
This will send `true`, `4`, and `{"foo", "bar", 42}` over the `my_message` message.


## Get Messages Sent By Clients
To receive a ServerNet message, keep track of the `svnet.message_name` scores for changes.

A simple system for keeping track of a `svnet` score is given below:
```ps1
# First, check for players that changed the value.
execute as @a[scores={svnet.message_name=1..}] run <command>

# Once the command is done being executed, reset the score and re-enable the message.
scoreboard players set @a svnet.message_name 0
scoreboard players enable @a svnet.message_name
```
This is not the only way to detect a ServerNet message, this is only an example.

To disable a ServerNet message from being sent to the server, use `reset` on it until you wish to allow it to be sent
again
```ps1
# Disable the message
scoreboard players reset @a svnet.message_name

# Re-enable the message
scoreboard players enable @a svnet.message_name
```
If a client attempts to send a message that is disabled, it will not throw an error. The client will simply return an
error message that the `:onError()` event will handle.

A good time to watch for changes is during the ServerNet tick. This happens right after a ServerNet heartbeat which
means that the score `svnet_connected` will be `1` on players currently connected to ServerNet.

To add functions to the ServerNet tick tag, open `data/svnet/tags/functions/tick.json` and put this in the file:
```json
{
  "values": [
    "your_namespace:your_function",
    "your_namespace:your_other_function",
    "your_namespace:yet_another_function",
    "your_namespace:etcetera"
  ]
}
```
This will add the listed functions as tick functions and will run a ServerNet tick starts.

&nbsp;
# Quick Recaps
## How To: Add Messages to the Registry [↩](#add-new-messages-to-the-registry "Go to main section")
`data/<your_namespace>/functions/your_function.mcfunction`
```ps1
# Server-to-client message
data modify storage svnet:registry receive append value "message_name"

# Client-to-server message
scoreboard objectives add svnet.message_name trigger "[ServerNet] Your Description Here"
data modify storage svnet:registry send append value "message_name"
```
&nbsp;  
`data/svnet/tags/functions/register.json`
```ps1
{
  "values": [
    "<your_namespace>:your_function.mcfunction"
  ]
}
```
&nbsp;


## How To: Run a Function When a New Client Connects [↩](#do-something-when-a-new-client-connects "Go to main section")
`data/<your_namespace>/functions/your_function.mcfunction`
```ps1
# @s is the new client.
<commands>
```
&nbsp;  
`data/svnet/tags/functions/start.json`
```ps1
{
  "values": [
    "<your_namespace>:your_function.mcfunction"
  ]
}
```
&nbsp;

## How To: Send a Message to Clients [↩](#create-messages-for-clients-to-receive "Go to main section")
### Simple Message [↩](#simple-messages "Go to main section")
```json
# Send an empty chat message containing a simple ServerNet message.
tellraw TARGET {"text": "", "font": "svnet:message_name/param1/param2/paramN"}

# Send a chat message with text content containing a simple ServerNet message.
tellraw TARGET ["Some Text", {"text": "", "font": "svnet:message_name/param1/param2/paramN"}, ...]
```

### Standard Message [↩](#standard-messages "Go to main section")
```json
# Send an empty chat message containing a standard ServerNet message.
tellraw TARGET {"translate": "", "font": "svnet:message_name", "with": [param1, param2, paramN]}

# Send a chat message with text content containing a standard ServerNet message.
tellraw TARGET ["Some Text", {"translate": "", "font": "svnet:message_name", "with": [param1, param2, paramN]}, ...]
```
&nbsp;


## How To: Receive a Message from Clients [↩](#get-messages-sent-by-clients "Go to main section")
`data/<your_namespace>/functions/your_function.mcfunction`
```ps1
execute as @a[scores={svnet.message_name=1..}] run <command>
scoreboard players set @a svnet.message_name 0
scoreboard players enable @a svnet.message_name
```
&nbsp;  
`data/svnet/tags/functions/tick.json`
```ps1
{
  "values": [
    "<your_namespace>:your_function.mcfunction"
  ]
}
```
&nbsp;


## How To: Know if a Player is Connected to ServerNet [↩](#get-messages-sent-by-clients "Go to main section")
Their `svnet_connected` score will be `1`.
