/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2018 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Menger Sponge formula modified by Mclarekin
 * from code by Knighty

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_menger_mod1.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MengerMod1Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	z = fabs(z);
	if (z.x - z.y < 0.0f)
	{
		REAL temp = z.y;
		z.y = z.x;
		z.x = temp;
	}
	if (z.x - z.z < 0.0f)
	{
		REAL temp = z.z;
		z.z = z.x;
		z.x = temp;
	}
	if (z.y - z.z < 0.0f)
	{
		REAL temp = z.z;
		z.z = z.y;
		z.y = temp;
	}
	z *= fractal->transformCommon.scale3;
	z.x -= 2.0f * fractal->transformCommon.constantMultiplier111.x;
	z.y -= 2.0f * fractal->transformCommon.constantMultiplier111.y;
	if (z.z > 1.0f) z.z -= 2.0f * fractal->transformCommon.constantMultiplier111.z;

	aux->DE *= fractal->transformCommon.scale3;

	if (fractal->transformCommon.rotationEnabled && aux->i >= fractal->transformCommon.startIterations
			&& aux->i < fractal->transformCommon.stopIterations)
	{
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	}
	z += fractal->transformCommon.additionConstant000;

	// boxoffset
	if (fractal->transformCommon.functionEnabledxFalse
			&& aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA) // box offset
	{
		REAL4 temp = z;
		z.x = mad(sign(z.x), fractal->transformCommon.additionConstantA000.x, z.x);
		z.y = mad(sign(z.y), fractal->transformCommon.additionConstantA000.y, z.y);
		z.z = mad(sign(z.z), fractal->transformCommon.additionConstantA000.z, z.z);

		if (fractal->transformCommon.functionEnabledFalse)
		{
			REAL tempL = length(temp);
			// if (tempL < 1e-21f) tempL = 1e-21f;
			REAL avgScale = native_divide(length(z), tempL);
			aux->DE = mad(aux->DE, avgScale, 1.0f);
		}
	}

	if (fractal->transformCommon.functionEnabledFalse)
	{
		REAL4 zA = (aux->i == fractal->transformCommon.intA) ? z : (REAL4){0, 0, 0, 0};
		REAL4 zB = (aux->i == fractal->transformCommon.intB) ? z : (REAL4){0, 0, 0, 0};

		z = (z * fractal->transformCommon.scale1) + (zA * fractal->transformCommon.offset)
				+ (zB * fractal->transformCommon.offset0);
		aux->DE *= fractal->transformCommon.scale1;
	}
	return z;
}