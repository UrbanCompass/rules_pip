PYTHON_COPTS = [
    %{CFLAGS}
]

PYTHON_LINKOPTS = [
    %{LDFLAGS}
]

EXTENSION_SUFFIX = "%{EXTENSION_SUFFIX}"

fPIC = "-fPIC"

def py_extension(name, **kwargs):
    copts = kwargs.pop("copts", [])
    copts += PYTHON_COPTS
    if fPIC not in copts:
        copts.append(fPIC)

    linkshared = kwargs.pop("linkshared", True)
    linkstatic = kwargs.pop("linkstatic", True)
    linkopts = kwargs.pop("linkopts", [])
    deps = kwargs.pop("deps", [])
    extension_name = name + EXTENSION_SUFFIX
    native.cc_binary(
        name = extension_name,
        copts = copts,
        deps = deps + [
            "@%{CPYTHON}//:headers",
        ],
        linkshared = linkshared,
        linkstatic = linkstatic,
        **kwargs
    )
    return extension_name
