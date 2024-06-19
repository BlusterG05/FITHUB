const { query } = require('../../db/config');

const createUserModel = async (user) => {
    const { cedula, firstName, lastName, phone, email, address, age, gender, profilePicture, trainerId, membershipStatus } = user;
    const sql = `
        SELECT create_user($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
    `;
    const params = [cedula, firstName, lastName, phone, email, address, age, gender, profilePicture, trainerId, membershipStatus];
    try {
        const res = await query(sql, params);
        return res;
    } catch (err) {
        throw new Error('Error creating user: ' + err.message);
    }
};

module.exports = createUserModel;
