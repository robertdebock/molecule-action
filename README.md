# Molecule action

A GitHub action to tests your [Ansible](https://www.ansible.com/) role using [Molecule](https://molecule.readthedocs.io/en/stable/).

## Requirements

This action expects the following (default Ansible role) structure:
```
.
├── defaults
│   └── main.yml
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── molecule
│   └── default
│       ├── molecule.yml
│       ├── playbook.yml
│       └── prepare.yml
├── requirements.yml
├── tasks
│   └── main.yml
├── tox.ini # OPTIONAL
└── vars
    └── main.yml
```

If you are missing the `molecule` directory, please have a look at this [skeleton role](https://github.com/robertdebock/ansible-role-skeleton) or one of the many examples listed on [my website](https://robertdebock.nl/).

When `tox.ini` is found, [tox](https://tox.readthedocs.io/en/latest/) is used to test the role.

## Inputs

### `namespace`

The Docker Hub namespace where the image is in. Default '"robertdebock"'.

### `image`

The image you want to run on. Default '"fedora"'.

### `tag`

The tag of the container image to use. Default '"latest"'.

## Example usage

Here is a default configuration that tests your role on `namespace: robertdebock`, `image: fedora`, `tag: latest`.

```yaml
---
on:
  - push

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: checkout
        uses: actions/checkout@v2
        with:
          path: "${{ github.repository }}"
      - name: molecule
        uses: robertdebock/molecule-action@master
```

NOTE: the `checkout` action needs to place the file in `${{ github.repository }}` in order for Molecule to find your role.

If you want to test your role against multiple distributions, you can use this pattern:

```yaml
---
name: CI

on:
  - push

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        image:
          - alpine
          - amazonlinux
          - debian
          - centos
          - fedora
          - opensuse
          - ubuntu
    steps:
      - name: checkout
        uses: actions/checkout@v2
        with:
          path: "${{ github.repository }}"
      - name: molecule
        uses: robertdebock/molecule-action@master
        with:
          image: ${{ matrix.image }}
```

You can also test different tags, this is a bit clunky; you basically define a full matrix and exclude many tags.

```yaml
---
name: CI

on:
  - push

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        image:
          - alpine
          - amazonlinux
          - debian
          - centos
          - fedora
          - opensuse
          - ubuntu
        tag:
          - 1
          - 7
          - edge
          - latest
          - rawhide
          - unstable
        exclude:
          - image: alpine
            tag: 1
          - image: alpine
            tag: 7
          - image: alpine
            tag: rawhide
          - image: alpine
            tag: unstable
          - image: amazonlinux
            tag: 7
          - image: amazonlinux
            tag: edge
          - image: amazonlinux
            tag: rawhide
          - image: amazonlinux
            tag: unstable
          - image: debian
            tag: 1
          - image: debian
            tag: 7
          - image: debian
            tag: edge
          - image: debian
            tag: rawhide
          - image: centos
            tag: 1
          - image: centos
            tag: edge
          - image: centos
            tag: rawhide
          - image: centos
            tag: unstable
          - image: fedora
            tag: 1
          - image: fedora
            tag: 7
          - image: fedora
            tag: edge
          - image: fedora
            tag: unstable
          - image: opensuse
            tag: 1
          - image: opensuse
            tag: 7
          - image: opensuse
            tag: edge
          - image: opensuse
            tag: rawhide
          - image: opensuse
            tag: unstable
          - image: ubuntu
            tag: 1
          - image: ubuntu
            tag: 7
          - image: ubuntu
            tag: edge
          - image: ubuntu
            tag: rawhide
          - image: ubuntu
            tag: unstable
    steps:
      - name: checkout
        uses: actions/checkout@v2
        with:
          path: "${{ github.repository }}"
      - name: molecule
        uses: robertdebock/molecule-action@master
        with:
          image: ${{ matrix.image }}
```
