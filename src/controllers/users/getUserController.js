const getUserService = require('../../services/users/getUserService');

const getUserController = async (req, res) => {
    const { cedula } = req.params;
    try {
        const user = await getUserService(cedula);
        res.status(200).json(user);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching user', error: err.message });
    }
};

module.exports = getUserController;
