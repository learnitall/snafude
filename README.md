# snafuti

[![Docker Repository on Quay](https://quay.io/repository/rydrew/snafuti/status "Docker Repository on Quay")](https://quay.io/repository/rydrew/snafuti)
![Image Build](https://github.com/learnitall/snafuti/actions/workflows/build.yml/badge.svg)

Snafu Testing Image. Based on the work from [dhermes/python-multi](https://github.com/dhermes/python-multi).

Contains all of the versions of Python that snafu is compatible with for easy testing with tox.

## Usage

Need to clone [benchmark-wrapper](https://github.com/cloud-bulldozer/benchmark-wrapper) (or any fork) and pass as a volume:

> git clone https://github.com/cloud-bulldozer/benchmark-wrapper
> podman run --rm -it -v ./benchmark-wrapper:/root/snafu:Z quay.io/rydrew/snafuti

By default, the container runs tox against all unit test and documentation test environments.
