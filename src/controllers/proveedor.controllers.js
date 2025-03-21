import pool from "../db.js";

export const addProveedor = async (req, res) => {
  try {
    const { nombre, numero_telefonico } = req.body;

    // Validación: Verificar que los campos no estén vacíos
    if (!nombre || !numero_telefonico) {
      return res
        .status(400)
        .json({ error: "Todos los campos son obligatorios" });
    }

    const connection = await pool.getConnection();

    // Verificar si el número telefónico ya está registrado
    const [existing] = await connection.query(
      "SELECT id FROM proveedor WHERE numero_telefonico = ?",
      [numero_telefonico]
    );

    if (existing.length > 0) {
      connection.release();
      return res
        .status(409)
        .json({ error: "El número telefónico ya está registrado" });
    }

    // Insertar nuevo proveedor
    const [result] = await connection.query(
      "INSERT INTO proveedor (nombre, numero_telefonico) VALUES (?, ?)",
      [nombre, numero_telefonico]
    );

    connection.release(); // Liberar la conexión

    res.status(201).json({
      message: "Proveedor agregado con éxito",
      id: result.insertId,
    });
  } catch (error) {
    console.error("Error al agregar proveedor:", error.message);
    res.status(500).json({ error: "Error interno del servidor" });
  }
};



export const getProveedorById = async (req, res) => {
  try {
    const { id } = req.params;
    const connection = await pool.getConnection();
    const [rows] = await connection.query(
      "SELECT * FROM proveedor WHERE id = ?",
      [id]
    );
    connection.release();

    if (rows.length === 0) {
      return res.status(404).json({ error: "Proveedor no encontrado" });
    }

    res.json(rows[0]);
  } catch (error) {
    console.error("Error al obtener proveedor:", error.message);
    res.status(500).json({ error: "Error interno del servidor" });
  }
};

export const getProveedor = async (req, res) => {
  try {
    const connection = await pool.getConnection();
    const [rows] = await connection.query("SELECT * FROM proveedor");
    connection.release();

    if (rows.length === 0) {
      return res.status(404).json({ error: "No hay proveedores registrados" });
    }

    res.json(rows);
  } catch (error) {
    console.error("Error al obtener proveedores:", error.message);
    res.status(500).json({ error: "Error interno del servidor" });
  }
};


export const updateProveedor = async (req, res) => {
  try {
    const { id } = req.params;
    const { nombre, numero_telefonico } = req.body;
    if (!nombre || !numero_telefonico) {
      return res
        .status(400)
        .json({ error: "Todos los campos son obligatorios" });
    }

    const connection = await pool.getConnection();
    const [result] = await connection.query(
      "UPDATE proveedor SET nombre = ?, numero_telefonico = ? WHERE id = ?",
      [nombre, numero_telefonico, id]
    );
    connection.release();

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "Proveedor no encontrado" });
    }

    res.json({ message: "Proveedor actualizado con éxito" });
  } catch (error) {
    console.error("Error al actualizar proveedor:", error.message);
    res.status(500).json({ error: "Error interno del servidor" });
  }
};

export const deleteProveedor = async (req, res) => {
  try {
    const { id } = req.params;
    const connection = await pool.getConnection();
    const [result] = await connection.query(
      "DELETE FROM proveedor WHERE id = ?",
      [id]
    );
    connection.release();

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "Proveedor no encontrado" });
    }

    res.json({ message: "Proveedor eliminado con éxito" });
  } catch (error) {
    console.error("Error al eliminar proveedor:", error.message);
    res.status(500).json({ error: "Error interno del servidor" });
  }
};
