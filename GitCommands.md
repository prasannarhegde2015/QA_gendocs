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




git remote show
git remote show ADO-Demo
git status
git pull origin main
git add *
git commit -m " commit message"
git push origin

git switch <branchname>
git merge origin/main

git stash
git stash -u

git stash --list
git stash apply --index 0
git stash apply --index 0
Top
phegde
Site Admin
Posts: 458
Joined: Sat Jan 19, 2008 10:23 pm
Location: Mumbai
Contact: Contact phegde
Re: Git Commands
Post by phegde » Sat Aug 29, 2026 9:16 pm

Create a new branch locally:

git branch <name of branch >

Rename a branch
First, switch to the branch you want to rename
then type

If you are on the branch you want to rename:
git branch -m new-branch-name

If you want to rename a branch you’re not currently on:
git branch -m old-branch-name new-branch-name


git checkout -b new-branch (create if it doesn't exist)

git merge main (merge from local)


Since the branch is not on the remote yet, you don’t need to worry about pushing or deleting anything.

When you’re ready to share it, push it up:
git push -u origin new-branch

If it says an error like "fatal: 'origin' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists."
git remote add origin <git remot url>
For example
git remote add origin https://dev.azure.com/phegde2013/TestAz ... ture_01_02

To remove origin
git remote remove origin
Top
phegde
Site Admin
Posts: 458
Joined: Sat Jan 19, 2008 10:23 pm
Location: Mumbai
Contact: Contact phegde
Re: Git Commands
Post by phegde » Sat Aug 29, 2026 9:16 pm

Here’s the clean workflow to merge the contents of `main` into a new branch that only exists locally:

---

### 🛠 Steps

1. **Create and switch to the new branch**
```bash
git checkout -b new-branch
```
This makes a new branch (`new-branch`) from your current branch (likely `main`).

2. **Merge `main` into it**
```bash
git merge main
```
- If you created the branch from `main`, this will usually be a **fast-forward** (no conflicts).
- If you created it from another branch, this will bring in all changes from `main`.

3. **Verify the merge**
```bash
git log --oneline --graph --decorate
```
This shows the commit history so you can confirm that `main`’s commits are now part of `new-branch`.

---

### ⚠️ Notes
- Since the branch is **not on the remote yet**, you don’t need to worry about pushing or deleting anything.
- When you’re ready to share it, push it up:
```bash
git push -u origin new-branch
```

---


git stash list

git stash apply stash@{n}

git stash pop
