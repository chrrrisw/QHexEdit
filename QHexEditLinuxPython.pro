TEMPLATE = lib
TARGET = QHexEdit

unix {

  INCLUDEPATH += .

  QT += gui widgets

  CONFIG += shared_and_static build_all

  target.path = /usr/local/lib
  INSTALLS += target

} else {

  CONFIG += staticlib

}

CONFIG -= debug_and_release

HEADERS += qhexedit.h \
           qhexeditcomments.h \
           qhexeditdata.h \
           qhexeditdatadevice.h \
           qhexeditdatareader.h \
           qhexeditdatawriter.h \
           qhexedithighlighter.h \
           qhexeditprivate.h \
           sparserangemap.h
SOURCES += qhexedit.cpp \
           qhexeditcomments.cpp \
           qhexeditdata.cpp \
           qhexeditdatadevice.cpp \
           qhexeditdatareader.cpp \
           qhexeditdatawriter.cpp \
           qhexedithighlighter.cpp \
           qhexeditprivate.cpp \
           sparserangemap.cpp
