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
diff -qr . "$REMOTE_REPO" | awk -v repo="$REMOTE_REPO" '/^Files .* differ$/ {print "Modified:", $2}'
diff -qr . "$REMOTE_REPO" | sed -n 's/Only in \.:\(.*\)/Added\1/p'
diff -qr . "$REMOTE_REPO" | sed -nE 's/Only in .{2,}:(.*)/Removed\1/p'



# Create a folder with a random name in ~/.bggit/.stor
value=$(date +%s | sha256sum | base64 | head -c 16)
mkdir -p ~/.bggit/.stor/$value

# Copy the current directory to the new folder in ~/.bggit/.stor
cp -r . ~/.bggit/.stor/$value
rm -r "$REMOTE_REPO"/*
cp -r . "$REMOTE_REPO"
echo "Date:"$(date)>>~/.bggit/.stor/log
echo "Commit : "$value>>~/.bggit/.stor/log
echo "Commit Message:"$1>>~/.bggit/.stor/log
echo "----------------------------------------------------------------" >>~/.bggit/.stor/log