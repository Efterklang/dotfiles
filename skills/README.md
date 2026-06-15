个人使用的 skills，运行 `just install-skill` 进行安装。

安装映射写在 `macOS_install_map.json`：

- key 是 skill 名称，需要和 `skills/<skill-name>` 目录一致。
- value 是安装目标列表。目标可以写项目根目录，脚本会安装到 `<target>/.agents/skills/<skill-name>`；也可以直接写 `.agents` 或 `skills` 目录。

默认安装方式是符号链接，让目标项目直接使用 dotfiles 里的 skill 源目录。需要复制实体目录时运行：

```bash
just install-skill --copy
```
