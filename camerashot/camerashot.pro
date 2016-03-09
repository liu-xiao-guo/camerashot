TEMPLATE = app
TARGET = camerashot

load(ubuntu-click)

QT += qml quick

SOURCES += main.cpp readenv.cpp
HEADERS += readenv.h

RESOURCES += camerashot.qrc

OTHER_FILES += camerashot.apparmor \
               camerashot.desktop \
               camerashot.png

#specify where the config files are installed to
config_files.path = /camerashot
config_files.files += $${OTHER_FILES}
message($$config_files.files)
INSTALLS+=config_files

# Default rules for deployment.
target.path = $${UBUNTU_CLICK_BINARY_PATH}
INSTALLS+=target

