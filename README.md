# domgrep

`domgrep` is a powerful and flexible Linux command-line tool for searching domain names within files using regular expressions or plain-text patterns. It is designed for cybersecurity analysts, pentesters, and network researchers who need a reliable way to extract domain-related data from various data sources.

## Features

- Supports both regex-based and literal search modes
- Batch-processes files and directories
- Modular architecture with separate parser and utility components
- Includes a man page (`man domgrep`) for detailed CLI usage

## Installation

### Using `.deb` Package (Recommended for Debian/Ubuntu)

Download the latest `.deb` file from the [Releases page](https://github.com/mahros-alqabasy/domgrep/releases) and install it via `dpkg`:

```bash
sudo dpkg -i domgrep_<version>.deb
```

If dependencies are missing, fix them using:

```bash
sudo apt --fix-broken install
```

### Verify Installation

```bash
which domgrep
domgrep --help
```

The tool is now accessible globally using `domgrep`.

## Usage

### Basic Examples

```bash
# Search for domain-like patterns in a file
domgrep --file input.txt

# Search recursively in a directory using regex
domgrep --dir ./logs --regex

# Pipe input to domgrep
cat data.txt | domgrep
```

Refer to the full man page for all flags and options:

```bash
man domgrep
```

## Project Structure

After installation:

```
/usr/bin/domgrep         # CLI entry point
/usr/lib/domgrep/        # Internal scripts: domgrep.sh, parser.sh, utils.sh
/usr/share/man/man1/     # Compressed man page
/usr/share/doc/domgrep/  # README and changelog
```

## Development

To contribute:

1. Clone the repository:

```bash
git clone https://github.com/mahros-alqabasy/domgrep.git
cd domgrep
```

2. Make changes and test using:

```bash
bash src/domgrep.sh --help
```

3. Submit pull requests with clear descriptions.

The project uses GitHub Actions to auto-build `.deb` packages on `main` pushes.

## Packaging Notes

This package complies with Debian packaging standards. It uses:
- `fakeroot`, `dpkg-deb`, and `debhelper` for builds
- Proper file ownership (root:root) and structure
- Gzip-compressed manpages (`-n` to avoid timestamps)
- Lintian compliance (mostly)

## License

This project is licensed under the MIT License. See `LICENSE` file for details.

## Maintainer

**Mahros**  
Email: `mahros.elqabasy@htomail.com`  
GitHub: [@mahros-alqabasy](https://github.com/mahros-alqabasy)

---

_Proudly made in Egypt._
