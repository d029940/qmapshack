/**********************************************************************************************
    Copyright (C) 2014-2016 Oliver Eichler <oliver.eichler@gmx.de>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

**********************************************************************************************/

#ifndef SIGNALS_H
#define SIGNALS_H

#include <QObject>
#include <QRegularExpression>

inline void X______________BlockAllSignals______________X(QObject* parent) {
  const QList<QObject*>& children = parent->findChildren<QObject*>(QRegularExpression(".*"));
  for (QObject* obj : children) {
    obj->blockSignals(true);
  }
}

inline void X_____________UnBlockAllSignals_____________X(QObject* parent) {
  const QList<QObject*>& children = parent->findChildren<QObject*>(QRegularExpression(".*"));
  for (QObject* obj : children) {
    obj->blockSignals(false);
  }
}

#endif  // SIGNALS_H
