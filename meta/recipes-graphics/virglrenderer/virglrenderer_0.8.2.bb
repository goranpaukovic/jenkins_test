SUMMARY = "VirGL virtual OpenGL renderer"
DESCRIPTION = "Virgil is a research project to investigate the possibility of \
creating a virtual 3D GPU for use inside qemu virtual machines, that allows \
the guest operating system to use the capabilities of the host GPU to \
accelerate 3D rendering."
HOMEPAGE = "https://virgil3d.github.io/"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=c81c08eeefd9418fca8f88309a76db10"

DEPENDS = "libdrm virtual/libgl libepoxy"
SRCREV = "7d204f3927be65fb3365dce01dbcd04d447a4985"
SRC_URI = "git://anongit.freedesktop.org/git/virglrenderer;branch=master \
           file://0001-gallium-Expand-libc-check-to-be-platform-OS-check.patch \
           file://0001-meson.build-use-python3-directly-for-python.patch \
           file://cve-2022-0135.patch \
           file://cve-2022-0175.patch \
           "

S = "${WORKDIR}/git"

inherit meson pkgconfig features_check

BBCLASSEXTEND = "native nativesdk"

REQUIRED_DISTRO_FEATURES = "opengl"
