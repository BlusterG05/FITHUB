const createAdministrationService = require( '../../services/Administration/createAdministrationService')
const jwt = require('jsonwebtoken');
require('dotenv').config();


const createAdministrationRegisterController = async (req,res) => {
    const {Name,Username,Email,Password} = req.body;
    const Role = 'Usuario';

    try {
        // Llamar al servicio para crear el usuario
        const adminUser = await createAdministrationService(Name, Username, Email, Password, Role);

        // Generar el token JWT
        const payload = {
            sub: adminUser.admin_id,
            username: adminUser.admin_username,
            role: adminUser.admin_role,
            iat: Math.floor(Date.now() / 1000),
            exp: Math.floor(Date.now() / 1000) + (60 * 60) // Expira en 1 hora
        };

        const token = jwt.sign(payload, process.env.JWT_SECRET);

        // Enviar la respuesta con el usuario creado y el token JWT
        res.status(201).json({ message : 'Created correctly', token });
    } catch (err) {
        console.error('Error registering user:', err);
        if (err.message === 'Email or username already in use') {
            res.status(400).send('Email or username already in use');
        } else {
            const errorMsg = err.message
            res.status(500).send({message:"Something its wrong, try again", errorMsg});
        }
    }
};

module.exports = createAdministrationRegisterController;