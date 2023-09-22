const express = require("express");
const bodyParser = require("body-parser");
const app = express();
const { port } = require("./config");

app.use(bodyParser.json());

app.post("/api/alert", (req, res) => {
  const { stream } = req.query;
  const { body } = req;
  // console.log(body);
  if (stream) {
    console.log(stream, JSON.stringify({ body, innerTimestamp: Date.now() }));
  } else {
    console.log({ body, innerTimestamp: Date.now() });
  }
  res.send({ oK: true });
});

app.listen(port, () => console.log(`App running at ${port}`));
