# Quick Start Guide - Khushi Glossary Backend

## 🚀 Get Started in 5 Minutes

### Step 1: Install Dependencies
```bash
cd app-server
npm install
```

### Step 2: Setup Supabase

1. Go to [Supabase](https://supabase.com) and create a new project
2. Go to **SQL Editor** and run the `database-schema.sql` file
3. Go to **Settings** → **API** and copy:
   - Project URL
   - `anon` public key
   - `service_role` secret key

### Step 3: Configure Environment

Copy the example environment file:
```bash
copy .env.example .env
```

Edit `.env` and add your Supabase credentials:
```env
PORT=5000
NODE_ENV=development

# Your Supabase credentials
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your_anon_key
SUPABASE_SERVICE_KEY=your_service_role_key

# Generate a random secret (you can use any random string)
JWT_SECRET=your_super_secret_jwt_key_change_this

# Allow your mobile app to connect
ALLOWED_ORIGINS=http://localhost:3000,http://localhost:19006
```

### Step 4: Start the Server

**Development mode with auto-reload:**
```bash
npm run dev
```

**Production mode:**
```bash
npm start
```

You should see:
```
🚀 Server is running
📍 Port: 5000
🌍 Environment: development
🔗 Local: http://localhost:5000
```

### Step 5: Test the API

Open your browser or use curl:
```bash
curl http://localhost:5000/health
```

Response:
```json
{
  "status": "ok",
  "timestamp": "2024-12-24T...",
  "environment": "development"
}
```

## 📱 Connect Mobile App

Update your mobile app's API configuration to:
```typescript
const API_URL = 'http://localhost:5000/api';
// or your server IP: 'http://192.168.x.x:5000/api'
```

## 🧪 Test Endpoints

### Register a new user:
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "phone": "9876543210",
    "name": "Test User",
    "email": "test@example.com",
    "password": "password123"
  }'
```

### Login:
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "phone": "9876543210",
    "password": "password123"
  }'
```

### Get categories:
```bash
curl http://localhost:5000/api/categories
```

## 🔧 Troubleshooting

### Port already in use?
Change the PORT in `.env` file to another port (e.g., 5001)

### Can't connect from mobile app?
- Make sure your computer and phone are on the same WiFi
- Use your computer's IP address instead of localhost
- Check Windows Firewall settings

### Supabase connection error?
- Verify your credentials in `.env`
- Check if your Supabase project is active
- Ensure database schema is created

## 📚 Next Steps

1. Add sample products to Supabase database
2. Test all API endpoints
3. Connect your mobile app to the backend
4. Implement authentication flow
5. Test cart and order functionality

## 🎯 API Base URL

Local development: `http://localhost:5000/api`

All endpoints:
- `/api/auth/*` - Authentication
- `/api/categories` - Categories
- `/api/products` - Products
- `/api/cart` - Shopping cart
- `/api/orders` - Orders
- `/api/addresses` - Delivery addresses

See `README.md` for complete API documentation.
