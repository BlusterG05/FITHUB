const getAdministrationModel = require('../../models/administration/getAdministrationModel')

const getAdministrationService = async (email) => {
    try{
        const adminUser = await getAdministrationModel(email);
        return adminUser;
    } catch (err){
        throw new Error ('Service error: ' + err.message);
    }

};

module.exports = getAdministrationService;
