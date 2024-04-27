# Check if a path is provided to initialize the remote repository
if [ -z "$1" ]; then
    echo "Error: Please provide a path to initialize the remote repository."
    exit
fi


#check if the directory exists
if [ ! -d "$1" ]; then
  mkdir "$1"  
fi

# Store the remote repository path in a variable
REMOTE_REPO="$1"


# Check if the.bggit directory already exists
if [ -d ~/.bggit ]; then
    # If the.bggit directory exists, inform the user that the remote repository is already initialized
    echo "Remote repository already initialized"
else
    # If the.bggit directory does not exist, create it and initialize the Git repository
    mkdir -p ~/.bggit/.stor
    # Create an empty log file in the.stor directory
    touch ~/.bggit/.stor/log
    # Inform the user that the Git repository has been initialized in the provided path
    echo "Initialized Git repository in $1"
fi

# Save the remote repository path to a file for future reference
echo "$1" > ~/.bggit/remote_repo
