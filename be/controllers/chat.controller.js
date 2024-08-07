const Chat = require("../models/chat");
const openaiService = require("../services/openai.service");

const startChat = async (req, res) => {
  try {
    const userId = req.user.id;
    console.log("ini user id", userId);
    const chatSession = new Chat({ userId });
    await chatSession.save();
    res.status(201).json({ sessionId: chatSession._id });
  } catch (err) {
    console.log(err);
    res
      .status(500)
      .json({ message: "Error starting chat", error: err.message });
  }
};

const sendMessage = async (req, res) => {
  try {
    const { sessionId, message } = req.body;
    const chatSession = await Chat.findById(sessionId);
    if (!chatSession) {
      return res.status(404).json({ message: "Chat session not found" });
    }
    chatSession.messages.push({ content: message, sender: "user" });

    try {
      const botResponse = await openaiService.getBotResponse(
        message,
        chatSession.messages
      );
      chatSession.messages.push({ content: botResponse, sender: "bot" });
      await chatSession.save();
      res.json({ botResponse });
    } catch (apiError) {
      if (apiError.status === 429) {
        res.status(429).json({
          message:
            "Quota exceeded. Please check your plan and billing details.",
        });
      } else {
        res.status(500).json({
          message: "Error getting bot response",
          error: apiError.message,
        });
      }
    }
  } catch (err) {
    console.log(err);
    res.status(500).json({ message: "Internal Server Error" });
  }
};

const getChatHistory = async (req, res) => {
  try {
    const userId = req.user.id;
    const chatSessions = await Chat.find({ userId }).sort("-updatedAt");
    console.log("ini history", userId);
    res.json(chatSessions);
  } catch (err) {
    console.log(err);
    res
      .status(500)
      .json({ message: "Error getting chat history", error: err.message });
  }
};

module.exports = { startChat, sendMessage, getChatHistory };
