const express = require('express');
const axios = require('axios');

const app = express();
const PORT = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Serve HTML form
app.get('/', (req, res) => {
    res.send(`
        <html>
        <body>
            <h2>Calculate BMI</h2>
            <form action="/calculate_bmi" method="post">
                <label for="weight">Weight (kg):</label>
                <input type="number" id="weight" name="weight" required><br><br>
                <label for="height">Height (m):</label>
                <input type="number" id="height" name="height" step="0.01" required><br><br>
                <button type="submit">Calculate BMI</button>
            </form>
        </body>
        </html>
    `);
});

// Handle BMI calculation
app.post('/calculate_bmi', async (req, res) => {
    try {
        const { weight, height } = req.body;
        const response = await axios.post('http://localhost:8080/calculate_bmi', {
            weight_kg: parseFloat(weight),
            height_m: parseFloat(height)
        });
        res.send(`
            <html>
            <body>
                <h2>Result</h2>
                <p>Your BMI is: ${response.data.bmi.toFixed(2)}</p>
                <a href="/">Calculate Again</a>
            </body>
            </html>
        `);
    } catch (error) {
        console.error('Error:', error.response.data);
        res.status(500).send('Internal Server Error');
    }
});

app.listen(PORT, () => {
    console.log(`Frontend server is running on port ${PORT}`);
});
