const getAllUsersModel = require('../../models/users/getAllUsersModel');

const getAllUsersService = async () => {
    try {
        const users = await getAllUsersModel();
        return users;
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = getAllUsersService;
