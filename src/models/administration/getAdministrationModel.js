const { query } = require('../../db/config');

const getAdministrationUser = async (identifier, isId = false) => {
    console.log(`Fetching user with ${isId ? 'ID' : 'email'}:`, identifier);
    
    if (!identifier) {
        throw new Error('Invalid identifier provided');
    }

    let sql;
    if (isId) {
        sql = `SELECT * FROM administration_users WHERE admin_id = $1;`;
    } else {
        sql = `SELECT * FROM administration_users WHERE admin_email = $1;`;
    }

    try {
        const res = await query(sql, [identifier]);
        return res.rows;
    } catch (err) {
        console.error('Error in query execution:', err.message);
        throw new Error(`Error fetching user: ${err.message}`);
    }
};

module.exports = getAdministrationUser;