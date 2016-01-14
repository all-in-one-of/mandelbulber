/**
 * Mandelbulber v2, a 3D fractal generator
 *
 * MyTabWidget class - promoted QTabWidget widget with drag and drop functionality (through mytabbar)
 *
 * Copyright (C) 2014 Krzysztof Marczak
 *
 * This file is part of Mandelbulber.
 *
 * Mandelbulber is free software: you can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * Mandelbulber is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details. You should have received a copy of the GNU
 * General Public License along with Mandelbulber. If not, see <http://www.gnu.org/licenses/>.
 *
 * Authors: Sebastian Jennen
 */

#include "mytabwidget.h"
#include "mytabbar.h"

MyTabWidget::MyTabWidget(QWidget *parent) : QTabWidget(parent)
{
	MyTabBar* bar = new MyTabBar();
	connect(bar, SIGNAL(dragDropChange()), this, SLOT(slotDragDropChange()));
	this->setTabBar(bar);
}

void MyTabWidget::slotDragDropChange()
{
	int swapA = 0;
	int swapB = 0;
	bool firstSwapFound = false;
	for(int i = 0; i < count(); i++){
		if(widget(i)->objectName() != "tab_fractal_formula_" + QString::number(i + 1)){
			if(!firstSwapFound)
			{
				swapA = i;
				firstSwapFound = true;
			}
			else
			{
				swapB = i;
				break;
			}
		}
	}
	if(swapA != swapB)
	{
		qDebug() << "TODO: swapTabs, " << swapA << ", " << swapB;
		emit swapTabs(swapA, swapB);
	}
}
