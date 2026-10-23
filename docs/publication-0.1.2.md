# Launch SDK 0.1.2 publication

Target release: [Launch SDK v0.1.2](https://github.com/spf86/licentivo-launch-sdk/releases/tag/v0.1.2).

Status: **publication and public installation verification pending**. This record does not claim that the 0.1.2 registry packages or native downloads are available yet. Existing 0.1.1 verification receipts remain evidence only for 0.1.1 until replaced by results from the new public distributions.

Each 0.1.2 package embeds official Licentivo SDK 0.11.1 and the default Launch adapter. SDK 0.11.1 fixes C/C++ CMake consumption across curl config-package and FindCURL discovery modes by resolving the installed dependency through `CURL::libcurl`. Applications do not need to add compatibility aliases. Matching compiler, architecture and curl runtime/development dependencies remain required.

The licensing protocol and client API are unchanged. The other language packages share the new version and retain their existing behavior. Update the Launch package to 0.1.2 and rebuild; no separate official SDK installation or changes to account login, restore or feature guards are required.

The publication checklist covers Go Modules, PyPI, NuGet, Maven Central, npm, crates.io and RubyGems, plus C/C++ native archives on GitHub Releases. After publishing, install the exact public version in fresh consumers, verify package integrity and generated initialization, and record the result for each language. Native checks must include independent C and C++ consumers of the downloaded, relocated installation.

See [machine-readable status](registry-status.json), [installation evidence](registry-verification.json) and [manual integration](manual-integration.md). Public download and installation checks do not establish external merchant/payment/licensing acceptance.
