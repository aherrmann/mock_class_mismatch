const WS = require("jest-websocket-mock").default;
const Server = require("mock-socket").Server;

test("jest-websocket-mock", () => {
  const ws = new WS("ws://localhost:1234");
  console.log(ws.server.constructor);  // [Function: Server] { of: [Function: of] }
  console.log(Server);  // [Function: Server] { of: [Function: of] }
  expect(ws.server).toBeInstanceOf(Server);  // FAILS
});
