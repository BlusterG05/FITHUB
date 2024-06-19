const getUserModel = require('../../models/users/getUserModel');

const getUserService = async (cedula) => {
    try {
        const user = await getUserModel(cedula);
        return user;
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = getUserService;
