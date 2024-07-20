const createAdministrationUser = require("../../models/administration/createAdministrationModel");
const bcrypt = require('bcrypt');

const createAdministrationService = async (name, username, email, password, role) => {
    try {
        const saltRounds = 12;
        const hashedPassword = await bcrypt.hash(password, saltRounds);

        const adminUser = await createAdministrationUser(name, username, email, hashedPassword, role);
        
        // Asegúrate de no devolver la contraseña hasheada
        const { admin_password, ...userWithoutPassword } = adminUser;
        
        return userWithoutPassword;  // Esto debería ser un objeto, no un array
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