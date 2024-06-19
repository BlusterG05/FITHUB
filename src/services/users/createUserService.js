const createUserModel = require('../../models/users/createUserModel');

const createUserService = async (user) => {
    try {
        await createUserModel(user);
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = createUserService;
