const { query } = require('../../db/config');

const editMachineModel = async (machine) => {
    const { id, name, acquiredAt, categoryId, groupId, disciplineId } = machine;
    const sql = `
        SELECT edit_machine($1, $2, $3, $4, $5, $6)
    `;
    const params = [id, name, acquiredAt, categoryId, groupId, disciplineId];
    try {
        const res = await query(sql, params);
        return res;
    } catch (err) {
        throw new Error('Error editing machine: ' + err.message);
    }
};

module.exports = editMachineModel;
