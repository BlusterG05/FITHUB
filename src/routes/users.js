const express = require('express');
const createUserController = require('../controllers/users/createUserController');
const deleteUserController = require('../controllers/users/deleteUserController');
const editUserController = require('../controllers/users/editUserController');
const getUserController = require('../controllers/users/getUserController');
const getUsersController = require('../controllers/users/getUsersController');
const getAllUsersController = require('../controllers/users/getAllUsersController');
const router = express.Router();

router.post('/create', createUserController);
router.delete('/delete/:cedula', deleteUserController);
router.put('/edit', editUserController);
router.get('/get/:cedula', getUserController);
router.get('/get', getUsersController);
router.get('/getAll', getAllUsersController);

module.exports = router;
