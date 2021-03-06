/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * 3D Version of the 2D Eye Fractal modified by mclarekin

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "MandelbulbEyeTestIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MandelbulbEyeTestIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	// testing power2 thing, covert to non trig?
	REAL4 c = aux->const_c;
	aux->DE = aux->DE * 2.0f * aux->r;

	if (fractal->buffalo.preabsx) z.x = fabs(z.x);
	if (fractal->buffalo.preabsy) z.y = fabs(z.y);
	if (fractal->buffalo.preabsz) z.z = fabs(z.z);

	REAL4 zz = z * z;
	REAL rr = zz.x + zz.y + zz.z;
	REAL temp = native_sqrt(zz.x + zz.y);
	REAL theta1 = atan2(temp, z.z) * fractal->transformCommon.scaleB1;
	REAL theta2 = atan2(temp, -z.z) * fractal->transformCommon.scaleC1;

	REAL phi1 = atan2(z.y, z.x) * fractal->transformCommon.scale1;
	REAL phi2 = atan2(-z.y, z.x) * fractal->transformCommon.scaleA1;

	z.x = rr * native_sin(theta1 + theta2) * native_cos(phi1 + phi2);
	z.y = rr * native_sin(theta1 + theta2) * native_sin(phi1 + phi2);
	z.z = rr * native_cos(theta1 + theta2);

	/*REAL4 zzA = z * z;
	REAL4 zzB = zzA; // * fractal->transformCommon.scaleD1;

	REAL rrA = zzA.x + zzA.y + zzA.z;
	REAL rrB = zzB.x + zzB.y + zzB.z;


	REAL tempA = native_sqrt(zzA.x + zzA.y);
	REAL tempB = native_sqrt(zzB.x + zzB.y);

	REAL theta1 = atan2(tempA, zzA.z) * fractal->transformCommon.scaleB1;
	REAL theta2 = atan2(tempB, -zzB.z) * fractal->transformCommon.scaleC1;

	REAL phi1 = atan2(zzA.y, zzA.x) * fractal->transformCommon.scale1;
	REAL phi2 = atan2(-zzB.y, zzB.x) * fractal->transformCommon.scaleA1;

	REAL rrAB = rrA * rrB;

	z.x = (rrAB) * native_sin(theta1 + theta2) * native_cos(phi1 + phi2);
	z.y = (rrAB) * native_sin(theta1 + theta2) * native_sin(phi1 + phi2);
	z.z = (rrAB) * native_cos(theta1 + theta2);*/

	// addCpixel
	if (fractal->transformCommon.addCpixelEnabledFalse
			&& aux->i >= fractal->transformCommon.startIterationsE
			&& aux->i < fractal->transformCommon.stopIterationsE)
	{
		REAL4 tempC = c;
		if (fractal->transformCommon.alternateEnabledFalse) // alternate
		{
			tempC = aux->c;
			switch (fractal->mandelbulbMulti.orderOfXYZ)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (REAL4){tempC.x, tempC.y, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (REAL4){tempC.x, tempC.z, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (REAL4){tempC.y, tempC.x, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (REAL4){tempC.y, tempC.z, tempC.x, tempC.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (REAL4){tempC.z, tempC.x, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (REAL4){tempC.z, tempC.y, tempC.x, tempC.w}; break;
			}
			aux->c = tempC;
		}
		else
		{
			switch (fractal->mandelbulbMulti.orderOfXYZ)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (REAL4){c.x, c.y, c.z, c.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (REAL4){c.x, c.z, c.y, c.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (REAL4){c.y, c.x, c.z, c.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (REAL4){c.y, c.z, c.x, c.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (REAL4){c.z, c.x, c.y, c.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (REAL4){c.z, c.y, c.x, c.w}; break;
			}
		}
		z += tempC * fractal->transformCommon.constantMultiplier111;
	}
	z.x = fractal->buffalo.absx ? fabs(z.x) : z.x;
	z.y = fractal->buffalo.absy ? fabs(z.y) : z.y;
	z.z = fractal->buffalo.absz ? fabs(z.z) : z.z;
	z += fractal->transformCommon.additionConstantA000;

	/*REAL4 hypercomplex_pow_constant( REAL4 &vec1,  int n)
	{
		REAL r = native_sqrt(native_powr(vec1.x, 2) + native_powr(vec1.y, 2) + native_powr(vec1.z, 2));
		REAL theta = atan2(native_sqrt(native_powr(vec1.x, 2) + native_powr(vec1.y, 2)), vec1.z);
		REAL phi = atan2(vec1.y, vec1.x);

		REAL new_x = native_powr(r, n) * native_sin(theta * n) * native_cos(phi * n);
		REAL new_y = native_powr(r, n) * native_sin(theta * n) * native_sin(phi * n);
		REAL new_z = native_powr(r, n) * native_cos(theta * n);

		return (REAL4) {new_x, new_y, new_z, vec1.w};
	}*/

	if (fractal->analyticDE.enabledFalse)
		aux->DE = mad(aux->DE, fractal->analyticDE.scale1, fractal->analyticDE.offset1);
	return z;
}