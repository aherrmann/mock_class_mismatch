workspace(name = "repro", managed_directories = {"@npm": ["node_modules"]})

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = "c97bf38546c220fa250ff2cc052c1a9eac977c662c1fc23eda797b0ce8e70a43",
    urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/1.1.0/rules_nodejs-1.1.0.tar.gz"],
)

load("@build_bazel_rules_nodejs//:index.bzl", "node_repositories", "yarn_install")

node_repositories(
    package_json = ["//:package.json"],
    node_version = "13.7.0",
    node_repositories = {
      "13.7.0-linux_amd64": ("node-v13.7.0-linux-x64.tar.xz", "node-v13.7.0-linux-x64", "02578025b82de24f4cfb3ffeb3824990431d739d09220f2db9ef9f454f475470"),
    },
    node_urls = ["https://nodejs.org/dist/v{version}/{filename}"],
)

yarn_install(
    name = "npm",
    package_json = "//:package.json",
    yarn_lock = "//:yarn.lock",
)

load("@npm//:install_bazel_dependencies.bzl", "install_bazel_dependencies")

install_bazel_dependencies()
