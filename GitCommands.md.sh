# Git Commands Useful for day-to-day use 
# *****************      Clone Repository: ***************** 
git clone <remoteurl>
git clone --single-branch --branch-name <branch-name> <remoteurl>


# ******************  Add Files/ Stage Files and Commit Files  *****************
git add .
git add -A
git commit -m "Comments"

# ****************** Push Files  ******************************************************
git push origin main
git pull origin <feature-branch-name>

# ****************** Show Remote Origin URL /Name    ******************************************************
git remote -v
git remote show
git remote show ADO-Demo
# ****************** Check Current Branch  Status     ******************************************************
git status

# ****************** Fetch and Reset   hard to Origin/Sync with Origin   ******************************************************
git fetch --all
git reset --hard origin/main  # Replace 'main' with the correct branch name

git clean -df

# ****************** Save Unstaged Files locally for later retreival     ******************************************************
git stash push -m "Saving specific files" -- path/to/file1 path/to/file2
git stash
git stash -u

git stash --list
git stash list
git stash apply stash@{n}
git stash pop
git stash apply --index 0
git stash apply --index 0

# ******************  Switch or Checkout to different Branch  ******************************************
git switch <branchname>
# ******************  Merge from Differnmt Branch  ******************************************
# merge from origin
git merge origin/main 
# merge from local
git merge main

# ****************** Create a new branch locally:******************************************
git branch <name of branch >

# ****************** Rename a branch ******************************************
# First, switch to the branch you want to rename then type
# If you are on the branch you want to rename:
git branch -m new-branch-name

#*****If you want to rename a branch you’re not currently on:******************************************
git branch -m old-branch-name new-branch-name
#***** (create if it doesn't exist)******************************************
git checkout -b new-branch 
# **** Since the branch is not on the remote yet, you don’t need to worry about pushing or deleting anything.
# ***8When you’re ready to share it, push it up:
git push -u origin new-branch
#*******
#**** If it says an error like "fatal: 'origin' does not appear to be a git repository
#****fatal: Could not read from remote repository.
#****Please make sure you have the correct access rights and the repository exists."
#******************** Add or Re add Remote Origin to exisiting Local branch  
git remote add origin <git remot url>
#For example
git remote add origin https://dev.azure.com/phegde2013/TestAz ... feature_01_02

#******************** To remove origin ********************

# Here’s the clean workflow to merge the contents of `main` into a new branch that only exists locally:
### 🛠 Steps
#1. **Create and switch to the new branch**
git checkout -b new-branch

#2. **Merge `main` into it**
git merge main
#- If you created the branch from `main`, this will usually be a **fast-forward** (no conflicts).
#- If you created it from another branch, this will bring in all changes from `main`.
#3. **Verify the merge**
git log --oneline --graph --decorate
#This shows the commit history so you can confirm that `main`’s commits are now part of `new-branch`.
### ⚠️ Notes
#- Since the branch is **not on the remote yet**, you don’t need to worry about pushing or deleting anything.
#- When you’re ready to share it, push it up:
#```bash
git push -u origin new-branch



