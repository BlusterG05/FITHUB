const getExercisesService = require('../../services/exercises/getExercisesService');

const getExercisesController = async (req, res) => {
    const { limit } = req.query;
    try {
        const exercises = await getExercisesService(limit);
        res.status(200).json(exercises);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching exercises', error: err.message });
    }
};

module.exports = getExercisesController;
