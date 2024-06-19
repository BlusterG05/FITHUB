const createMachineService = require('../../services/machines/createMachineService');

const createMachineController = async (req, res) => {
    const machine = req.body;
    try {
        await createMachineService(machine);
        res.status(201).json({ message: 'Machine created successfully' });
    } catch (err) {
        res.status(500).json({ message: 'Error creating machine', error: err.message });
    }
};

module.exports = createMachineController;
