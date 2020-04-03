load(
    "@build_bazel_rules_nodejs//:providers.bzl",
    "NpmPackageInfo",
    "DeclarationInfo",
    "JSNamedModuleInfo",
)

def _debug_impl(ctx):
    for dep in ctx.attr.deps:
        print(dep)
        print(dir(dep))
        print("output_groups", dep.output_groups)
        providers = [
            ("NpmPackageInfo", NpmPackageInfo),
            ("DeclarationInfo", DeclarationInfo),
            ("JSNamedModuleInfo", JSNamedModuleInfo),
            ("OutputGroupInfo", OutputGroupInfo),
        ]
        for (lbl, key) in providers:
            print(lbl, dep[key])

debug = rule(
    _debug_impl,
    attrs = {
        "deps": attr.label_list(),
    },
)

def _drop(path):
    if path.endswith(".amd.js"):
        return True
    elif path.endswith(".cjs.js"):
        return False
    elif path.endswith(".es.js"):
        return True
    elif path.endswith(".es.mjs"):
        return True
    elif path.endswith(".js"):
        return True
    else:
        return False

def _js_files_impl(ctx):
    npm_package_info = ctx.attr.dep[NpmPackageInfo]
    declaration_info = ctx.attr.dep[DeclarationInfo]
    js_named_module_info = ctx.attr.dep[JSNamedModuleInfo]
    return [
        NpmPackageInfo(
            direct_sources = depset(direct = [
                src
                for src in npm_package_info.direct_sources.to_list()
                if not _drop(src.path)
            ]),
            sources = depset(direct = [
                src
                for src in npm_package_info.sources.to_list()
                if not _drop(src.path)
            ]),
            workspace = npm_package_info.workspace,
        ),
        DeclarationInfo(
            declarations = declaration_info.declarations,
            transitive_declarations = declaration_info.transitive_declarations,
        ),
        JSNamedModuleInfo(
            direct_sources = depset(direct = [
                src
                for src in js_named_module_info.direct_sources.to_list()
                if not _drop(src.path)
            ]),
            sources = depset(direct = [
                src
                for src in js_named_module_info.sources.to_list()
                if not _drop(src.path)
            ]),
        ),
    ]

js_files = rule(
    _js_files_impl,
    attrs = {
        "dep": attr.label(),
    },
)
