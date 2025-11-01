# 📝 Aptos Todo dApp

A decentralized todo list application built on the Aptos blockchain. Manage your tasks on-chain with complete transparency and immutability!

<img width="1920" height="1020" alt="Screenshot 2025-11-01 065930" src="https://github.com/user-attachments/assets/7639b1dc-674a-476a-b10c-3b6ecbbfda68" />

<img width="1920" height="1020" alt="Screenshot 2025-11-01 065930" src="https://github.com/user-attachments/assets/bb420685-88c5-4466-bc7a-0d289e19d09b" />



## 🌟 Features

- ✅ **Create Tasks** - Add new tasks to your personal todo list
- ✅ **Complete Tasks** - Mark tasks as done
- ✅ **On-Chain Storage** - All tasks stored permanently on Aptos blockchain
- ✅ **Wallet Integration** - Connect with Petra Wallet
- ✅ **User-Specific** - Each user has their own independent task list
- ✅ **Real-time Updates** - Instant blockchain synchronization

## 🏗️ Project Structure

```
aptos-todo-dapp/
├── contract/
│   ├── sources/
│   │   └── todo_list.move      # Smart contract
│   ├── Move.toml                # Move configuration
│   └── .aptos/                  # Aptos CLI config
├── frontend/
│   └── index.html               # Complete frontend (HTML + CSS + JS)
└── README.md
```

## 🛠️ Tech Stack

### Smart Contract
- **Language**: Move
- **Blockchain**: Aptos (Devnet)
- **CLI Version**: Aptos CLI v4.10.x

### Frontend
- **Framework**: Vanilla JavaScript (no build tools required)
- **Wallet**: Petra Wallet Adapter
- **Styling**: CSS3 with modern gradients and animations
- **Network Calls**: Native Fetch API

## 📋 Prerequisites

Before you begin, ensure you have:

1. **Aptos CLI** installed ([Installation Guide](https://aptos.dev/cli-tools/aptos-cli-tool/install-aptos-cli))
   ```bash
   aptos --version
   # Should show: aptos 4.10.x or higher
   ```

2. **Petra Wallet** browser extension ([Download](https://petra.app/))
   - Chrome/Brave: [Chrome Web Store](https://chrome.google.com/webstore/detail/petra-aptos-wallet/ejjladinnckdgjemekebdpeokbikhfci)
   - Edge: [Microsoft Edge Store](https://microsoftedge.microsoft.com/addons)

3. **Node.js** (optional, for local server)
   - Only needed if you want to run a local HTTP server

## 🚀 Quick Start

### Step 1: Clone the Repository

```bash
git clone https://github.com/yourusername/aptos-todo-dapp.git
cd aptos-todo-dapp
```

### Step 2: Set Up Aptos CLI

```bash
# Initialize Aptos configuration
aptos init

# Choose network: devnet
# Press Enter to generate a new keypair
# Account will be automatically funded
```

### Step 3: Deploy Smart Contract

```bash
cd contract

# Get your account address
aptos account list

# Update Move.toml with your address
# [addresses]
# todo_addr = "0xYOUR_ADDRESS_HERE"

# Compile the contract
aptos move compile --named-addresses todo_addr=YOUR_ADDRESS --skip-fetch-latest-git-deps

# Deploy to devnet
aptos move publish --named-addresses todo_addr=YOUR_ADDRESS --skip-fetch-latest-git-deps
```

### Step 4: Configure Frontend

Open `frontend/index.html` and update the module address (around line 186):

```javascript
const MODULE_ADDRESS = "0xYOUR_DEPLOYED_ADDRESS_HERE";
```

### Step 5: Import Account to Petra

```bash
# Get your private key
type .aptos\config.yaml  # Windows
# or
cat .aptos/config.yaml   # Mac/Linux
```

Then in Petra Wallet:
1. Click account menu → "Add Account" → "Import Private Key"
2. Paste your private key
3. Switch to this account
4. Make sure you're on **Devnet** network

### Step 6: Run the dApp

**Option A: Direct File Access**
1. Enable "Allow access to file URLs" in Petra extension settings
2. Double-click `frontend/index.html`

**Option B: Local Server (Recommended)**

Using Python:
```bash
cd frontend
python -m http.server 8000
# Open http://localhost:8000
```

Using Node.js:
```bash
cd frontend
npx serve
# Open the URL shown
```

Using VS Code:
```bash
# Install "Live Server" extension
# Right-click index.html → "Open with Live Server"
```

### Step 7: Use the dApp

1. Open the application in your browser
2. Click "Connect Petra Wallet"
3. Approve the connection
4. Start adding tasks!

## 📖 Smart Contract Functions

### Entry Functions (Require Signer)

```move
// Create a new task
public entry fun create_task(account: &signer, content: String)

// Mark a task as complete
public entry fun complete_task(account: &signer, task_id: u64)

// Initialize todo list (called automatically)
public entry fun create_list(account: &signer)
```

### View Functions (Read-Only)

```move
// Get all tasks for an account
#[view]
public fun get_tasks(account_addr: address): vector<Task>

// Get total task count
#[view]
public fun get_task_count(account_addr: address): u64
```

## 🧪 Testing

### Test Smart Contract Functions

```bash
# Create a task
aptos move run \
  --function-id YOUR_ADDRESS::todo_list::create_task \
  --args string:"Buy groceries"

# View tasks
aptos move view \
  --function-id YOUR_ADDRESS::todo_list::get_tasks \
  --args address:YOUR_ADDRESS

# Complete a task (task_id = 0 for first task)
aptos move run \
  --function-id YOUR_ADDRESS::todo_list::complete_task \
  --args u64:0
```

## 🔧 Configuration

### Network Configuration

To switch networks, update in both places:

**Contract** (`Move.toml`):
```toml
[dependencies.AptosFramework]
git = "https://github.com/aptos-labs/aptos-core.git"
rev = "mainnet"  # or "testnet", "devnet"
subdir = "aptos-move/framework/aptos-framework"
```

**Frontend** (`index.html`):
```javascript
const NODE_URL = "https://fullnode.devnet.aptoslabs.com/v1";
// For testnet: https://fullnode.testnet.aptoslabs.com/v1
// For mainnet: https://fullnode.mainnet.aptoslabs.com/v1
```

## 🐛 Troubleshooting

### Issue: "Petra Wallet not detected"

**Solution:**
1. Make sure Petra extension is installed and enabled
2. Check chrome://extensions/ and ensure Petra is active
3. Enable "Allow access to file URLs" for Petra extension
4. Refresh the page

### Issue: "Module not found" error

**Solution:**
1. Verify MODULE_ADDRESS in frontend matches deployed address
2. Ensure you're using the same account in Petra that deployed the contract
3. Confirm you're on the correct network (Devnet)

### Issue: "Simulation failed" error

**Solution:**
1. Make sure Petra account has sufficient APT tokens
2. Fund account: `aptos account fund-with-faucet --account default`
3. Verify the contract is deployed: `aptos account list`

### Issue: Compilation errors

**Solution:**
```bash
# Clean build directory
rm -rf build/  # Mac/Linux
Remove-Item -Recurse -Force build  # Windows

# Recompile
aptos move compile --skip-fetch-latest-git-deps
```

## 📚 Learn More

- [Aptos Documentation](https://aptos.dev/)
- [Move Language Book](https://move-language.github.io/move/)
- [Petra Wallet Docs](https://petra.app/docs)
- [Aptos Developer Discussions](https://github.com/aptos-labs/aptos-core/discussions)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Aptos Labs](https://aptoslabs.com/) for the amazing blockchain platform
- [Petra Wallet](https://petra.app/) for seamless wallet integration
- The Aptos developer community

## 📧 Contact

Your Name - [@yourtwitter](https://twitter.com/yourtwitter)

Project Link: [https://github.com/yourusername/aptos-todo-dapp](https://github.com/divya050524/aptos-todo-dapp)

---

⭐ If you found this project helpful, please give it a star!

## 🎯 Future Enhancements

- [ ] Delete tasks functionality
- [ ] Edit task content
- [ ] Task categories/tags
- [ ] Due dates for tasks
- [ ] Priority levels
- [ ] Share tasks between users
- [ ] Dark mode toggle
- [ ] Task statistics dashboard
- [ ] Export tasks to CSV
- [ ] Mobile responsive design improvements

## 📊 Project Status

**Current Version:** 1.0.0  
**Status:** ✅ Production Ready  
**Network:** Aptos Devnet  
**Last Updated:** November 2025
