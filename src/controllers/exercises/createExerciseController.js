const createExerciseService = require('../../services/exercises/createExerciseService');

const createExerciseController = async (req, res) => {
    const exercise = req.body;
    try {
        await createExerciseService(exercise);
        res.status(201).json({ message: 'Exercise created successfully' });
    } catch (err) {
        res.status(500).json({ message: 'Error creating exercise', error: err.message });
    }
};

module.exports = createExerciseController;
