const deleteMachineService = require('../../services/machines/deleteMachineService');

const deleteMachineController = async (req, res) => {
    const { id } = req.params;
    try {
        await deleteMachineService(id);
        res.status(200).json({ message: 'Machine deleted successfully' });
    } catch (err) {
        res.status(500).json({ message: 'Error deleting machine', error: err.message });
    }
};

module.exports = deleteMachineController;
