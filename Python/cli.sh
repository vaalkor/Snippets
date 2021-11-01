python -m http.server 8000 # Run a basic http server in the current folder.

python -m venv /path/to/venv
./path/to/venv/scripts/activate # Activate venv on windows
source ./path/to/venv/bin/activate # Activate venv on linux
deactivate # To exist the venv

python -m pip install -r requirements.txt #Install requirements file.

# https://github.com/jazzband/pip-tools
python -m pip install pip-tools # Install pip-tools for proper computation of desired requirements file.

# Create a requirements.in file explicitely declaring your first level dependencies. 
# You can use exact versions or ranges like boto3==1.17.100 or boto3<1.18
# For example for an aws lambda 
boto3==1.17.100
botocore==1.20.100

# To create a requirements.txt file from the requirements.in file run
pip-compile requirements.in

# Commit both requirements.in and requirements.txt to source control.