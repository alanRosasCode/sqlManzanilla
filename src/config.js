import dotenv from "dotenv";
dotenv.config();

const ALTERNATIVE_PORT = 4000;

const ALTERNATIVE_HOST = "localhost";
const ALTERNATIVE_USER = "root";
const ALTERNATIVE_DATABASE = "manzanilla";
const ALTERNATIVE_PASSWORD = "password";

//Port is run app
export const PORT = process.env.PORT || ALTERNATIVE_PORT;

//Data base
export const HOST = process.env.HOST || ALTERNATIVE_HOST;
export const USER_DATA_BASE = process.env.USER_DATA_BASE || ALTERNATIVE_USER;
export const DATABASE = process.env.DATABASE || ALTERNATIVE_DATABASE;
export const PASSWORD = process.env.PASSWORD || ALTERNATIVE_PASSWORD;
