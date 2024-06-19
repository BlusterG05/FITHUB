const editUserService = require('../../services/users/editUserService');

const editUserController = async (req, res) => {
    const user = req.body;
    try {
        await editUserService(user);
        res.status(200).json({ message: 'User updated successfully' });
    } catch (err) {
        res.status(500).json({ message: 'Error updating user', error: err.message });
    }
};

module.exports = editUserController;
