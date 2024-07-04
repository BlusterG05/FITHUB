const express = require('express');
const getadministrationLoginController = require('../controllers/administration/getAdministrationController');
const router = express.Router();



router.post('/login', getadministrationLoginController);


module.exports = router;