const express = require('express');
const createTrainerController = require('../controllers/trainers/createTrainerController');
const deleteTrainerController = require('../controllers/trainers/deleteTrainerController');
const editTrainerController = require('../controllers/trainers/editTrainerController');
const getTrainerController = require('../controllers/trainers/getTrainerController');
const getTrainersController = require('../controllers/trainers/getTrainersController');
const getAllTrainersController = require('../controllers/trainers/getAllTrainersController');
const router = express.Router();

router.post('/create', createTrainerController);
router.delete('/delete/:cedula', deleteTrainerController);
router.put('/edit', editTrainerController);
router.get('/get/:cedula', getTrainerController);
router.get('/get', getTrainersController);
router.get('/getAll', getAllTrainersController);

module.exports = router;
