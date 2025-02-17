/**********************************************************************************************
    Copyright (C) 2014 Oliver Eichler <oliver.eichler@gmx.de>

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

#ifndef CGRID_H
#define CGRID_H

#include <QColor>
#include <QObject>

#include "gis/proj_x.h"
class QPainter;
class QSettings;
class CMapDraw;

class CGrid : public QObject {
  Q_OBJECT
 public:
  CGrid(CMapDraw* map);
  virtual ~CGrid();

  void saveConfig(QSettings& cfg);
  void loadConfig(QSettings& cfg);

  void draw(QPainter& p, const QRect& rect);

  void setProjAndColor(const QString& projStr, const QColor& c);

  const QColor& getColor() { return color; }
  const QString getGridProjString() { return proj.getProjTar(); }

  void convertPos2Str(const QPointF& pos, QString& info, bool simple);

 private:
  void findGridSpace(qreal min, qreal max, qreal& xSpace, qreal& ySpace);
  bool calcIntersection(qreal x1, qreal y1, qreal x2, qreal y2, qreal x3, qreal y3, qreal x4, qreal y4, qreal& x,
                        qreal& y);

  CMapDraw* map;

  CProj proj{"EPSG:4326", "EPSG:4326"};
  QColor color = Qt::magenta;
};

#endif  // CGRID_H
