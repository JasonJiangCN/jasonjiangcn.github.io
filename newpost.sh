echo Please enter the title of new post
read TITLE
echo "Creating new post named $TITLE"
hexo new $TITLE
open source/_posts/$TITLE.md

exit 0
