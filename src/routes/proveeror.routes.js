import {
  addProveedor,
  getProveedorById,
  getProveedor,
  updateProveedor,
  deleteProveedor,
} from "../controllers/proveedor.controllers.js";
import { Router } from "express";

const router = Router();

router.post("/proveedor/add", addProveedor);
router.get("/proveedor/:id", getProveedorById);
router.get("/proveedor/", getProveedor);
router.put("/proveedor/:id", updateProveedor);
router.delete("/proveedor/:id", deleteProveedor);
export default router;
