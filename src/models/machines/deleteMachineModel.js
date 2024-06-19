const { query } = require('../../db/config');

const deleteMachineModel = async (id) => {
    const sql = `
        SELECT delete_machine($1)
    `;
    try {
        const res = await query(sql, [id]);
        return res;
    } catch (err) {
        throw new Error('Error deleting machine: ' + err.message);
    }
};

module.exports = deleteMachineModel;
