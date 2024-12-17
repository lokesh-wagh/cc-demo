const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
    res.send(`
        <!DOCTYPE html>
        <html>
        <head>
            <title>Express HTML</title>
        </head>
        <body>
            <a>
                https://www.youtube.com/watch?v=dQw4w9WgXcQg
            </a>
            <b>this text is new addition to test the script</b>
            i hope this changes
        </body>
        </html>
    `);
});

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});
