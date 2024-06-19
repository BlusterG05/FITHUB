const getMachineByIdModel = require('../../models/machines/getMachineByIdModel');

const getMachineByIdService = async (id) => {
    try {
        const machine = await getMachineByIdModel(id);
        return machine;
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = getMachineByIdService;
