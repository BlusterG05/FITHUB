const deleteUserService = require('../../services/users/deleteUserService');

const deleteUserController = async (req, res) => {
    const { cedula } = req.params;
    try {
        await deleteUserService(cedula);
        res.status(200).json({ message: 'User deleted successfully' });
    } catch (err) {
        res.status(500).json({ message: 'Error deleting user', error: err.message });
    }
};

module.exports = deleteUserController;
