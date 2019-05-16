# pursoul

[![Build Status](https://travis-ci.org/rockyCheung/pursoul.svg?branch=master)](https://travis-ci.org/rockyCheung/pursoul)

pursoul是一个知识分享系统，基于开源知识分享项目进行二次开发。使用到的技术：

* python3
* Jinja2
* Werkzeug
* Flask
* SQLAlchemy
* Flask-SQLAlchemy


# 安装说明

## 安装依赖包
	$./install.sh

## 初始化数据库
	$./init.sh

## 启动程序
	$./start.sh

# docker化

## 构建镜像
    $./build_docker.sh
## 启动容器
    $./start_docker.sh
    
# 特点:

- 编写文章
- 优秀的在线编辑器
- 支持markdown
- 使用标签管理文章
- 导入外部数据