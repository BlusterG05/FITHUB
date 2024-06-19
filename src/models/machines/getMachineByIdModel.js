const { query } = require('../../db/config');

const getMachineByIdModel = async (id) => {
    const sql = `
        SELECT * FROM get_machine_byID($1)
    `;
    try {
        const res = await query(sql, [id]);
        return res.rows[0];
    } catch (err) {
        throw new Error('Error fetching machine by ID: ' + err.message);
    }
};

module.exports = getMachineByIdModel;
