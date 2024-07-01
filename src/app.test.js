const request = require("supertest");
const app = require("./app");
const { pool } = require("./db/config");

describe("API Users Endpoints", () => {
  beforeAll(async () => {
    // Crea el usuario de prueba Jeremy Collaguazo antes de todas las pruebas
    await request(app).post("/api/users/create").send({
      cedula: "1720955671",
      firstName: "Jeremy",
      lastName: "Collaguazo",
      phone: "979923164",
      email: "jerycohe05@gmail.com",
      address: "Av chone Magisterio",
      age: 22,
      gender: "M",
      profilePicture: null,
      trainerId: null,
      membershipStatus: "Active",
    });
  });

  afterAll(async () => {
    // Elimina el usuario de prueba después de todas las pruebas
    await request(app).delete("/api/users/delete/1720955671");
    await pool.end();
  });

  it("GET /api/users/get/1720955671 debería responder con un estado 200", async () => {
    const response = await request(app).get("/api/users/get/1720955671");
    console.log("GET /api/users/get/1720955671 response:", response.body);
    expect(response.status).toBe(200);
  });

  it("GET /api/users/get?limit=10 debería responder con un estado 200", async () => {
    const response = await request(app).get("/api/users/get?limit=10");
    console.log("GET /api/users/get?limit=10 response:", response.body);
    expect(response.status).toBe(200);
  });

  it("GET /api/users/getAll debería responder con un estado 200", async () => {
    const response = await request(app).get("/api/users/getAll");
    console.log("GET /api/users/getAll response:", response.body);
    expect(response.status).toBe(200);
  });

  it("PUT /api/users/edit debería responder con un estado 200", async () => {
    const response = await request(app).put("/api/users/edit").send({
      cedula: "1720955671",
      firstName: "Jeremy",
      lastName: "Collaguazo",
      phone: "555-1234",
      email: "jerycohe05@gmail.com",
      address: "Av chone Magisterio",
      age: 31,
      gender: "M",
      profilePicture: null,
      trainerId: null,
      membershipStatus: "Active",
    });
    console.log("PUT /api/users/edit response:", response.body);
    expect(response.status).toBe(200);
  });

  it("DELETE /api/users/delete/1720955671 debería responder con un estado 200", async () => {
    // Primero crea al usuario antes de eliminarlo para asegurar que existe
    await request(app).post("/api/users/create").send({
      cedula: "1720955671",
      firstName: "Jeremy",
      lastName: "Collaguazo",
      phone: "979923164",
      email: "jerycohe05@gmail.com",
      address: "Av chone Magisterio",
      age: 22,
      gender: "M",
      profilePicture: null,
      trainerId: null,
      membershipStatus: "Active",
    });

    const response = await request(app).delete("/api/users/delete/1720955671");
    console.log("DELETE /api/users/delete/1720955671 response:", response.body);
    expect(response.status).toBe(200);
  });

  it("POST /api/users/create debería responder con un estado 200", async () => {
    // Primero elimina al usuario si existe para evitar conflictos
    await request(app).delete("/api/users/delete/1720955671");

    const response = await request(app).post("/api/users/create").send({
      cedula: "1720955671",
      firstName: "Jeremy",
      lastName: "Collaguazo",
      phone: "979923164",
      email: "jerycohe05@gmail.com",
      address: "Av chone Magisterio",
      age: 22,
      gender: "M",
      profilePicture: null,
      trainerId: null,
      membershipStatus: "Active",
    });
    console.log("POST /api/users/create response:", response.body);
    expect(response.status).toBe(201);
  });
});
