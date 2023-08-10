# Automated Key Generation and Import for VMware Modules

On EFI secure boot systems, it is needed to sign VMware modules (vmmon and vmnet) for VMware.

This project provides a Makefile-based automation process for generating cryptographic keys, importing them using `mokutil`, and managing the necessary files.

## Prerequisites

Before using this automation, ensure that you have the following installed:

- `openssl`
- `mokutil` (for importing keys)

## Usage

1. Clone the repository:

```
git clone https://github.com/m4j0rt0m/vmware-module-ops.git
cd vmware-module-ops
```

2. Use the provided Makefile to generate and import keys:

```
make all
```

## Clean

To clean up generated files, use:

```
make clean
```

## Directory Structure

```
/
├─ build/          # Generated files (keys and imported files)
├─ sign.sh         # Script for signing files
├─ Makefile        # Automation rules
├─ LICENSE         # Project's license
└─ README.md       # Project documentation
```

## Files

* `sign.sh`   : A script for signing files using the keys.
* `Makefile`  : Contains automation rules for generating keys, signing files, and importing keys.
* `LICENSE`   : The project's license file.
* `README.md` : This documentation.

## Important Notes

* The `sign.sh` script should be placed in the same directory as the Makefile.
* The provided `Makefile` assumes that you have the necessary permissions to run `sudo` commands.

## License

This project is licensed under the [MIT License](LICENSE) - see the [LICENSE](LICENSE) file for details.

## Author

* Abraham J. Ruiz R.
* Contact: major.tom.spaceworm@gmail.com
* GitHub: m4j0rt0m
