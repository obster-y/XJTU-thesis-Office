# XJTU-thesis-Office：西安交通大学学位论文模板-Office版 </br> XJTU-thesis-Office: An unofficial Office Degree Thesis Template for Xi'an Jiaotong University

[![](https://img.shields.io/badge/LPPL-LPPL-blue)](https://www.latex-project.org/lppl/)
[![](https://img.shields.io/github/last-commit/obster-y/XJTU-thesis-office)](https://github.com/obster-y/XJTU-thesis-office)
[![](https://img.shields.io/github/issues/obster-y/XJTU-thesis-office)](https://github.com/obster-y/XJTU-thesis-office/issues)

[本项目](https://github.com/obster-y/XJTU-thesis-office)为西安交通大学硕博学位论文的非官方 Microsoft-Word 模板（提供 .dotm），能够方便、自动地完成论文的写作与排版，且满足学校的要求。

[XJTU-thesis](https://github.com/obster-y/XJTU-thesis/tree/dev) 为一相关项目，为官方的基于 LaTeX 的硕博学位论文模板

参考标准为 [官方版本](http://gs.xjtu.edu.cn/info/1209/7605.htm)

考虑到原有 Word 模板的诸多问题，对其进行优化，可以方便的按照以后学校要求进行更新（或扩展到其他学校使用）。


本模板修改/添加了以下内容：
- 合并原有标题页的各个分支，简化了使用
- 将原有模板放置在正文中的部分要求移至批注，方便浏览、审核与确认
- 将英文标准翻译与编排顺序转换至文本文件
- 删除/隐藏与模板内容无关的样式，保留有用的样式
- 在页眉部分应用了域代码，确保页眉随一级标题自动更新
- 在目录部分应用了域代码，确保中英目录同时自动生成与更新
- 在公式部分提供了基于 ListNum 域代码的自动编号功能
- 在表格部分提供了符合要求的三线表表格样式，应用后可通过修改样式自动更新所有表格
- 嵌入了图、表、公式的自动图文集，方便插入、自动编号与交叉引用
- 附录部分的样式基于正文，可自动按大写拉丁字母顺序编号，同时保持样式与正文相同

本模板的 pack.bat 脚本提供了：
- 复制预设颜色与样式到默认路径，实现颜色与样式分发
- 修改 Normal.dotm 以实现交叉引用标签的分发（若已存在相关样式则不修改）
- 基于黑名单打包与定义在目录名称中的后缀打包文件

由于 Word 相关文件为二进制文件，为了通过 Github 进行版本控制，因此仓库中没有保留 .docx / .dotm 等文件。具体使用说明：
1. Clone/Pull/下载后解压 此仓库至某一路径
2. 运行「pack.bat」脚本，进行自动打包与预设颜色分发
3. 阅读生成的「使用说明.docx」
4. 打开模板，阅读批注，正常使用

**如果对模板使用或格式有相关问题，请先确保已仔细阅读了使用手册和相关说明及以前的 issues 后，再在 Github 上提交 issue，如果发现 bug，欢迎提交 PR。**

后续内容：
- 添加基于 Release 分发的选项
- 添加演示文稿模板

## 特别感谢
- 某不愿透露姓名的李同学：为模板的测试做了很多工作
- [gdutthesis-Word 项目](https://github.com/sikouhjw/gdutthesis-Word)
