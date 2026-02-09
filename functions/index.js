const { onRequest } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const fetch = (...args) =>
  import("node-fetch").then(({ default: fetch }) => fetch(...args));

exports.chat = onRequest(
  {
    region: "us-central1",
    secrets: ["GEMINI_API_KEY"],
  },
  async (req, res) => {
    try {
      // CORS
      res.set("Access-Control-Allow-Origin", "*");
      res.set("Access-Control-Allow-Headers", "Content-Type");
      res.set("Access-Control-Allow-Methods", "POST, OPTIONS");

      if (req.method === "OPTIONS") {
        return res.status(204).send("");
      }

      const { message, mode } = req.body || {};

      if (!message) {
        return res.status(400).json({ error: "Message is required" });
      }

      let prompt = message;

      if (mode === "explain") {
        prompt = `Explain clearly:\n${message}`;
      } else if (mode === "edit") {
        prompt = `Rewrite professionally:\n${message}`;
      } else if (mode === "translate") {
        prompt = `Translate accurately:\n${message}`;
      }

      const response = await fetch(
        `https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent?key=${process.env.GEMINI_API_KEY}`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            contents: [
              {
                parts: [{ text: prompt }],
              },
            ],
          }),
        }
      );

      const data = await response.json();

      const reply =
  data?.candidates?.[0]?.content?.parts
    ?.map(p => p.text)
    ?.join("") || "";

      if (!reply) {
        logger.error("Invalid Gemini response", data);
        return res.status(500).json({
          error: "Invalid Gemini response",
          raw: data,
        });
      }

      res.json({ reply });
    } catch (err) {
      logger.error(err);
      res.status(500).json({ error: "Something went wrong" });
    }
  }
);
