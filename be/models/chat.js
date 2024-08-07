const mongoose = require("mongoose");

const messageSchema = new mongoose.Schema({
  content: String,
  sender: { type: String, enum: ["user", "bot"] },
  timestamp: { type: Date, default: Date.now },
});

const chatSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: "User_ChatBot" },
  messages: [messageSchema],
  createdAt: { type: Date, default: Date.now },
  updatedAt: { type: Date, default: Date.now },
});

const Chat = mongoose.model("Chat_ChatBot", chatSchema);

module.exports = Chat;
