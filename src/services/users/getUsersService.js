const getUsersModel = require('../../models/users/getUsersModel');

const getUsersService = async (limit) => {
    try {
        const users = await getUsersModel(limit);
        return users;
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = getUsersService;
