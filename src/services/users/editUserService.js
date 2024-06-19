const editUserModel = require('../../models/users/editUserModel');

const editUserService = async (user) => {
    try {
        await editUserModel(user);
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = editUserService;
