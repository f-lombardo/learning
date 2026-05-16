# Notes on Python

## Virtual environment

Create a virtual environment
```shell
python -m venv .venv
```

Activate a virtual environment

```shell
# On Windows Command Prompt
.venv\Scripts\activate.bat

# On Windows PowerShell
.venv\Scripts\Activate.ps1

# On Unix/Linux/MacOS
source .venv/bin/activate
```

Freeze requirements

```shell
pip freeze > requirements.txt
```

Here you can find a script for activating a virtual environment and install base requirements:

```bash
#!/bin/bash

python3 -m venv .venv
source .venv/bin/activate

#Suppose that base requirements.txt is in the same directory as the script, we copy it in the current project directory:
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
copy $SCRIPT_DIR/requirements.txt .

pip install -r requirements.txt
```
