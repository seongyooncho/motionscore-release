# MotionScore Installer

This script installs and sets up **MotionScore**, a motion evaluation application.

## 📦 What It Does

The script performs the following actions:

1. **Installs Homebrew** (if not already installed)
2. **Installs required packages** via Homebrew:
   - `qt`
   - `opencv`
   - `gdown`
   - `tmate`
3. **Downloads a MotionScore release archive** from Google Drive using a provided FILE ID
4. **Extracts** the archive to your home directory
5. **Configures passwordless `sudo`** for launching `MotionScore`

## ⚙️ Requirements

- macOS
- Internet connection
- Google Drive `FILE ID` of the `.tar.gz` archive
- Script must be run from **Terminal**

## 🛠 Usage

Open your Terminal and run the following command, replacing `<FILE_ID>` with your Google Drive file ID:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/seongyooncho/motionscore-release/refs/heads/main/install_motionscore.sh) <FILE_ID>
```

For example:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/seongyooncho/motionscore-release/refs/heads/main/install_motionscore.sh) 1AbCdEFGhiJKlmnoPQRstuvWXyZ
```

## 🚀 After Installation

You can now launch the program with:

```bash
sudo ~/MotionScore/MotionScore
```

You won’t be prompted for a password thanks to the automatic `sudoers` configuration.

## 🗒 Notes

- The script automatically detects your username and home directory.
- If `MotionScore` is already present in your home directory, it **will be overwritten**.
- If a sudoers rule already exists, it will not be duplicated.

---
