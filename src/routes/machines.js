const express = require('express');
const createMachineController = require('../controllers/machines/createMachineController');
const deleteMachineController = require('../controllers/machines/deleteMachineController');
const editMachineController = require('../controllers/machines/editMachineController');
const getMachineByIdController = require('../controllers/machines/getMachineByIdController');
const getMachinesController = require('../controllers/machines/getMachinesController');
const getAllMachinesController = require('../controllers/machines/getAllMachinesController');
const router = express.Router();

router.post('/create', createMachineController);
router.delete('/delete/:id', deleteMachineController);
router.put('/edit', editMachineController);
router.get('/get/:id', getMachineByIdController);
router.get('/get', getMachinesController);
router.get('/getAll', getAllMachinesController);

module.exports = router;
