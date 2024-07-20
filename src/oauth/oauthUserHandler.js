// src/oauth/oauthUserHandler.js
const createAdministrationService = require('../services/Administration/createAdministrationService');
const getAdministrationService = require('../services/Administration/getAdministrationService');

async function findOrCreateUser(profile) {
    try {
        let user = await getAdministrationService(profile.email);
        
        if (!user || user.length === 0) {
            console.log(`Creating user ${profile.name}`);
            user = await createAdministrationService(
                profile.name,
                profile.email.split('@')[0], // username
                profile.email,
                Math.random().toString(36).slice(-8), // random password
                'Usuario' // default role
            );
            // Asegúrate de que createAdministrationService devuelva el usuario creado, no el resultado de la operación
            return user;
        } else {
            console.log(`User found: ${user[0].admin_username}`);
            return user[0];
        }
    } catch (error) {
        console.error('Error in findOrCreateUser:', error);
        throw error;
    }
}

module.exports = findOrCreateUser;