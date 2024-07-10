const express = require('express');
const axios = require('axios');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

// Configurarea cheii API Google Generative AI
const GOOGLE_API_KEY = '';
const GOOGLE_API_URL = 'https://api.generative.google.com/v1/...'; // Endpoint-ul API-ului

app.use(bodyParser.json());

app.post('/generate', async (req, res) => {
    const prompt = req.body.prompt;

    try {
        const response = await axios.post(
            GOOGLE_API_URL,
            { prompt },
            { headers: { 'Authorization': `Bearer ${GOOGLE_API_KEY}` } }
        );
        res.json(response.data);
    } catch (error) {
        res.status(500).send(error.toString());
    }
});

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
