import express from "express";
import proveedorRoutes from "./routes/proveeror.routes.js";
const api = express();

api.use(express.json());
api.use(express.urlencoded({ extended: true }));

api.use("/api", proveedorRoutes);

export default api;
