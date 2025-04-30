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