const createAdministrationUser = require("../../models/administration/createAdministrationModel");
const bcrypt = require('bcrypt');

const createAdministrationService = async (name, username, email, password, role) => {
    try {
        // Hashear la contraseña
        const saltRounds = 12;
        const hashedPassword = await bcrypt.hash(password, saltRounds);

        // Crear el usuario en la base de datos
        const adminUser = await createAdministrationUser(name, username, email, hashedPassword, role);
        return adminUser;
    } catch (err) {
        throw new Error('Service Error: ' + err.message);
    }
};

module.exports = createAdministrationService;



/* createAdministrationService('Carlitos',
                            'Carlitos23',
                            'calitos@gmail.com',
                            'carlitosrules',
                            'User'
); */