GnuPG
=====

- http://www.ruanyifeng.com/blog/2013/07/gpg.html
- https://www.gnupg.org/howtos/zh/index.html


ID: E-Mail or Hash

生成密钥

    gpg --gen-key

列出本机上的密钥

    gpg --list-keys

删除公钥

    gpg --delete-key <ID>

删除私钥

    gpg --delete-secret-key <ID>

导出 ASCII 形式的公钥

    gpg --armor --output public-key.txt --export <ID>

生成指纹

    gpg --fingerprint <ID>

加密解密

    gpg --recipient <ID> --output demo.en.txt --encrypt demo.txt

    gpg --decrypt demo.en.txt --output demo.de.txt

签名

    # 为文件生成单独的签名
    gpg --detach-sign demo.txt

    # 生成单独的 ASCII 格式的签名
    gpg --armor --detach-sign demo.txt

    # 校验签名
    gpg --verify demo.txt.sig demo.txt
