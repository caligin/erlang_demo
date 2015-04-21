erlang_demo
=
Just a demmo app I used to show a couple of features during an introductory talk.

Usage
==
`make run`, then open browser on `http://localhost:8080` .
A websocket connection is estabilished to the server and the browser starts receiving messages.

To demonstrate hot code reloading, change which line is commented in the function `websocket_handler:message/1`, save the file, then from the eshell spawned with `make run` execute `c("src/websocket_handler.erl").` . This will recompile the module and load the new version, you should see a different type of messages being received by the browser without losing the websocket connection.

To demonstrate supervisors, first change `websocket_handler:message/1` to the implementation that calls `sensor_access:ask_state/1` (see above), then type `exit(whereis(sensor_access), kill).` on the shell. This will simulate a failure in the external service, the behaviour shown is that the supervision tree will spawn it anew with a fresh state (should see the count reset in the messages received on the client).