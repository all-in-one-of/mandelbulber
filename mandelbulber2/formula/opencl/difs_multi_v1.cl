/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * DIFSMulti
 * http://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "DIFSMultiV1Iteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 DIFSMultiV1Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL colorAdd = 0.0f;
	REAL4 oldZ = z;
	REAL4 boxFold = fractal->transformCommon.additionConstantA111;

	// abs
	if (fractal->transformCommon.functionEnabledAx
			&& aux->i >= fractal->transformCommon.startIterationsX
			&& aux->i < fractal->transformCommon.stopIterationsX)
		z.x = fabs(z.x);

	if (fractal->transformCommon.functionEnabledAy
			&& aux->i >= fractal->transformCommon.startIterationsY
			&& aux->i < fractal->transformCommon.stopIterationsY)
		z.y = fabs(z.y);

	if (fractal->transformCommon.functionEnabledAzFalse
			&& aux->i >= fractal->transformCommon.startIterationsZ
			&& aux->i < fractal->transformCommon.stopIterationsZ)
		z.z = fabs(z.z);
	if (fractal->transformCommon.functionEnabledFalse)
	{
		// xy box fold
		if (fractal->transformCommon.functionEnabledAFalse
				&& aux->i >= fractal->transformCommon.startIterationsA
				&& aux->i < fractal->transformCommon.stopIterationsA)
		{
			z.x -= boxFold.x;
			z.y -= boxFold.y;
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

		// diag fold1
		if (fractal->transformCommon.functionEnabledCxFalse
				&& aux->i >= fractal->transformCommon.startIterationsCx
				&& aux->i < fractal->transformCommon.stopIterationsCx)
			if (z.y > z.x)
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

		// diag fold2
		if (fractal->transformCommon.functionEnabledCyFalse
				&& aux->i >= fractal->transformCommon.startIterationsCy
				&& aux->i < fractal->transformCommon.stopIterationsCy)
			if (z.y > z.x)
			{
				REAL temp = z.x;
				z.x = z.y;
				z.y = temp;
			}
	}

	// reverse offset part 1
	if (aux->i >= fractal->transformCommon.startIterationsE
			&& aux->i < fractal->transformCommon.stopIterationsE)
		z.x -= fractal->transformCommon.offsetE2;

	if (aux->i >= fractal->transformCommon.startIterationsF
			&& aux->i < fractal->transformCommon.stopIterationsF)
		z.y -= fractal->transformCommon.offsetF2;

	// scale
	REAL useScale = 1.0f;
	if (aux->i >= fractal->transformCommon.startIterationsS
			&& aux->i < fractal->transformCommon.stopIterationsS)
	{
		useScale = aux->actualScaleA + fractal->transformCommon.scale2;
		z *= useScale;

		if (!fractal->analyticDE.enabledFalse)
			aux->DE = mad(aux->DE, fabs(useScale), 1.0f);
		else
			aux->DE =
				mad(aux->DE * fabs(useScale), fractal->analyticDE.scale1, fractal->analyticDE.offset1);

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
		z.x += fractal->transformCommon.offsetE2;

	if (aux->i >= fractal->transformCommon.startIterationsF
			&& aux->i < fractal->transformCommon.stopIterationsF)
		z.y += fractal->transformCommon.offsetF2;

	// offset
	z += fractal->transformCommon.offset001;

	// rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	}

	// DE
	REAL colorDist = aux->dist;
	REAL4 zc = oldZ;

	if (fractal->transformCommon.functionEnabledFFalse) zc = z;

	// box
	if (fractal->transformCommon.functionEnabledM
			&& aux->i >= fractal->transformCommon.startIterations
			&& aux->i < fractal->transformCommon.stopIterations)
	{
		REAL4 boxSize = fractal->transformCommon.additionConstant111;
		REAL4 bxV = zc;
		REAL bxD = 0.0f;
		bxV = fabs(bxV) - boxSize;
		bxD = max(bxV.x, max(bxV.y, bxV.z)); // infnorm
		if (!fractal->transformCommon.functionEnabledJFalse && bxD > 0.0f)
		{
			bxV.x = max(bxV.x, 0.0f);
			bxV.y = max(bxV.y, 0.0f);
			bxV.z = max(bxV.z, 0.0f);
			aux->DE0 = length(bxV);
		}
		aux->dist = min(aux->dist, native_divide(aux->DE0, aux->DE));
		// round box
		if (fractal->transformCommon.functionEnabledEFalse)
			aux->dist -= native_divide(fractal->transformCommon.offsetB0, 1000.0f);
	}
	// sphere
	if (fractal->transformCommon.functionEnabledMFalse
			&& aux->i >= fractal->transformCommon.startIterationsM
			&& aux->i < fractal->transformCommon.stopIterationsM)
	{
		aux->DE0 = length(zc) - fractal->transformCommon.offsetR1;
		aux->dist = min(aux->dist, native_divide(aux->DE0, aux->DE));
	}

	// cylinder
	if (fractal->transformCommon.functionEnabledOFalse
			&& aux->i >= fractal->transformCommon.startIterationsO
			&& aux->i < fractal->transformCommon.stopIterationsO)
	{
		REAL cylD = 0.0f;
		//- fractal->transformCommon.scale0 * aux->i;

		if (fractal->transformCommon.functionEnabledSwFalse)
		{
			REAL temp = zc.x;
			zc.x = zc.z;
			zc.z = temp;
		}

		REAL cylR = native_sqrt(mad(zc.x, zc.x, zc.y * zc.y));
		REAL cylH = fabs(zc.z) - fractal->transformCommon.offsetA1;

		REAL cylRm = cylR - fractal->transformCommon.radius1;

		if (!fractal->transformCommon.functionEnabledXFalse)
		{
			if (!fractal->transformCommon.functionEnabledzFalse) cylR = cylRm;
			cylR = max(cylR, 0.0f);
			REAL cylHm = max(cylH, 0.0f);
			cylD = native_sqrt(mad(cylR, cylR, cylHm * cylHm));
		}
		else
			cylD = native_sqrt(mad(cylRm, cylRm, cylH * cylH));

		aux->DE0 = min(max(cylRm, cylH) - fractal->transformCommon.offsetR0, 0.0f) + cylD;
		aux->dist = min(aux->dist, native_divide(aux->DE0, aux->DE));
	}

	// torus
	if (fractal->transformCommon.functionEnabledTFalse
			&& aux->i >= fractal->transformCommon.startIterationsT
			&& aux->i < fractal->transformCommon.stopIterationsT)
	{
		REAL T1 = native_sqrt(mad(zc.y, zc.y, zc.x * zc.x)) - fractal->transformCommon.offsetT1;
		aux->DE0 = native_sqrt(mad(T1, T1, zc.z * zc.z)) - fractal->transformCommon.offset05;
		aux->dist = min(aux->dist, native_divide(aux->DE0, aux->DE));
	}

	// aux->color
	if (fractal->foldColor.auxColorEnabled)
	{
		if (fractal->foldColor.auxColorEnabledFalse)
		{
			colorAdd += fractal->foldColor.difs0000.x * fabs(z.x * z.y); // fabs(zc.x * zc.y)
			colorAdd += fractal->foldColor.difs0000.y * max(z.x, z.y);	 // max(z.x, z.y);
			colorAdd += fractal->foldColor.difs0000.z * (mad(z.x, z.x, z.y * z.y));
			colorAdd += fractal->foldColor.difs0000.w * fabs(zc.x * zc.y);
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