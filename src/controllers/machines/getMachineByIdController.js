const getMachineByIdService = require('../../services/machines/getMachineByIdService');

const getMachineByIdController = async (req, res) => {
    const { id } = req.params;
    try {
        const machine = await getMachineByIdService(id);
        res.status(200).json(machine);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching machine', error: err.message });
    }
};

module.exports = getMachineByIdController;
