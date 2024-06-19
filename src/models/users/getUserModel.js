const { query } = require('../../db/config');

const getUserModel = async (cedula) => {
    const sql = `
        SELECT * FROM get_user($1)
    `;
    try {
        const res = await query(sql, [cedula]);
        return res.rows[0];
    } catch (err) {
        throw new Error('Error fetching user: ' + err.message);
    }
};

module.exports = getUserModel;
