QT += KService KNotifications KNotifications KI18n
QT += KIOCore KIOFileWidgets KIOWidgets KNTLM

HEADERS += \
    $$PWD/kde.h \
    $$PWD/notify.h \
    $$PWD/kdeconnect.h

SOURCES += \
    $$PWD/kde.cpp \
    $$PWD/notify.cpp \
    $$PWD/kdeconnect.cpp
