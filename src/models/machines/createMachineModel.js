const { query } = require('../../db/config');

const createMachineModel = async (machine) => {
    const { name, acquiredAt, categoryId, groupId, disciplineId } = machine;
    const sql = `
        SELECT create_machine($1, $2, $3, $4, $5)
    `;
    const params = [name, acquiredAt, categoryId, groupId, disciplineId];
    try {
        const res = await query(sql, params);
        return res;
    } catch (err) {
        throw new Error('Error creating machine: ' + err.message);
    }
};

module.exports = createMachineModel;
