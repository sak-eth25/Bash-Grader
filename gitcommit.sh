if [ -f ~/.bggit/remote_repo ]; then
    REMOTE_REPO=$(cat ~/.bggit/remote_repo)
    
else
    echo "git not initialised"
    return
fi
#$1 is the commit message

if [ -z "$1" ]; then
    echo "Error: Please provide a commit message."
    exit
fi


#Print the files that are modified
diff -qr . "$REMOTE_REPO" | awk -v repo="$REMOTE_REPO" '/^Only in .:/ {print "Removed:", $3} /^Only in "repo":/ {print "Added:", $3} /^Files .* differ$/ {print "Modified:", $2}'


# Create a folder with a random name in ~/.bggit/.stor
value=$(date +%s | sha256sum | base64 | head -c 16)
mkdir -p ~/.bggit/.stor/$value

# Copy the current directory to the new folder in ~/.bggit/.stor
cp -r . ~/.bggit/.stor/$value
cp -r . "$REMOTE_REPO"
echo "Date:"$(date)>>~/.bggit/.stor/log
echo "Commit : "$value>>~/.bggit/.stor/log
echo "Commit Message:"$1>>~/.bggit/.stor/log
echo "----------------------------------------------------------------" >>~/.bggit/.stor/log
    exit
fi

value=$(date +%s | sha256sum | base64 | head -c 16)

#create a folder with name as value of value in REMOTE_REPO/.stor
mkdir $REMOTE_REPO/.stor/$value
cp -r . "$REMOTE_REPO/.stor/$value"
cp -r . "$REMOTE_REPO"
echo "Date:"$(date)>>$REMOTE_REPO/.stor/log
echo "value:"$value>>$REMOTE_REPO/.stor/log
echo "Commit Message"$1>>$REMOTE_REPO/.stor/log
echo "-----------------------------------------" >>$REMOTE_REPO/.stor/log
