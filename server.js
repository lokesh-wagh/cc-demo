const express = require('express');
const cors = require('cors');  // Import the cors package

const app = express();
const port = 3000;

var arr = [];

// Enable CORS for all routes
app.use(cors());  // This will allow requests from any origin by default
app.use(express.json());
// Alternatively, you can configure CORS for specific origins:
app.use(cors({
  origin: 'http://localhost:5173',  // Replace with your frontend URL
  methods: ['GET', 'POST'],
  allowedHeaders: ['Content-Type']
}));

app.get('/', (req, res) => {
    res.send(`
        <!DOCTYPE html>
        <html>
        <head>
            <title>Express HTML</title>
        </head>
        <body>
           this is root of the backend
        </body>
        </html>
    `);
});

app.get('/members', (req, res) => {
    res.send(arr);
});

app.post('/add', (req, res) => {
    console.log(req.body)
    const new_member = req.body.name;
    arr = [...arr, new_member];
    res.send("successfully added");
});

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});