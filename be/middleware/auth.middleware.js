const jwt = require("jsonwebtoken");

const verifyToken = (req, res, next) => {
  try {
    const token = req.headers.authorization.split(" ")[1];
    const decodedToken = jwt.verify(token, process.env.JWT_SECRET);

    req.user = { id: decodedToken.id };
    next();
  } catch (err) {
    res.status(401).json({ message: "Authentication failed" });
    console.error(err);
  }
};

module.exports = verifyToken;
