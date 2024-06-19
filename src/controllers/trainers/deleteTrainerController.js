const deleteTrainerService = require('../../services/trainers/deleteTrainerService');

const deleteTrainerController = async (req, res) => {
    const { cedula } = req.params;
    try {
        await deleteTrainerService(cedula);
        res.status(200).json({ message: 'Trainer deleted successfully' });
    } catch (err) {
        res.status(500).json({ message: 'Error deleting trainer', error: err.message });
    }
};

module.exports = deleteTrainerController;
