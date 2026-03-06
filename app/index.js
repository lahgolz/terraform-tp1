require('dotenv').config();
const express = require('express');

const app = express();
const PORT = process.env.PORT ?? 3000;

app.get('/health', (_req, res) => {
  const databaseUrl = process.env.DATABASE_URL ?? 'not set';

  console.log(`Database URL: ${databaseUrl}`);

  res.status(200).json({ status: 'ok' });
});

app.get('/', (_req, res) => {
  res.status(200).json({ env: process.env.APP_ENV });
});

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
