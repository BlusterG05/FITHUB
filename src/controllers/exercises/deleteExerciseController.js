const deleteExerciseService = require('../../services/exercises/deleteExerciseService');

const deleteExerciseController = async (req, res) => {
    const { id } = req.params;
    try {
        await deleteExerciseService(id);
        res.status(200).json({ message: 'Exercise deleted successfully' });
    } catch (err) {
        res.status(500).json({ message: 'Error deleting exercise', error: err.message });
    }
};

module.exports = deleteExerciseController;
