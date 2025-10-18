#!/usr/bin/env python3
"""
统一的dotfiles安装脚本
自动检测操作系统并直接调用dotbot
"""

import platform
import subprocess
import sys
from pathlib import Path

# color codes
COLOR_INFO = "\033[38;2;166;227;161m"  # #a6e3a1
COLOR_ERROR = "\033[38;2;243;139;168m"  # #f38ba8
COLOR_WARNING = "\033[93m"  # yellow
COLOR_RESET = "\033[0m"


def get_script_dir():
    """获取脚本所在目录"""
    return Path(__file__).parent.absolute()


def run_command(cmd, shell=False, cwd=None):
    """运行命令并处理错误"""
    try:
        if isinstance(cmd, list):
            print(
                f"{COLOR_INFO}[INFO]{COLOR_RESET} Executing: {' '.join(str(c) for c in cmd)}"
            )
        else:
            print(f"{COLOR_INFO}[INFO]{COLOR_RESET} Executing: {cmd}")

        result = subprocess.run(
            cmd, shell=shell, check=True, cwd=cwd or get_script_dir()
        )
        return result.returncode == 0
    except subprocess.CalledProcessError as e:
        print(
            f"{COLOR_ERROR}[ERROR]{COLOR_RESET} Command failed (return code: {e.returncode}): {e}"
        )
        return False
    except FileNotFoundError:
        print(
            f"{COLOR_ERROR}[ERROR]{COLOR_RESET} Command not found: {cmd[0] if isinstance(cmd, list) else cmd}"
        )
        return False


def sync_git_submodules():
    """同步和更新git子模块"""
    print(f"{COLOR_INFO}[INFO]{COLOR_RESET} Syncing git submodules...")

    base_dir = get_script_dir()
    dotbot_dir = base_dir / ".dotbot"

    # 同步子模块
    cmd1 = ["git", "-C", str(dotbot_dir), "submodule", "sync", "--quiet", "--recursive"]
    if not run_command(cmd1):
        print(f"{COLOR_WARNING}[WARNING]{COLOR_RESET} Git submodule sync failed")
        return False

    # 更新子模块
    cmd2 = ["git", "submodule", "update", "--init", "--recursive", str(dotbot_dir)]
    if not run_command(cmd2):
        print(f"{COLOR_WARNING}[WARNING]{COLOR_RESET} Git submodule update failed")
        return False

    return True


def find_python():
    """查找可用的Python解释器"""
    python_commands = ["python3", "python", "python2"]

    for cmd in python_commands:
        try:
            result = subprocess.run(
                [cmd, "-V"], capture_output=True, text=True, check=True
            )
            if result.returncode == 0:
                print(
                    f"{COLOR_INFO}[INFO]{COLOR_RESET} Found Python interpreter: {cmd}"
                )
                return cmd
        except (subprocess.CalledProcessError, FileNotFoundError):
            continue

    return None


def run_dotbot(config_file):
    """运行dotbot安装"""
    base_dir = get_script_dir()
    dotbot_dir = base_dir / ".dotbot"
    dotbot_bin = dotbot_dir / "bin" / "dotbot"

    if not dotbot_bin.exists():
        print(
            f"{COLOR_ERROR}[ERROR]{COLOR_RESET} dotbot executable not found: {dotbot_bin}"
        )
        return False

    # 查找Python解释器
    python_cmd = find_python()
    if not python_cmd:
        print(f"{COLOR_ERROR}[ERROR]{COLOR_RESET} Python interpreter not found")
        return False

    # 构建dotbot命令
    cmd = [
        python_cmd,
        str(dotbot_bin),
        "-d",
        str(base_dir),
        "-c",
        config_file,
    ] + sys.argv[1:]  # 传递所有命令行参数

    return run_command(cmd)


def install_unix():
    # 同步git子模块
    if not sync_git_submodules():
        return False

    # 运行dotbot
    return run_dotbot("install.conf.yaml")


def main():
    """主函数"""
    print(f"{COLOR_INFO}[INFO]{COLOR_RESET} Unified dotfiles installer")
    print(f"{COLOR_INFO}[INFO]{COLOR_RESET} " + "=" * 40)

    # 检测操作系统
    system = platform.system().lower()
    print(f"{COLOR_INFO}[INFO]{COLOR_RESET} Detected operating system: {system}")

    success = install_unix()

    if success:
        print(f"{COLOR_INFO}[INFO]{COLOR_RESET} Installation completed successfully!")
    else:
        print(f"{COLOR_ERROR}[ERROR]{COLOR_RESET} Installation failed!")
        sys.exit(1)


if __name__ == "__main__":
    main()

