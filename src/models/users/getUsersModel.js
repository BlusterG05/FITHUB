const { query } = require('../../db/config');

const getUsersModel = async (limit) => {
    const sql = `
        SELECT * FROM get_users($1)
    `;
    try {
        const res = await query(sql, [limit]);
        return res.rows;
    } catch (err) {
        throw new Error('Error fetching users: ' + err.message);
    }
};

module.exports = getUsersModel;
