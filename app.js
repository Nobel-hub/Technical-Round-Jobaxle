require('dotenv').config()

const dbHost = process.env.DB_HOST
const dbPort = process.env.DB_PORT
const dbUser = process.env.DB_USER
const dbPassword = process.env.DB_PASSWORD
const jwtSecret = process.env.JWT_SECRET

console.log("App configured with environment variables")
