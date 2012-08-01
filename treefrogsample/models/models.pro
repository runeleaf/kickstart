TARGET = model
TEMPLATE = lib
CONFIG += shared x86_64
QT += sql
QT -= gui
DEFINES += TF_DLL
DESTDIR = ../lib
INCLUDEPATH += ../helpers sqlobjects
DEPENDPATH  += ../helpers sqlobjects
LIBS += -L../lib -lhelper

include(../appbase.pri)

HEADERS += blogobject.h
HEADERS += blog.h
SOURCES += blog.cpp
