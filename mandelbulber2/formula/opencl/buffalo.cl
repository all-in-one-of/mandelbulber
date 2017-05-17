/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Buffalo fractal
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
inline void BuffaloIteration(float3 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	aux->r_dz = aux->r_dz * 2.0f * aux->r;

	if (fractal->buffalo.preabsx) z->x = fabs(z->x);
	if (fractal->buffalo.preabsy) z->y = fabs(z->y);
	if (fractal->buffalo.preabsz) z->z = fabs(z->z);

	float x2 = z->x * z->x;
	float y2 = z->y * z->y;
	float z2 = z->z * z->z;
	float temp = 1.0f - native_divide(z2, (x2 + y2));
	float newx = (x2 - y2) * temp;
	float newy = 2.0f * z->x * z->y * temp;
	float newz = (fractal->buffalo.posz ? 2.0f : -2.0f) * z->z * native_sqrt(x2 + y2);

	z->x = fractal->buffalo.absx ? fabs(newx) : newx;
	z->y = fractal->buffalo.absy ? fabs(newy) : newy;
	z->z = fractal->buffalo.absz ? fabs(newz) : newz;
}
#else
inline void BuffaloIteration(double3 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	aux->r_dz = aux->r_dz * 2.0 * aux->r;

	if (fractal->buffalo.preabsx) z->x = fabs(z->x);
	if (fractal->buffalo.preabsy) z->y = fabs(z->y);
	if (fractal->buffalo.preabsz) z->z = fabs(z->z);

	double x2 = z->x * z->x;
	double y2 = z->y * z->y;
	double z2 = z->z * z->z;
	double temp = 1.0 - native_divide(z2, (x2 + y2));
	double newx = (x2 - y2) * temp;
	double newy = 2.0 * z->x * z->y * temp;
	double newz = (fractal->buffalo.posz ? 2.0 : -2.0) * z->z * native_sqrt(x2 + y2);

	z->x = fractal->buffalo.absx ? fabs(newx) : newx;
	z->y = fractal->buffalo.absy ? fabs(newy) : newy;
	z->z = fractal->buffalo.absz ? fabs(newz) : newz;
}
#endif
