// const OpenAI = require("openai");

// const openai = new OpenAI({
//   apiKey: process.env.OPENAI_API_KEY,
// });
// console.log("OpenAI", openai);
// exports.getBotResponse = async (message, chatHistory) => {
//   try {
//     console.log("Received message:", message);

//     const completion = await openai.chat.completions.create({
//       model: "gpt-3.5-turbo",
//       messages: [
//         ...chatHistory.map((msg) => ({
//           role: msg.sender === "user" ? "user" : "assistant",
//           content: msg.content,
//         })),
//         { role: "user", content: message },
//       ],
//     });

//     console.log("Bot response:", completion.data.choices[0].message.content);
//     return completion.data.choices[0].message.content;
//   } catch (error) {
//     console.error("Error getting bot response:", error);
//   }
// };

const axios = require("axios");

const OPENAI_API_KEY = process.env.OPENAI_API_KEY;
const OPENAI_API_URL = "https://api.openai.com/v1/chat/completions";

exports.getBotResponse = async (message, chatHistory) => {
  try {
    console.log("Received message:", message);

    const response = await axios.post(
      OPENAI_API_URL,
      {
        model: "gpt-3.5-turbo",
        messages: [
          ...chatHistory.map((msg) => ({
            role: msg.sender === "user" ? "user" : "assistant",
            content: msg.content,
          })),
          { role: "user", content: message },
        ],
      },
      {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${OPENAI_API_KEY}`,
        },
      }
    );

    const botResponse = response.data.choices[0].message.content;
    console.log("Bot response:", botResponse);
    return botResponse;
  } catch (error) {
    console.error(
      "Error getting bot response:",
      error.response ? error.response.data : error.message
    );
    throw error.response ? error.response.data : new Error(error.message);
  }
};
