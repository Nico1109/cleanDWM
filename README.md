# CleanDWM

A complete, minimalist desktop setup based on the Dynamic Window Manager (DWM) with custom configurations and utility scripts.

## About the Project

This repository contains a complete DWM environment with:

- **DWM** - The Dynamic Window Manager with custom patches and configurations
- **dmenu** - A minimalist application launcher
- **dwmblocks** - A modular statusbar for DWM
- **Scripts** - Utility scripts for system information in the statusbar (IP, Battery, Volume, etc.)

The setup is designed to provide a clean, functional, and customizable desktop environment.

## Installation

### Prerequisites

Make sure the following packages are installed:
- `build-essential` / `base-devel`
- `libx11-dev` / `libx11`
- `libxft-dev` / `libxft`
- `libxinerama-dev` / `libxinerama`

**Important**: The scripts in the `scrips/` folder require specific programs to be installed. Please refer to the [`scrips/README.md`](scrips/README.md) for detailed dependency information.

### Step 1: Clone Repository

```bash
git clone https://github.com/Nico1109/cleanDWM.git
cd cleanDWM
```

### Step 2: Adjust Paths in dwmblocks

Edit the files `dwmblocks/blocks.def.h` and `dwmblocks/blocks.h` and adjust the script paths to your installation:

```bash
# Replace "/home/nico/repo/cleanDWM" with your actual path
sed -i 's|/home/nico/repo/cleanDWM|/path/to/your/cleanDWM|g' dwmblocks/blocks.def.h
sed -i 's|/home/nico/repo/cleanDWM|/path/to/your/cleanDWM|g' dwmblocks/blocks.h
```

### Step 3: Compile and Install

Install all components in the correct order:

```bash
# Install dmenu
cd dmenu
sudo make clean install
cd ..

# Install dwm
cd dwm
sudo make clean install
cd ..

# Install dwmblocks
cd dwmblocks
sudo make clean install
cd ..
```

### Step 4: Make Scripts Executable

```bash
chmod +x scrips/*.sh
```

### Step 5: Start DWM

Add DWM to your display manager or start it via `.xinitrc`:

```bash

echo "exec dwmblocks" >> ~/.xinitrc
echo "exec dwm" >> ~/.xinitrc
```

## Components

### DWM Features
- Movestack Patch - Move windows in the stack
- Vanitygaps - Customizable gaps between windows
- Always Center - Floating windows are centered
- Status Colors - Colored statusbar
- Hide Vacant Tags - Hides empty tags

### Statusbar Scripts
- **name.sh** - Shows hostname
- **ip.sh** - Shows current IP address
- **display.sh** - Shows display information
- **mic.sh** - Shows microphone status
- **volume.sh** - Shows volume level
- **battery.sh** - Shows battery level
- **dateTime.sh** - Shows date and time

## Customization

### Keybindings and Appearance
Edit `dwm/config.h` for custom keybindings and colors.

### Statusbar Modules
Edit `dwmblocks/blocks.def.h` to add, remove, or change update intervals for modules.

### Scripts
The scripts in `scrips/` can be customized or extended as needed.

## Troubleshooting

### dwmblocks shows no data
- Check if the script paths in `blocks.def.h` are correct
- Make sure the scripts are executable (`chmod +x scrips/*.sh`)
- Verify that all required dependencies for the scripts are installed (see [`scrips/README.md`](scrips/README.md))

### Compilation errors
- Install all required development packages
- Check if X11 development headers are installed

## License

This project uses the MIT License. See the LICENSE files in the respective subdirectories for details.
