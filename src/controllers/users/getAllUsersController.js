const getAllUsersService = require('../../services/users/getAllUsersService');

const getAllUsersController = async (req, res) => {
    try {
        const users = await getAllUsersService();
        res.status(200).json(users);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching users', error: err.message });
    }
};

module.exports = getAllUsersController;
