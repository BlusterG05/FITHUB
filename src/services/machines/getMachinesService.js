const getMachinesModel = require('../../models/machines/getMachinesModel');

const getMachinesService = async (limit) => {
    try {
        const machines = await getMachinesModel(limit);
        return machines;
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = getMachinesService;
