const getUsersService = require('../../services/users/getUsersService');

const getUsersController = async (req, res) => {
    const { limit } = req.query;
    try {
        const users = await getUsersService(limit);
        res.status(200).json(users);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching users', error: err.message });
    }
};

module.exports = getUsersController;
