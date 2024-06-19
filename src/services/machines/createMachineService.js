const createMachineModel = require('../../models/machines/createMachineModel');

const createMachineService = async (machine) => {
    try {
        await createMachineModel(machine);
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = createMachineService;
