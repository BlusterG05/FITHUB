const getAllExercisesService = require('../../services/exercises/getAllExercisesService');

const getAllExercisesController = async (req, res) => {
    try {
        const exercises = await getAllExercisesService();
        res.status(200).json(exercises);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching exercises', error: err.message });
    }
};

module.exports = getAllExercisesController;
