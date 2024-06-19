const editMachineService = require('../../services/machines/editMachineService');

const editMachineController = async (req, res) => {
    const machine = req.body;
    try {
        await editMachineService(machine);
        res.status(200).json({ message: 'Machine updated successfully' });
    } catch (err) {
        res.status(500).json({ message: 'Error updating machine', error: err.message });
    }
};

module.exports = editMachineController;
