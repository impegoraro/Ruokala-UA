# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = ementasua

CONFIG += sailfishapp

SOURCES += src/ementasua.cpp

OTHER_FILES += qml/ementasua.qml \
    qml/cover/CoverPage.qml \
    rpm/ementasua.changes.in \
    rpm/ementasua.spec \
    rpm/ementasua.yaml \
    translations/*.ts \
    ementasua.desktop \
    qml/pages/PickDate.qml \
    qml/pages/MenusPage.qml \
    qml/pages/WelcomePage.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/ementasua-de.ts

HEADERS +=

