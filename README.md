# PDF Immersive Reader

> 轻量级 **沉浸式 PDF 学习阅读器**：选中即译 / 即读，**本地大模型优先**（LM Studio / Ollama 等兼容 OpenAI 格式），内置 **生词本**（本地存储），**零后端、纯前端**可部署（GitHub Pages 一键上线）。

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
![Static Badge](https://img.shields.io/badge/Zero%20Backend-Static%20Site-blue)
![Static Badge](https://img.shields.io/badge/Local%20LLM-Preferred-orange)

## 功能特性

- 🧭 **沉浸式全屏**：PDF 全屏阅读，同时固定显示右侧工具面板（选中文本、翻译、朗读、生词本）。
- 🖱️ **选中即显示**：在 PDF 中选中文本，右侧 `Selected Text` 自动同步。
- 🌐 **翻译双通道**：
  - 本地端点优先（OpenAI 兼容，比如 LM Studio / Ollama / OpenRouter 私服）。
  - 在线兜底（MyMemory 免费 API）。
- 🔊 **即时朗读**：Web Speech 语音合成，一键 Speak。
- 📒 **生词本**：本地存储（localStorage），支持计数、导入/导出（JSON）。
- 🧩 **零后端**：纯静态资源，GitHub Pages 即可部署。
- 🧰 **PDF.js 内置**：页面宽度自适应、自动关闭左侧目录栏。

## 预览

> 成品示意（建议在这放 2 张截图）  
> `docs/preview-immersive.png`  
> `docs/preview-sidepanel.png`

## 本地运行
