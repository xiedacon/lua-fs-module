# lua-fs-module

[![MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/xiedacon/lua-fs-module/blob/master/LICENSE)

## API

* fs.read
* fs.readFile
* fs.readdir
* fs.write
* fs.writeFile
* fs.appendToFile
* fs.exists
* fs.copy
* fs.move
* fs.mkdir
* fs.rmdir
* fs.unlink
* fs.rm
* fs.remove
* fs.rmAll
* fs.removeAll
* fs.chown
* fs.chmod
* fs.isDir
* fs.isFile

## Usage

```lua
local fs = require "fs"

local content, err = fs.read(fileOrDir)
-- 读取目标为文件时，content 为文件内容
-- 读取目标为目录时，content 为 { "a.txt", "b.txt" }

local content, err = fs.readFile(file)
local files, err = fs.readdir(dir, n)
-- files: ``{ "a.txt", "b.txt" }``
-- n: 重试次数，默认 3 次

local ok, err = fs.write(file, content)
local ok, err = fs.writeFile(file, content)
local ok, err = fs.appendToFile(file, content)
local exists = fs.exists(file)
local ok, err = fs.copy(file1, file2)
local ok, err = fs.move(fileOrDir1, fileOrDir2)
local ok, err = fs.mkdir(dir)
local ok, err = fs.rmdir(dir)
local ok, err = fs.unlink(file)
local ok, err = fs.rm(file)
local ok, err = fs.remove(file)
local ok, err = fs.rmAll(fileOrDir)
local ok, err = fs.removeAll(fileOrDir)
local ok, err = fs.chown(fileOrDir, user)
local ok, err = fs.chmod(fileOrDir, 777)
local yes = fs.isDir(dir)
local yes = fs.isFile(file)
```

## License

[MIT License](https://github.com/xiedacon/lua-fs-module/blob/master/LICENSE)

Copyright (c) 2018 xiedacon