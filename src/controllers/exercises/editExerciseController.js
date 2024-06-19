const editExerciseService = require('../../services/exercises/editExerciseService');

const editExerciseController = async (req, res) => {
    const exercise = req.body;
    try {
        await editExerciseService(exercise);
        res.status(200).json({ message: 'Exercise updated successfully' });
    } catch (err) {
        res.status(500).json({ message: 'Error updating exercise', error: err.message });
    }
};

module.exports = editExerciseController;
