# AI 快速接入

后台 **运营工具 → AI 快速接入** 为你的 AI 编程工具生成接入任务说明。它根据项目选择引用现有接入包与示例，要求生成的代码继续通过官方 Licentivo SDK 检查运行权限。

程序接入页的“接入检查与代码 / AI 快速接入”导航也可切换到这里。

生成的提示词统一使用英文，包括标题、正文、命令注释和配置说明。项目说明也请使用英文填写；Launch 不会自动翻译或向翻译服务发送内容。

## 在后台使用

1. 选择 Go、Python、C#、Java、JavaScript / Node.js、Rust、Ruby、C 或 C++。Web 后端方案使用 Go，不另算一种 SDK 语言。
2. 选择目标平台和桌面、Web 或后台服务项目，用英文填写已有项目说明及受保护功能名，例如 `export`。
3. 尚未配置软件产品时，先生成**未配置草稿**。草稿包含待填写项，不能当作已经检查通过的配置。
4. 选择已有软件和环境。生成时，Launch 自动读取当前实例的有效公开地址、已发布套餐对应的产品映射，以及 Licentivo 的签名公钥；英文提示词会附上参数已填写的直接初始化函数，无需手填两个内部产品 ID，也无需生成配置文件。
5. 阅读预览，复制或下载提示词，然后主动交给你自己的 AI 编程工具。要求工具检查项目现有代码、只安装对应语言的 Launch 包、通过 Connect/connect 直接初始化，并运行接入测试。

Launch 只生成文本，不自动连接 AI 服务、上传项目或替你运行生成的程序。公开配置只含商户来源、产品映射、环境和 SDK 公钥等公开信息；登录会话、密码、授权码、设备凭据、管理密钥及支付密钥不能进入提示词。项目说明也应只填写公开的技术背景。

草稿或公开配置检查通过都不代表购买、激活或离线授权已经验收。AI 生成的代码仍需遵守登录、恢复、功能检查、退出账号和设备释放的生命周期，并按 [接入包说明](integration-packages.md) 与 [验收流程](acceptance.md) 测试。

手动开发无需 AI，完整安装、初始化、登录和功能保护示例见 [9 种语言手动开发指南](manual-integration.md)。接入页也能直接复制初始化代码。

## 在源码分发包中使用

`licentivo-launch-0.1.1-source.zip` 保留以下文件，便于在自己的工具中生成相同的提示词：

- `internal/httpapi/web/integration-prompts.js`：不依赖页面或服务端的提示词生成模块。
- `scripts/integration-prompts.test.mjs`：本地 Node 测试。
- `internal/httpapi/web/integration-state.js` 和 `scripts/integration-state.test.mjs`：配置草稿隔离及旧验证结果清理工具和测试。
- 本指南、各语言接入包、示例和验收说明。

模块导出 `integrationTargets` 和 `buildIntegrationPrompt(options)`。选项包括 `language`、`appKind`、`platform`、`projectNotes`、`feature` 、当前实例的 `merchantOrigin`、`environment` 及已验证的 `report`，返回 `{ text, ready, title, code }`。不提供 `report` 时生成草稿；只有符合字段白名单、语言与公开配置校验条件的报告才能生成已配置结果。不要为了跳过检查而手工把报告标记为通过。

在支持 ES 模块的页面或开发工具中导入该模块即可使用。源码包本身不包含完整后台页面；后台导航需要运行 Launch 服务。也可以从源码包根目录用 Node.js 生成一份本地草稿（PowerShell 示例）：

```powershell
@'
import { readFile, writeFile } from 'node:fs/promises';
const source = await readFile('internal/httpapi/web/integration-prompts.js', 'utf8');
const { buildIntegrationPrompt } = await import(
  'data:text/javascript;base64,' + Buffer.from(source).toString('base64')
);
const prompt = buildIntegrationPrompt({
  language: 'python',
  appKind: 'desktop',
  platform: 'windows',
  projectNotes: 'Existing Python desktop application. Add account sign-in and protect report exports.',
  feature: 'export'
});
await writeFile('integration-prompt.md', prompt.text, 'utf8');
console.log(prompt.title);
'@ | node --input-type=module
```

这里的本地命令只生成草稿。真实接入请在自己的 Launch 实例选择已有软件并重新生成，站点和产品参数会自动填入。该命令只使用本地模块并写入本地文件，不调用 AI 或授权服务。它显式载入 ES 模块，不要求更改现有项目的 `package.json`。

从解压后的源码包根目录验证生成器：

```powershell
node --test scripts/integration-prompts.test.mjs scripts/integration-state.test.mjs
```
