const editMachineModel = require('../../models/machines/editMachineModel');

const editMachineService = async (machine) => {
    try {
        await editMachineModel(machine);
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = editMachineService;
