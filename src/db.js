// import mysql from "mysql2/promise";
// import { HOST, USER_DATA_BASE, DATABASE, PASSWORD } from "./config.js";

// export async function Connection() {
//   try {
//     const connection = await mysql.createConnection({
//       host: `${HOST}`,
//       user: `${USER_DATA_BASE}`,
//       database: `${DATABASE}`,
//       password: `${PASSWORD}`,
//     });
    
//     console.log("Database connection successful!");
//     await connection.end(); // Cierra la conexión después de probarla
//   } catch (err) {
//     console.error("Database connection failed:", err.message);
//   }
// }
import mysql from "mysql2/promise";
import { HOST, USER_DATA_BASE, DATABASE, PASSWORD } from "./config.js";

const pool = mysql.createPool({
  host: HOST,
  user: USER_DATA_BASE,
  database: DATABASE,
  password: PASSWORD,
  waitForConnections: true,
  connectionLimit: 10, // Límite de conexiones simultáneas
  queueLimit: 0,
});

export default pool;
