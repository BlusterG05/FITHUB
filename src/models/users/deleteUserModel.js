const { query } = require('../../db/config');

const deleteUserModel = async (cedula) => {
    const sql = `
        SELECT delete_user($1)
    `;
    try {
        const res = await query(sql, [cedula]);
        return res;
    } catch (err) {
        throw new Error('Error deleting user: ' + err.message);
    }
};

module.exports = deleteUserModel;
