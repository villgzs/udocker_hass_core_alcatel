## Installing Home Assistant Core on Android: Simple and Fast, No Root, No QEMU

Got an old Android phone and don’t want to buy a Raspberry Pi or a PC to host Home Assistant? This tutorial is for you!

**Requirements: Android Phone – No Root Required**

**Credit: Special thanks to [George-Seven for the Termux-Udocker repository](https://github.com/George-Seven/Termux-Udocker).**

---

### Step 1: Install the Termux app from F-Droid.org

**Note:**
- Although Termux is also available on the Play Store, according to the Termux developers, the version on F-Droid is the most stable.
- After installing Termux, it is recommended, though not required, to install OpenSSH and enable remote access from a PC for easier interaction with the Termux Terminal. For details on setting up Termux remote access. See more: [Termux Remote Access Guide](https://wiki.termux.com/wiki/Remote_Access).

### Step 2: Install Git in Termux:

```bash
# Update & Upgrade Termux packages
pkg update && pkg upgrade

# Install git
pkg install git
```

### Step 3: Install HomeAssistant-Termux

Clone  HomeAssistant-Termux:
```bash
git clone https://github.com/huytungst/HomeAssistant-Termux.git
```

Go to the root directory of HomeAssistant-Termux:

```bash
cd HomeAssistant-Termux
```

Install Udocker from the cloned repository:

```bash
./install_udocker.sh
```

Run the script `home-assistant-core.sh`:

```bash
./home-assistant-core.sh
```

## Wait about 10 minutes, then you can access Home Assistant on port 8123 (http://localhost:8123/)

**Also, you can install and run the Python Matter Server to enable Matter compatibility.**


> **Note:** To keep both containers (Home Assistant Core and Python Matter Server) running at the same time, start each one in a separate Termux session. Two easy ways are either opening two Termux terminal sessions (using the Termux GUI) or using the `screen` command. [See more](#tips-running-multiple-containers-simultaneously)



Run the script `matter-server.sh`:

```bash
./matter-server.sh
```
Then, enable the Matter Integration in Home Assistant and connect them using the WebSocket URL:
```bash
ws://localhost:5580/ws
```


### Tips: Running Multiple Containers Simultaneously

To keep both containers (Home Assistant Core and Python Matter Server) running at the same time, start each one in a separate Termux session. Two easy ways are either opening two Termux terminal sessions (using the Termux GUI) or using the `screen` command.


#### Option 1: Using Termux GUI
1. Open Termux.
2. Start the first container in the initial Termux session.
3. Open a new Termux session by swiping from the left edge to open the drawer, then selecting **New Session**.
4. In this new session, start the second container.

#### Option 2: Using `screen`
If you prefer to use `screen` to manage multiple sessions in a single Termux window:
1. Open Termux and install `screen` if you haven't already:
   ```bash
   pkg install screen
   ```
2. Start `screen` and create a new session:
   ```bash
   screen -S container1
   ```
3. Start the first container in this `screen` session.
4. To create a new screen session, detach from the current session by pressing `Ctrl + A` followed by `D`.
5. Start a new session for the second container:
   ```bash
   screen -S container2
   ```
6. Start the second container in this new session.
7. To switch between sessions, use:
   ```bash
   screen -r container1  # For the first container
   screen -r container2  # For the second container
   ```


This completes the setup for running Home Assistant Core and the Matter Server on Android without root.

### ‼️ Known Issue: Home Assistant setup failed for some dependencies, including 'bluetooth,' 'usb,' 'zeroconf,' etc. 🤖🔧 Any help would be appreciated! 🙏