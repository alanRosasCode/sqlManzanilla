import pool from "../db.js";

export const addManzanilla = async (req, res) => {
  try {
    const { tipo, kilo, sacos, numero_telefonico, nombre } = req.body;

    if (!tipo || !kilo || !sacos || !numero_telefonico || !nombre) {
      return res
        .status(400)
        .json({ error: "Todos los campos son obligatorios" });
    }

    const connection = await pool.getConnection();

    // Obtener id_proveedor basado en el nombre y número telefónico
    const [proveedor] = await connection.query(
      "SELECT id_proveedor FROM proveedor WHERE numero_telefonico = ? AND nombre = ?",
      [numero_telefonico, nombre]
    );

    if (proveedor.length === 0) {
      connection.release();
      return res.status(404).json({ error: "Proveedor no encontrado" });
    }

    const id_proveedor = proveedor[0].id_proveedor;

    const [result] = await connection.query(
      "INSERT INTO manzanilla (tipo, kilo, sacos, id_proveedor) VALUES (?, ?, ?, ?)",
      [tipo, kilo, sacos, id_proveedor]
    );
    connection.release();

    res.status(201).json({
      message: "Registro de manzanilla agregado con éxito",
      id: result.insertId,
    });
  } catch (error) {
    console.error("Error al agregar manzanilla:", error.message);
    res.status(500).json({ error: "Error interno del servidor" });
  }
};

export const getManzanillaById = async (req, res) => {
  try {
    const { id_manzanilla } = req.params;
    const connection = await pool.getConnection();
    const [rows] = await connection.query(
      "SELECT * FROM manzanilla WHERE id_manzanilla = ?",
      [id_manzanilla]
    );
    connection.release();

    if (rows.length === 0) {
      return res.status(404).json({ error: "Registro no encontrado" });
    }

    res.json(rows[0]);
  } catch (error) {
    console.error("Error al obtener registro:", error.message);
    res.status(500).json({ error: "Error interno del servidor" });
  }
};

export const getManzanilla = async (req, res) => {
  try {
    const connection = await pool.getConnection();
    const [rows] = await connection.query("SELECT * FROM manzanilla");
    connection.release();

    if (rows.length === 0) {
      return res.status(404).json({ error: "No hay registros disponibles" });
    }

    res.json(rows);
  } catch (error) {
    console.error("Error al obtener registros:", error.message);
    res.status(500).json({ error: "Error interno del servidor" });
  }
};

export const updateManzanilla = async (req, res) => {
  try {
    const { id_manzanilla } = req.params;
    const { tipo, kilo, sacos, id_proveedor } = req.body;

    if (!tipo || !kilo || !sacos || !id_proveedor) {
      return res
        .status(400)
        .json({ error: "Todos los campos son obligatorios" });
    }

    const connection = await pool.getConnection();
    const [result] = await connection.query(
      "UPDATE manzanilla SET tipo = ?, kilo = ?, sacos = ?, id_proveedor = ? WHERE id_manzanilla = ?",
      [tipo, kilo, sacos, id_proveedor, id_manzanilla]
    );
    connection.release();

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "Registro no encontrado" });
    }

    res.json({ message: "Registro actualizado con éxito" });
  } catch (error) {
    console.error("Error al actualizar registro:", error.message);
    res.status(500).json({ error: "Error interno del servidor" });
  }
};

export const deleteManzanilla = async (req, res) => {
  try {
    const { id_manzanilla } = req.params;
    const connection = await pool.getConnection();
    const [result] = await connection.query(
      "DELETE FROM manzanilla WHERE id_manzanilla = ?",
      [id_manzanilla]
    );
    connection.release();

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "Registro no encontrado" });
    }

    res.json({ message: "Registro eliminado con éxito" });
  } catch (error) {
    console.error("Error al eliminar registro:", error.message);
    res.status(500).json({ error: "Error interno del servidor" });
  }
};
