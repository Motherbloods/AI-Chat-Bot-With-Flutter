const express = require("express");
const router = express.Router();
const { login, register } = require("../controllers/auth.controller");
const {
  sendMessage,
  startChat,
  getChatHistory,
} = require("../controllers/chat.controller");

const verifyToken = require("../middleware/auth.middleware");

router.post("/api/register", register);
router.post("/api/login", login);

router.post("/api/chat/start", verifyToken, startChat);
router.post("/api/chat/message", verifyToken, sendMessage);
router.get("/api/chat/history", verifyToken, getChatHistory);

module.exports = router;
