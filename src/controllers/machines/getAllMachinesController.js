const getAllMachinesService = require('../../services/machines/getAllMachinesService');

const getAllMachinesController = async (req, res) => {
    try {
        const machines = await getAllMachinesService();
        res.status(200).json(machines);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching machines', error: err.message });
    }
};

module.exports = getAllMachinesController;
