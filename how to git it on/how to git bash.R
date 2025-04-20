
# Git bash

# basic commands
cd # change directory
ls #list content in working directory
pwd #print working directory



# set working directory
#open the folder of the working directory
#right click anywhere in the folder
#select 'Git Bash Here'



# go to your main branch and 2. merge the other branch to your main, then 3. move files into the directory you want, 4. commit 5. push


git checkout main
git merge other-branch
git mv * directory/
git commit -m "commit message"
git push origin main 



# check files in directory
ls


# if you changed github repo location such as transferring repo from personal to lab repo, how to update for github desktop and rstudio if you're having issues
cd '\path\to\repo'
#check repo location
git remote -v
# if it is showing your old repo github url, update it
git remote set-url origin new_url
#check again to see if it has been updated
git remote -v
# if github isnt recognizing the repo and still says cannot locate, check status, if repo is being recognized by git
git status
# if you see fatal: not a git repository, then need to reinitialize Git
git init
# add repo again manually
git remote add origin url_of_repo

# if it doesnt work, just clone the repo into like a subfolder, then copy and paste the new .git folder into the original repo folder to override the old git info (lol) then delete the subfolder