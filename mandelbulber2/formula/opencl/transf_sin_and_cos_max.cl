/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2018 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * max sin - cos

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_sin_and_cos_max.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfSinAndCosMaxIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 oldZ = z;
	REAL4 maxZ = z;
	REAL4 sinZ = z;
	REAL4 cosZ = z;
	REAL4 sinCosZ = z;

	if (fractal->transformCommon.functionEnabledAx)
	{
		sinZ.x =
			native_sin(oldZ.x * native_divide(M_PI_2x, fractal->transformCommon.constantMultiplierA111.x))
			* fractal->transformCommon.scaleA1; // freq
		cosZ.x =
			native_cos(oldZ.x * native_divide(M_PI_2x, fractal->transformCommon.constantMultiplierB111.x))
			* fractal->transformCommon.scaleB1;
		sinCosZ.x = sinZ.x * cosZ.x * fractal->transformCommon.scaleC1;
		maxZ.x = max(max(sinZ.x, cosZ.x), sinCosZ.x);

		if (fractal->transformCommon.functionEnabledFalse) maxZ.x /= (fabs(oldZ.x) + 1.0f);
	}

	if (fractal->transformCommon.functionEnabledAyFalse)
	{
		sinZ.y =
			native_sin(oldZ.y * native_divide(M_PI_2x, fractal->transformCommon.constantMultiplierA111.y))
			* fractal->transformCommon.scaleA1; // freq
		cosZ.y =
			native_cos(oldZ.y * native_divide(M_PI_2x, fractal->transformCommon.constantMultiplierB111.y))
			* fractal->transformCommon.scaleB1;
		sinCosZ.y = sinZ.y * cosZ.y * fractal->transformCommon.scaleC1;
		maxZ.y = max(max(sinZ.y, cosZ.y), sinCosZ.y);

		if (fractal->transformCommon.functionEnabledFalse) maxZ.y /= (fabs(oldZ.y) + 1.0f);
	}

	if (fractal->transformCommon.functionEnabledAzFalse)
	{
		sinZ.z =
			native_sin(oldZ.z * native_divide(M_PI_2x, fractal->transformCommon.constantMultiplierA111.z))
			* fractal->transformCommon.scaleA1; // freq
		cosZ.z =
			native_cos(oldZ.z * native_divide(M_PI_2x, fractal->transformCommon.constantMultiplierB111.z))
			* fractal->transformCommon.scaleB1;
		sinCosZ.z = sinZ.z * cosZ.z * fractal->transformCommon.scaleC1;
		maxZ.z = max(max(sinZ.z, cosZ.z), sinCosZ.z);

		if (fractal->transformCommon.functionEnabledFalse) maxZ.z /= (fabs(oldZ.z) + 1.0f);
	}

	// post scale
	maxZ *= fractal->transformCommon.scale;
	aux->DE *= fabs(fractal->transformCommon.scale);

	if (fractal->transformCommon.functionEnabledMFalse)
	{
		switch (fractal->combo4.combo4)
		{
			case multi_combo4Cl_type1:
			default: maxZ += oldZ; break;
			case multi_combo4Cl_type2: maxZ *= oldZ; break;
			case multi_combo4Cl_type3: maxZ += fabs(oldZ); break;
			case multi_combo4Cl_type4: maxZ *= fabs(oldZ); break;
		}
	}

	z = maxZ;

	// analytic tweaks
	if (fractal->analyticDE.enabledFalse) // temp
	{
		aux->DE = mad(aux->DE, fractal->analyticDE.scale1, fractal->analyticDE.offset1);
	}
	return z;
}