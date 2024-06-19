const editTrainerService = require('../../services/trainers/editTrainerService');

const editTrainerController = async (req, res) => {
    const trainer = req.body;
    try {
        await editTrainerService(trainer);
        res.status(200).json({ message: 'Trainer updated successfully' });
    } catch (err) {
        res.status(500).json({ message: 'Error updating trainer', error: err.message });
    }
};

module.exports = editTrainerController;
