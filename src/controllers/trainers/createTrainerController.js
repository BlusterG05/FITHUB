const createTrainerService = require('../../services/trainers/createTrainerService');

const createTrainerController = async (req, res) => {
    const trainer = req.body;
    try {
        await createTrainerService(trainer);
        res.status(201).json({ message: 'Trainer created successfully' });
    } catch (err) {
        res.status(500).json({ message: 'Error creating trainer', error: err.message });
    }
};

module.exports = createTrainerController;
