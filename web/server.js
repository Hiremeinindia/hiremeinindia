const express = require('express');
const http = require('http');
const app = express();

// Enable CORS for all routes
app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  next();
});

// Route handler for GET requests to /api/data
app.get('/api/data', (req, res) => {
  // Handle GET request
  res.json({ message: 'Data received' });
});

// Route handler for POST requests to /api/data
app.post('/api/data', (req, res) => {
  // Handle POST request
  res.json({ message: 'Data received via POST method' });
});

// Function to make request to external URL
async function makeExternalRequest() {
  try {
    const url = 'https://flutter.rohitchouhan.com/email-otp/v2.php?app_name=someAppName&app_email=someEmail&user_email=someUserEmail&otp_length=someOtpLength&type=someType';
    const response = await http.get(url);
    
    // Process the response here if needed
    console.log(response.data);
  } catch (error) {
    console.error('Error making request:', error);
  }
}

// Make the external request when the server starts
makeExternalRequest();

// Start the server
const PORT = process.env.PORT || 3003;
app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
