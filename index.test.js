// Loaded from common-js format
// node_modules/jest-websocket-mock/lib/jest-websocket-mock.cjs.js
const WS = require("jest-websocket-mock").default;
// Loaded from js format
// node_modules/mock-socket/dist/mock-socket.js"
const Server = require("mock-socket").Server;

test("jest-websocket-mock", () => {
  const ws = new WS("ws://localhost:1234");
  console.log(ws.server.constructor);  // [Function: Server] { of: [Function: of] }
  console.log(Server);  // [Function: Server] { of: [Function: of] }
  expect(ws.server).toBeInstanceOf(Server);  // FAILS
});
