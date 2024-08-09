import express from 'express';
import { Pool } from 'pg';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const port = 3000;

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: Number(process.env.DB_PORT),
});

app.get('/api/portfolio/:userId', async (req, res) => {
  const userId = req.params.userId;
  const client = await pool.connect();
  try {
    const result = await client.query(
      'SELECT * FROM investments WHERE user_id = $1',
      [userId]
    );
    res.json(result.rows);
  } finally {
    client.release();
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
