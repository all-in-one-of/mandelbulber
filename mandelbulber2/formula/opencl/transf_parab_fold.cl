/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2018 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Parabolic Fold by mclarekin

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_parab_fold.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfParabFoldIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 temp = z;

	REAL4 slope2 = fractal->transformCommon.constantMultiplier111;
	REAL4 lengthAdd = fractal->transformCommon.additionConstant000;
	REAL4 factorP;

	factorP.x = native_divide(-slope2.x, (lengthAdd.x * 2.0f));
	factorP.y = native_divide(-slope2.y, (lengthAdd.y * 2.0f));
	factorP.z = native_divide(-slope2.z, (lengthAdd.z * 2.0f));

	if (temp.x > 0)
	{
		if (temp.x < lengthAdd.x)
		{
			z.x = z.x * z.x * factorP.x;
		}
		else
		{
			z.x = (z.x - native_divide(lengthAdd.x, 2.0f)) * slope2.x;
		}
	}
	if (temp.y > 0)
	{
		if (temp.y < lengthAdd.y)
		{
			z.y = z.y * z.y * factorP.y;
		}
		else
		{
			z.y = (z.y - native_divide(lengthAdd.y, 2.0f)) * slope2.y;
		}
	}
	if (temp.z > 0)
	{
		if (temp.z < lengthAdd.z)
		{
			z.z = z.z * z.z * factorP.z;
		}
		else
		{
			z.z = (z.z - native_divide(lengthAdd.z, 2.0f)) * slope2.z;
		}
	}

	if (temp.x < 0)
	{
		if (temp.x > -lengthAdd.x)
		{
			z.x = z.x * z.x * -factorP.x;
		}
		else
		{
			z.x = (z.x + native_divide(lengthAdd.x, 2.0f)) * slope2.x;
		}
	}
	if (temp.y < 0)
	{
		if (temp.y > -lengthAdd.y)
		{
			z.y = z.y * z.y * -factorP.y;
		}
		else
		{
			z.y = (z.y + native_divide(lengthAdd.y, 2.0f)) * slope2.y;
		}
	}

	if (temp.z < 0)
	{

		if (temp.z > -lengthAdd.z)
		{
			z.z = z.z * z.z * -factorP.z;
		}
		else
		{
			z.z = (z.z + native_divide(lengthAdd.z, 2.0f)) * slope2.z;
		}
	}

	if (fractal->transformCommon.functionEnabledxFalse)
	{
		z = (z - temp) * fractal->transformCommon.scale3D111;
	}
	if (fractal->transformCommon.functionEnabledyFalse)
	{
		z = (z - temp) * temp * fractal->transformCommon.scale3D111;

		z.x = sign(temp.x) * z.x;
		z.y = sign(temp.y) * z.y;
		z.z = sign(temp.z) * z.z;
	}
	if (fractal->transformCommon.functionEnabledzFalse)
	{
		z = (z - temp) * temp * fractal->transformCommon.scale3D111;
	}

	if (fractal->analyticDE.enabled)
	{
		if (!fractal->analyticDE.enabledFalse)
			aux->DE = mad(aux->DE, fractal->analyticDE.scale1, fractal->analyticDE.offset0);
		else
		{
			REAL avgScale = native_divide(length(z), length(temp));
			aux->DE = mad(aux->DE * avgScale, fractal->analyticDE.scale1, fractal->analyticDE.offset0);
		}
	}
	return z;
}