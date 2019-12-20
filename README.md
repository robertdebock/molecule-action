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

```yaml
uses: actions/molecule-action@1.0.0
with:
  namespace: robertdebock
  image: fedora
  tag: latest
```
