const getExerciseByIdService = require('../../services/exercises/getExerciseByIdService');

const getExerciseByIdController = async (req, res) => {
    const { id } = req.params;
    try {
        const exercise = await getExerciseByIdService(id);
        res.status(200).json(exercise);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching exercise', error: err.message });
    }
};

module.exports = getExerciseByIdController;
