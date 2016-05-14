#bin/bash
echo "修改内容为:"$1
git stage *
git commit -m $1
git push
