const jwt = require('jsonwebtoken');

const authenticateUser = (req, res, next) => {
    const authHeader = req.header('Authorization');

    if (!authHeader) {
        return res.status(401).send('Access Denied: No Token Provided');
    }

    const token = authHeader.replace('Bearer ', '');

    if (!token) {
        return res.status(401).send('Access Denied: No Token Provided');
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded; // Almacenar la información del usuario en la solicitud
        next(); // Continuar con la siguiente función de middleware o la ruta
    } catch (err) {
        res.status(400).send('Invalid Token');
    }
};

module.exports = authenticateUser;