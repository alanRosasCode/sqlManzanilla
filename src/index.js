import api from "./app.js";
import { PORT } from "./config.js";
// import { Connection } from "./db.js";

async function main() {
  try {
    // await Connection(); // Aseguramos que la conexión se verifique antes de iniciar el servidor
    api.listen(PORT, () => {
      console.log(`Server is listening on port ${PORT}`);
    });
  } catch (error) {
    console.error("Error starting the server:", error.message);
  }
}

main();
