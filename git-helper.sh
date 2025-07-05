RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Reset

echo -e "${GREEN}Git Helper Script${NC}"


echo -e "${YELLOW}Checking Git status...${NC}"
git status


read -p "Do you want to add all changes (y/n)? " add_all
if [ "$add_all" == "y" ]; then
  git add .
  echo -e "${GREEN} Added all changes${NC}"
else
  echo -e "${YELLOW} Skipped adding files${NC}"
fi


if git diff --cached --quiet; then
  echo -e "${RED}  No staged changes to commit.${NC}"
else
  read -p "Enter commit message: " commit_msg
  git commit -m "$commit_msg"
  echo -e "${GREEN} Committed changes.${NC}"
fi


read -p "Do you want to push the current branch? (y/n) " push
if [ "$push" == "y" ]; then
  current_branch=$(git branch --show-current)
  git push origin "$current_branch"
  echo -e "${GREEN} Successfully pushed to branch: $current_branch${NC}"
else 
  echo -e "${YELLOW} Skipped push${NC}"
fi


read -p "Do you want to pull the latest changes from remote? (y/n) " pull
if [ "$pull" == "y" ]; then
  current_branch=$(git branch --show-current)
  git pull origin "$current_branch"
  echo -e "${GREEN} Pulled latest changes from branch: $current_branch${NC}"
else
  echo -e "${YELLOW} Skipped pull${NC}"
fi


read -p "Do you want to create or switch to a branch? (y/n) " branch_option
if [ "$branch_option" == "y" ]; then
  read -p "Enter branch name: " branch_name

  if git show-ref --verify --quiet refs/heads/"$branch_name"; then
    git checkout "$branch_name"
    echo -e "${GREEN} Switched to existing branch: $branch_name${NC}"
  else 
    git checkout -b "$branch_name"
    echo -e "${GREEN} Created and switched to new branch: $branch_name${NC}"
  fi
else
  echo -e "${YELLOW} Skipped branch switch/creation${NC}"
fi

read -p " Do you want to view the Git log? (y/n): " view_log 
if [ "$view_log" == "y" ]; then
  echo -e "${YELLOW} Git Commit History:${NC}" 
  git log --oneline --graph --decorate --all
else
  echo -e "${YELLOW} Skipped Git log viewer.${NC}" 
fi
