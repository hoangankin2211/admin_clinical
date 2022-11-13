const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth_routes');
const PORT = process.env.PORT || 5000;
const app = express();
var server = require('http').createServer(app);
const io = require('socket.io')(server);

const DB = "mongodb+srv://nguyenminhhung:20112002@cluster0.thz1i4g.mongodb.net/?retryWrites=true&w=majority";


app.use(express.json());
app.use(authRouter);

io.on("connection", (socket) => {
    console.log(`New Client connected`);
    console.log(socket.id, "has joined");
    socket.on("/test", (msg) => {
        console.log(msg);
    });
    socket.on('fromClient', data => {
            console.log(data);
            socket.emit('fromServer', `${Number(data)+1}`)
        })
        // socket.emit("fromServer", "connected");
});
mongoose.connect(DB).then(() => {
        console.log("Connection Successful");
    })
    .catch((e) => {
        console.log(e);
    });

server.listen(PORT, () => {
    console.log(`Connection with port: ${PORT}`);
});