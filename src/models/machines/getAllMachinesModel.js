const { query } = require('../../db/config');

const getAllMachinesModel = async () => {
    const sql = `
        SELECT * FROM get_all_machines()
    `;
    try {
        const res = await query(sql);
        return res.rows;
    } catch (err) {
        throw new Error('Error fetching all machines: ' + err.message);
    }
};

module.exports = getAllMachinesModel;
