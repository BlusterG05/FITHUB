const express = require('express');
const createExerciseController = require('../controllers/exercises/createExerciseController');
const deleteExerciseController = require('../controllers/exercises/deleteExerciseController');
const editExerciseController = require('../controllers/exercises/editExerciseController');
const getExerciseByIdController = require('../controllers/exercises/getExerciseByIdController');
const getExercisesController = require('../controllers/exercises/getExercisesController');
const getAllExercisesController = require('../controllers/exercises/getAllExercisesController');
const router = express.Router();

router.post('/create', createExerciseController);
router.delete('/delete/:id', deleteExerciseController);
router.put('/edit', editExerciseController);
router.get('/get/:id', getExerciseByIdController);
router.get('/get', getExercisesController);
router.get('/getAll', getAllExercisesController);

module.exports = router;
