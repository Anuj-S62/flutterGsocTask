SUMMARY = "Flutter GSoC Task"
DESCRIPTION = "Flutter GSoC Task App."

HOMEPAGE = "https://github.com/Anuj-S62/flutter_gsoc_task"

BUGTRACKER = "https://github.com/Anuj-S62/flutter_gsoc_task/issues"

SECTION = "graphics"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=903af033e1d3826276d4e99c44f83c8a"


SRC_URI = "https://github.com/Anuj-S62/flutter_gsoc_task.git"

SRCREV = "${AUTOREV}"
S = "${WORKDIR}/git"


inherit agl-app flutter-app

# flutter-app
#############
PUBSPEC_APPNAME = "flutter_gsoc_task"
FLUTTER_APPLICATION_INSTALL_PREFIX = "/flutter"
FLUTTER_BUILD_ARGS = "bundle -v"

# agl-app
#########
AGL_APP_TEMPLATE = "agl-app-flutter"
AGL_APP_ID = "flutter_gsoc_task"
AGL_APP_NAME = "GSoC Task"

