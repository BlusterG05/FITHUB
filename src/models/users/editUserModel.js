const { query } = require('../../db/config');

const editUserModel = async (user) => {
    const { cedula, firstName, lastName, phone, email, address, age, gender, profilePicture, trainerId, membershipStatus } = user;
    const sql = `
        SELECT edit_user($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
    `;
    const params = [cedula, firstName, lastName, phone, email, address, age, gender, profilePicture, trainerId, membershipStatus];
    try {
        const res = await query(sql, params);
        return res;
    } catch (err) {
        throw new Error('Error editing user: ' + err.message);
    }
};

module.exports = editUserModel;
