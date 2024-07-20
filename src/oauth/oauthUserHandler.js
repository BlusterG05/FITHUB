// src/oauth/oauthUserHandler.js
const createAdministrationService = require('../services/Administration/createAdministrationService');
const getAdministrationService = require('../services/Administration/getAdministrationService');

async function findOrCreateUser(profile) {
    try {
        let user = await getAdministrationService(profile.email);
        
        if (!user) {
            console.log(`Creating user ${profile.name}`);
            user = await createAdministrationService(
                profile.name,
                profile.email.split('@')[0], // username
                profile.email,
                Math.random().toString(36).slice(-8), // random password
                'Usuario' // default role
            );
        }
        
        console.log('User object to be serialized:', user);
        return user;  // Esto debería ser un objeto, no un array
    } catch (error) {
        console.error('Error in findOrCreateUser:', error);
        throw error;
    }
}

module.exports = findOrCreateUser;