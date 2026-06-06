# ArdhiTrack 🌿

**Blockchain-Based Land Leasing and Agricultural Yield Tracking System for Kajiado County, Kenya**

ArdhiTrack is a production-level Flutter mobile application that records leased agricultural land, tracks crop production (mavuno), and stores lease agreements on the Ethereum Sepolia testnet for transparency and tamper-proof records.

## 🚀 Features

### 🔐 Authentication
- Supabase email/password authentication
- Role-based dashboard redirection (Admin, Landowner, Farmer)

### 🌍 Land Registration (Landowner)
- Add land with GPS location and map picker
- Record size (acres), soil type, water source
- Upload land photos
- Track leasing status (Available/Leased)

### 📜 Lease Creation (Blockchain)
- Create lease agreements with farmer details
- Set lease duration and crop type
- Store lease hash on Ethereum Sepolia smart contract
- Full lease data stored in Supabase

### 🌾 Crop & Yield Tracking (Farmer)
- Record crop planting dates
- Track by season (Long rains / Short rains)
- Record expected and actual yields
- Upload farm photos

### 📊 Analytics Dashboard (Admin)
- Total land registered
- Total leased land
- Crop distribution charts
- Productivity by ward
- Yield statistics

### 🗺 Map View
- Google Maps integration
- Visual indicators:
  - 🟢 Green = Available land
  - 🔴 Red = Leased land

### 🔎 Search & Filter
- Filter by ward
- Filter by crop type
- Filter by lease status

### 🔗 Blockchain Verification
- Verify lease records on Ethereum
- Compare database vs blockchain hashes
- Tamper detection

## 🛠 Tech Stack

- **Frontend**: Flutter (Clean Architecture, Null Safety)
- **Backend**: Supabase (PostgreSQL + Auth + Storage + Realtime)
- **Blockchain**: Ethereum Sepolia testnet
- **Smart Contract**: Solidity
- **Web3 Library**: web3dart
- **State Management**: Riverpod
- **Maps**: Google Maps Flutter
- **Charts**: fl_chart
- **UI**: Modern, clean, green agriculture theme 🌿

## 📋 Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Supabase account
- Ethereum Sepolia testnet access
- Google Maps API key
- MetaMask wallet (for blockchain transactions)

## 🔧 Setup Instructions

### 1. Clone the Repository

```bash
git clone <repository-url>
cd ArdhiTrack
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Supabase

1. Create a new project at [supabase.com](https://supabase.com)
2. Run the SQL schema from `supabase/schema.sql` in your Supabase SQL Editor
3. Create storage buckets:
   - `land-photos`
   - `crop-photos`
4. Update `lib/core/config/app_config.dart`:
   ```dart
   static const String supabaseUrl = 'YOUR_SUPABASE_URL';
   static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
   ```

### 4. Deploy Smart Contract

1. Install Hardhat or Remix IDE
2. Deploy `contracts/ArdhiTrack.sol` to Ethereum Sepolia testnet
3. Update `lib/core/config/app_config.dart`:
   ```dart
   static const String contractAddress = 'YOUR_DEPLOYED_CONTRACT_ADDRESS';
   ```

### 5. Configure Google Maps

1. Get a Google Maps API key from [Google Cloud Console](https://console.cloud.google.com/)
2. Enable Maps SDK for Android/iOS
3. Update `lib/core/config/app_config.dart`:
   ```dart
   static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
   ```
4. For Android, add to `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <meta-data
       android:name="com.google.android.geo.API_KEY"
       android:value="YOUR_GOOGLE_MAPS_API_KEY"/>
   ```
5. For iOS, add to `ios/Runner/AppDelegate.swift`:
   ```swift
   GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
   ```

### 6. Configure Ethereum RPC

Update `lib/core/config/app_config.dart`:
```dart
static const String rpcUrl = 'https://sepolia.infura.io/v3/YOUR_INFURA_KEY';
```

Or use Alchemy, QuickNode, or another RPC provider.

### 7. Run the App

```bash
flutter run
```

## 📱 User Roles

### Admin (County Officer)
- View all lands and leases
- Access analytics dashboard
- Verify blockchain records
- Monitor productivity by ward

### Landowner
- Register land
- Create lease agreements
- View owned lands
- Track lease status

### Farmer (Lessee)
- View active leases
- Record crop yields
- Track production by season
- Upload farm photos

## 🗄 Database Schema

The app uses the following Supabase tables:

- **users**: User profiles with roles
- **lands**: Land registration data
- **leases**: Lease agreements with blockchain hashes
- **crops**: Crop yield tracking data

See `supabase/schema.sql` for full schema.

## 🔗 Smart Contract

The `ArdhiTrack.sol` contract stores:
- `landId => leaseHash` mapping
- Timestamp and recorder address
- Verification functions

### Contract Functions

- `recordLease(string landId, bytes32 leaseHash)`: Record a lease hash
- `verifyLease(string landId, bytes32 providedHash)`: Verify a lease hash
- `getLeaseInfo(string landId)`: Get lease information
- `leaseExists(string landId)`: Check if lease exists

## 🔐 Blockchain Integration

### Recording a Lease

1. Create lease in Supabase
2. Generate SHA256 hash of lease data
3. Call smart contract `recordLease()` function
4. Store transaction hash in Supabase

### Verification

1. Fetch lease from Supabase
2. Get hash from blockchain
3. Compare hashes
4. Display verification result

## 📁 Project Structure

```
lib/
├── core/
│   ├── config/          # App configuration
│   ├── router/          # Navigation routing
│   └── theme/           # App theme
├── data/
│   └── services/        # Supabase & Web3 services
├── domain/
│   └── models/          # Data models
└── presentation/
    ├── providers/       # Riverpod providers
    └── screens/         # UI screens
```

## 🎨 UI Theme

The app uses a modern green agriculture theme:
- Primary: Green (#2E7D32)
- Accent: Light Green (#4CAF50)
- Background: Light Green (#E8F5E9)
- Soil Brown (#8D6E63)
- Sun Yellow (#FFC107)

## 🧪 Testing

To test the app:

1. **Create Test Users**:
   - Register accounts with different roles
   - Use test emails

2. **Add Test Lands**:
   - Use GPS coordinates for Kajiado County
   - Upload sample photos

3. **Create Test Leases**:
   - Use MetaMask testnet account
   - Get Sepolia ETH from faucet

4. **Test Blockchain**:
   - Record leases on blockchain
   - Verify records

## 📝 Notes

- The app uses Ethereum Sepolia **testnet** - no real money involved
- Private keys should be handled securely in production
- Consider using WalletConnect for better UX
- Add proper error handling and loading states
- Implement offline support with local caching

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- Kajiado County for the agricultural land management use case
- Supabase for the backend infrastructure
- Ethereum Foundation for blockchain technology

---

