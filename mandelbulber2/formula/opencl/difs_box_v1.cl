/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * DIFSBoxV1Iteration  fragmentarium code, mdifs by knighty (jan 2012)
 * DIFS = direct distance iterated function (primitives) system

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "DIFSBoxV1Iteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 DIFSBoxV1Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL colorAdd = 0.0f;
	REAL4 oldZ = z;
	REAL4 boxFold = fractal->transformCommon.additionConstantA111;

	// abs
	if (fractal->transformCommon.functionEnabledAxFalse
			&& aux->i >= fractal->transformCommon.startIterationsX
			&& aux->i < fractal->transformCommon.stopIterationsX)
		z.x = fabs(z.x);

	if (fractal->transformCommon.functionEnabledAyFalse
			&& aux->i >= fractal->transformCommon.startIterationsY
			&& aux->i < fractal->transformCommon.stopIterationsY)
		z.y = fabs(z.y);

	if (fractal->transformCommon.functionEnabledAzFalse
			&& aux->i >= fractal->transformCommon.startIterationsZ
			&& aux->i < fractal->transformCommon.stopIterationsZ)
		z.z = fabs(z.z);
	// xy box fold
	if (fractal->transformCommon.functionEnabledCx
			&& aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		z.x = fabs(z.x + boxFold.x) - fabs(z.x - boxFold.x) - z.x;
		z.y = fabs(z.y + boxFold.y) - fabs(z.y - boxFold.y) - z.y;
	}
	// xyz box fold
	if (fractal->transformCommon.functionEnabledBFalse
			&& aux->i >= fractal->transformCommon.startIterationsB
			&& aux->i < fractal->transformCommon.stopIterationsB)
		z -= boxFold;
	// polyfold
	if (fractal->transformCommon.functionEnabledPFalse
			&& aux->i >= fractal->transformCommon.startIterationsP
			&& aux->i < fractal->transformCommon.stopIterationsP)
	{
		z.x = fabs(z.x);
		int poly = fractal->transformCommon.int6;
		REAL psi = fabs(fmod(atan(native_divide(z.y, z.x)) + native_divide(M_PI_F, poly),
											native_divide(M_PI_F, (0.5f * poly)))
										- native_divide(M_PI_F, poly));
		REAL len = native_sqrt(mad(z.x, z.x, z.y * z.y));
		z.x = native_cos(psi) * len;
		z.y = native_sin(psi) * len;
	}

	// diag 1
	if (fractal->transformCommon.functionEnabledCxFalse
			&& aux->i >= fractal->transformCommon.startIterationsCx
			&& aux->i < fractal->transformCommon.stopIterationsCx)
		if (z.x > z.y)
		{
			REAL temp = z.x;
			z.x = z.y;
			z.y = temp;
		}

	// abs offsets
	if (fractal->transformCommon.functionEnabledCFalse
			&& aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
	{
		REAL xOffset = fractal->transformCommon.offsetC0;
		if (z.x < xOffset) z.x = fabs(z.x - xOffset) + xOffset;
	}
	if (fractal->transformCommon.functionEnabledDFalse
			&& aux->i >= fractal->transformCommon.startIterationsD
			&& aux->i < fractal->transformCommon.stopIterationsD)
	{
		REAL yOffset = fractal->transformCommon.offsetD0;
		if (z.y < yOffset) z.y = fabs(z.y - yOffset) + yOffset;
	}

	// diag 2
	if (fractal->transformCommon.functionEnabledCyFalse
			&& aux->i >= fractal->transformCommon.startIterationsCy
			&& aux->i < fractal->transformCommon.stopIterationsCy)
		if (z.x > z.y)
		{
			REAL temp = z.x;
			z.x = z.y;
			z.y = temp;
		}

	// reverse offset part 1
	if (aux->i >= fractal->transformCommon.startIterationsE
			&& aux->i < fractal->transformCommon.stopIterationsE)
		z.x -= fractal->transformCommon.offsetE0;

	if (aux->i >= fractal->transformCommon.startIterationsF
			&& aux->i < fractal->transformCommon.stopIterationsF)
		z.y -= fractal->transformCommon.offsetF0;

	// scale
	REAL useScale = 1.0f;
	if (aux->i >= fractal->transformCommon.startIterationsS
			&& aux->i < fractal->transformCommon.stopIterationsS)
	{
		useScale = aux->actualScaleA + fractal->transformCommon.scale2;
		z *= useScale;
		aux->DE = mad(aux->DE, fabs(useScale), 1.0f);

		if (fractal->transformCommon.functionEnabledKFalse
				&& aux->i >= fractal->transformCommon.startIterationsK
				&& aux->i < fractal->transformCommon.stopIterationsK)
		{
			// update actualScaleA for next iteration
			REAL vary = fractal->transformCommon.scaleVary0
									* (fabs(aux->actualScaleA) - fractal->transformCommon.scaleC1);
			aux->actualScaleA -= vary;
		}
	}

	// reverse offset part 2
	if (aux->i >= fractal->transformCommon.startIterationsE
			&& aux->i < fractal->transformCommon.stopIterationsE)
		z.x += fractal->transformCommon.offsetE0;

	if (aux->i >= fractal->transformCommon.startIterationsF
			&& aux->i < fractal->transformCommon.stopIterationsF)
		z.y += fractal->transformCommon.offsetF0;

	// offset2
	z += fractal->transformCommon.offset001;

	// rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	}
	REAL colorDist = aux->dist;
	// DE
	REAL4 zc = z;
	if (fractal->transformCommon.functionEnabledYFalse) zc = oldZ;

	// box
	if (aux->i >= fractal->transformCommon.startIterations
			&& aux->i < fractal->transformCommon.stopIterations)
	{
		REAL4 boxSize = fractal->transformCommon.additionConstant111;
		// curve
		if (fractal->transformCommon.functionEnabledTFalse
				&& aux->i >= fractal->transformCommon.startIterationsT
				&& aux->i < fractal->transformCommon.stopIterationsT)
		{
			REAL absZZ = zc.z * zc.z * fractal->transformCommon.scale0;
			boxSize.x += absZZ;
			boxSize.y += absZZ;
		}

		// pyramid
		if (fractal->transformCommon.functionEnabledMFalse
				&& aux->i >= fractal->transformCommon.startIterationsM
				&& aux->i < fractal->transformCommon.stopIterationsM)
		{
			REAL subZ = fractal->transformCommon.scaleA0 * zc.z;
			boxSize.x -= subZ;
			boxSize.y -= subZ;
		}

		zc = fabs(zc) - boxSize;
		zc.x = max(zc.x, 0.0f);
		zc.y = max(zc.y, 0.0f);
		zc.z = max(zc.z, 0.0f);
		REAL zcd = length(zc);

		aux->dist = min(aux->dist, native_divide(zcd, aux->DE));

		if (!fractal->transformCommon.functionEnabledEFalse)
			aux->dist = min(aux->dist, native_divide(zcd, aux->DE));
		else
			aux->dist = min(aux->dist, native_divide(zcd, aux->DE)) - fractal->transformCommon.offsetB0;
	}

	// aux->color
	if (fractal->foldColor.auxColorEnabled)
	{
		if (fractal->foldColor.auxColorEnabledFalse)
		{
			colorAdd += fractal->foldColor.difs0000.x * fabs(z.x * z.y);
			colorAdd += fractal->foldColor.difs0000.y * max(z.x, z.y);
		}
		colorAdd += fractal->foldColor.difs1;
		if (fractal->foldColor.auxColorEnabledA)
		{
			if (colorDist != aux->dist) aux->color += colorAdd;
		}
		else
			aux->color += colorAdd;
	}
	return z;
}