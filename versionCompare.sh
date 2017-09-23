# parameters
# @git_clone_url @npm_name
# tmp1 is for git
# tmp2 is for npm

git clone $1
git_dir=$(echo $1 | awk '{split($1, Arr, /[/]/); print Arr[length(Arr)]}')
cd $git_dir
git tag > tmp1.txt
mv tmp1.txt ../
cd ../

# Whether npm package name is the same as git repo
if [ $# -eq 2 ]; then
  npm show $2 versions > tmp2.txt
else
  npm show $git_dir versions > tmp2.txt
fi

# count lines of the result of npm show
lines=$(wc -l tmp2.txt | awk '{print $1}')
# Elimate spare symbols and let the result be the same as $(git tag)
sed -i "s/v//" tmp1.txt
sed -i "s/\[//" tmp2.txt
sed -i "s/\]//" tmp2.txt

if [ $lines != 1 ]; then
  sed -i "s/,//" tmp2.txt
else
  sed -i "s/,/\n/" tmp2.txt
fi

sed -i "s/'//" tmp2.txt
sed -i "s/'//" tmp2.txt
sed -i "s/\ //" tmp2.txt
sed -i "s/\ //" tmp2.txt

# Go compare
vimdiff tmp1.txt tmp2.txt
# Remove all temporary files and folders.
rm $git_dir tmp1.txt tmp2.txt -rf
