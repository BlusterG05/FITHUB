const { query } = require('../../db/config');

const getMachinesModel = async (limit) => {
    const sql = `
        SELECT * FROM get_machines($1)
    `;
    try {
        const res = await query(sql, [limit]);
        return res.rows;
    } catch (err) {
        throw new Error('Error fetching machines: ' + err.message);
    }
};

module.exports = getMachinesModel;
