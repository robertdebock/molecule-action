# Molecule action

A GitHub action to tests your [Ansible](https://www.ansible.com/) role using [Molecule](https://molecule.readthedocs.io/en/stable/).

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
