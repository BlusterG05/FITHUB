const getAdministrationModel = require('../../models/administration/getAdministrationModel')

const getAdministrationService = async (identifier) => {
    try {
        let adminUser;
        if (typeof identifier === 'string' && identifier.includes('@')) {
            // Es un email
            adminUser = await getAdministrationModel(identifier);
        } else {
            // Es un ID
            adminUser = await getAdministrationModel(identifier, true);
        }

        if (adminUser && adminUser.length > 0) {
            // Asegúrate de no devolver la contraseña
            const { admin_password, ...userWithoutPassword } = adminUser[0];
            return userWithoutPassword;  // Devuelve el objeto directamente, no un array
        }
        return null;
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = getAdministrationService;