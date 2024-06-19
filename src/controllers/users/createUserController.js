const createUserService = require('../../services/users/createUserService');

const createUserController = async (req, res) => {
    const user = req.body;
    try {
        await createUserService(user);
        res.status(201).json({ message: 'User created successfully' });
    } catch (err) {
        res.status(500).json({ message: 'Error creating user', error: err.message });
    }
};

module.exports = createUserController;
