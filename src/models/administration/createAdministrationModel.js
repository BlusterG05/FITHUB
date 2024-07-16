const { query } = require('../../db/config');


const createAdministrationUser = async (name,username,email,password,role) => {
    console.log(`creatin user`, name);

    const sql = `insert into administration_users(admin_name,admin_username,admin_email,admin_password,admin_role) values ($1,$2,$3,$4,$5);`;
    
    const  params = [name,username,email,password,role];

    try{
        const res = await query(sql,params);
/*         console.log('aqui en teoria se creo',res); */
        return res;
    }catch(err){
        /* console.log('aqui en teoria fallo', err) */
        throw new Error('Error creating user :' + err.message);
    }

};

module.exports = createAdministrationUser;

/* createAdministrationUser('Samir',
                        'Samir Cohe',
                        'allusiveaunt@gmail.com',
                        '$2a$12$OGoIzp/0fm/dYSEacKjm0.8niQEXAQn8zwyEvV35XmJJEe8VCHNRa',
                        'User'
); */