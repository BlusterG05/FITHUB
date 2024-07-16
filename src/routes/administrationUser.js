const express = require('express');
const getadministrationLoginController = require('../controllers/administration/getAdministrationController');
const createAdministrationRegisterController = require('../controllers/administration/createAdministrationController')
const router = express.Router();



router.post('/login', getadministrationLoginController);
router.post('/register',createAdministrationRegisterController);

module.exports = router;