const WS = require("jest-websocket-mock").default;
const Server = require("mock-socket").Server;

test("jest-websocket-mock", () => {
  const ws = new WS("ws://localhost:1234");
  expect(ws.server).toBeInstanceOf(Server);
});
