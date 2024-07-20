// utils/jwtUtils.js
const jwt = require('jsonwebtoken');

function generateJWT(user) {
  return jwt.sign(
    { id: user.admin_id, username: user.admin_username },
    process.env.JWT_SECRET,
    { expiresIn: '1h' }
  );
}

module.exports = { generateJWT };