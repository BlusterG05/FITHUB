const deleteUserModel = require('../../models/users/deleteUserModel');

const deleteUserService = async (cedula) => {
    try {
        await deleteUserModel(cedula);
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = deleteUserService;
