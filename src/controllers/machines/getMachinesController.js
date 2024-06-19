const getMachinesService = require('../../services/machines/getMachinesService');

const getMachinesController = async (req, res) => {
    const { limit } = req.query;
    try {
        const machines = await getMachinesService(limit);
        res.status(200).json(machines);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching machines', error: err.message });
    }
};

module.exports = getMachinesController;
