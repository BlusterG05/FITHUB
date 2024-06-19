const getAllMachinesModel = require('../../models/machines/getAllMachinesModel');

const getAllMachinesService = async () => {
    try {
        const machines = await getAllMachinesModel();
        return machines;
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = getAllMachinesService;
