const deleteMachineModel = require('../../models/machines/deleteMachineModel');

const deleteMachineService = async (id) => {
    try {
        await deleteMachineModel(id);
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = deleteMachineService;
