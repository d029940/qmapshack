/**********************************************************************************************
    Copyright (C) 2018 Oliver Eichler <oliver.eichler@gmx.de>

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

#include "realtime/CRtDraw.h"

#include "helpers/CDraw.h"
#include "realtime/CRtWorkspace.h"

CRtDraw::CRtDraw(CCanvas* parent) : IDrawContext("rt", CCanvas::eRedrawRt, parent) {
  connect(&CRtWorkspace::self(), &CRtWorkspace::sigChanged, this, &CRtDraw::emitSigCanvasUpdate);
}

void CRtDraw::draw(QPainter& p, const QRect& rect) { CRtWorkspace::self().fastDraw(p, rect, this); }

void CRtDraw::drawt(buffer_t& currentBuffer) {
  QPointF pt1 = currentBuffer.ref1;
  QPointF pt2 = currentBuffer.ref2;
  QPointF pt3 = currentBuffer.ref3;
  QPointF pt4 = currentBuffer.ref4;

  QPointF pp = currentBuffer.ref1;
  convertRad2Px(pp);

  QPolygonF viewport;
  viewport << pt1 << pt2 << pt3 << pt4;

  QPainter p(&currentBuffer.image);
  USE_ANTI_ALIASING(p, true);
  p.translate(-pp);

  CRtWorkspace::self().draw(p, viewport, this);
}
