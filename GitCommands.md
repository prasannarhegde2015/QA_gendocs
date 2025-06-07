# Git Commands Useful for day to day use 

git clone <remoteurl>
git clone --single-branch --branch-name <branch-name> <remoteurl>

git add .
git add -A
git commit -m "Comments"
git push origin main
git pull origin main
git remote -v

git status


git fetch --all
git reset --hard origin/main  # Replace 'main' with the correct branch name

git clean -df


git stash push -m "Saving specific files" -- path/to/file1 path/to/file2

git stash list

git stash apply stash@{n}

git stash pop
