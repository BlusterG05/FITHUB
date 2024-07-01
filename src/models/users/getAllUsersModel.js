const { query } = require('../../db/config');

const getAllUsersModel = async () => {
    const sql = `
        SELECT * FROM get_all_users()
    `;
    try {
        const res = await query(sql);
        console.log("Query complete")
        return res.rows;
    } catch (err) {
        throw new Error('Error fetching all users: ' + err.message);
    }
};

module.exports = getAllUsersModel;
