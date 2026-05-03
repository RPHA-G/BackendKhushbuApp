const app = require('./app');
require('dotenv').config();

const PORT = process.env.PORT || 5000;

// Helper to list network addresses for convenience
const getLocalIPs = () => {
  const os = require('os');
  const nets = os.networkInterfaces();
  const results = [];
  for (const name of Object.keys(nets)) {
    for (const net of nets[name]) {
      // Skip internal (i.e. 127.0.0.1) and non-IPv4 addresses
      if (net.family === 'IPv4' && !net.internal) {
        results.push(net.address);
      }
    }
  }
  return results;
};

app.listen(PORT, () => {
  console.log('🚀 Server is running');
  console.log(`📍 Port: ${PORT}`);
  console.log(`🌍 Environment: ${process.env.NODE_ENV || 'development'}`);
  console.log(`🔗 Local: http://localhost:${PORT}`);

  // Print LAN addresses for physical device testing
  try {
    const ips = getLocalIPs();
    if (ips.length > 0) {
      console.log('🔗 Network URLs:');
      ips.forEach((ip) => {
        console.log(`  http://${ip}:${PORT}`);
        console.log(`  http://${ip}:${PORT}/api`);
      });
    } else {
      console.log('⚠️  No non-internal IPv4 addresses found');
    }
  } catch (e) {
    console.error('Failed to enumerate network interfaces', e);
  }

  console.log(`📚 API Docs: http://localhost:${PORT}/`);
  console.log('\n✅ Server started successfully!\n');
});

// Handle unhandled promise rejections
process.on('unhandledRejection', (err) => {
  console.error('Unhandled Promise Rejection:', err);
  process.exit(1);
});

// Handle uncaught exceptions
process.on('uncaughtException', (err) => {
  console.error('Uncaught Exception:', err);
  process.exit(1);
});
