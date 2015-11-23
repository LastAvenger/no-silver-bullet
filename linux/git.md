#### 永久忽略一个对已 commit 文件/目录 的修改

    git update-index --assume-unchanged xxx

#### 撤销本地 commit
**注意做好备份！**

    git reset --hard <commit_id>

#### 撤销已 push 到远程的 commit
**注意做好备份！**

    git reset --hard <commit_id>
    git push origin HEAD --force

#### 修改最后一次提交

    git commit --amend

#### 中文路径乱码

    git config core.quotepath false
