using MagicTensors
using Documenter

DocMeta.setdocmeta!(MagicTensors, :DocTestSetup, :(using MagicTensors); recursive=true)

makedocs(;
    modules=[MagicTensors],
    authors="Gerald E. Fux",
    sitename="MagicTensors.jl",
    format=Documenter.HTML(;
        canonical="https://gefux.github.io/MagicTensors.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/gefux/MagicTensors.jl",
    devbranch="main",
)
