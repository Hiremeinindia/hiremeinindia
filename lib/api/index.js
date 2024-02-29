const express = require('express');
const app = express();

app.use(express.json());
app.use("/api", require("./routes/app.routes"));

app.listen(4500, function(){
    console.log("server started")
})