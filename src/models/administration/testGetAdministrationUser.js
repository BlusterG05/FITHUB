// testGetAdministrationUser.js

const getAdministrationUser = require('./getAdministrationModel'); // Asegúrate de poner la ruta correcta

const testEmail = 'jerycohe05@gmail.com'; // Reemplaza esto con un email de prueba válido

const runTest = async () => {
    try {
        const user = await getAdministrationUser(testEmail);
        console.log('User fetched successfully:', user[0].admin_password);
    } catch (err) {
        console.error('Error fetching user:', err.message);
    }
};

runTest();
