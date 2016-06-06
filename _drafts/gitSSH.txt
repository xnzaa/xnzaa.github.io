git config --global user.name "xnzaa"
git config --global user.email "xu649981201@163.com"


ssh-keygen -t rsa -C "xu649981201@163.com"


添加生成的 SSH key 到 ssh-agent。
ssh-add ~/.ssh/id_rsa

ssh -T git@github.com


参考：https://segmentfault.com/a/1190000002645623