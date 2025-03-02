# Notes Hugo Action

GitHub Action to transform my personal notes into [Hugo](https://gohugo.io/) content.

## What it does

It transform a tree structure into a flat one taking the parent folder for every `README.md`, copying the content except directories and, renaming the `README.md` into `index.md`

There is an example of the source structure:

```shell
└── notes
    ├── computer-sciences
    │   ├── formats
    │   │   └── html
    │   │       ├── intro.png
    │   │       └── README.md
    │   └── protocols
    │       └── grpc
    │           └── README.md
    ├── electrical-engineering
    │   └── bmp-180
    │       └── README.md
    └──...
```

and the output produced:

```shell
└── content
    ├── html
    │   ├── intro.png
    │   └── index.md
    ├── grpc
    │   └── index.md
    └── bmp-180
        └── index.md
```

## Example usage

```yaml
uses: alexandrelamberty/hugo-notes-action@master
with:
  source: 'notes'
  destination: 'content'
```
