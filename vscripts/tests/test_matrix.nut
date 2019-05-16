
/*
 * Unit tests for libraries/matrix.nut
 */


IncludeScript("libraries/mathutils", this)

matrix1 <- MathUtils.Matrix([ 1,2,3, 4,5,6, 7,8,9 ], 3, 3)
invMat <- MathUtils.Matrix([ 1,0,0, 4,1,0, 7,0,1 ], 3, 3)
adjMat <- MathUtils.Matrix([ 3,1,1, 1,3,-1, 2,4,1 ], 3, 3)
nonSqr <- MathUtils.Matrix([ 1,2,3, 1,0,-1,], 2, 3)


function ConstructArray()
{
	local matrix = null
	try
	{
		matrix = MathUtils.Matrix([1,2,3,4,5,6,7,8,9], 3, 3)	
	}
	catch(exp)
	{
		TestAssert(null, "Matrix creation failed: " + exp)
	}
	TestAssert(matrix, "Null matrix returned")
	TestAssert(matrix.GetCellValue(1, 0) == 4, "Invalid matrix")
}

	
function ConstructTinyArray()
{
	local matrix = null
	try
	{
		matrix = MathUtils.Matrix([-1], 1, 1)	
	}
	catch(exp)
	{
		TestAssert(null, "Matrix creation failed: " + exp)
	}
	TestAssert(matrix, "Null matrix returned")
	TestAssert(matrix.GetCellValue(0, 0) == -1, "Invalid matrix")

}


function ConstructNestedArray()
{
	local matrix = null
	try
	{
		matrix = MathUtils.Matrix([ [1,2,3], [4,5,6] ,[7,8,9] ], 3, 3)		
	}
	catch(exp)
	{
		TestAssert(null, "Matrix creation failed: " + exp)
	}
	TestAssert(matrix, "Null matrix returned")
	TestAssert(matrix.GetCellValue(1, 0) == 4, "Invalid matrix")

}

function ConstructVectorArray()
{
	local matrix = null
	try
	{
		matrix = MathUtils.Matrix([ Vector(1,2,3), Vector(4,5,6) ,Vector(7,8,9), Vector(0,0,0) ], 4, 3)		
	}
	catch(exp)
	{
		TestAssert(null, "Matrix creation failed: " + exp)
	}
	TestAssert(matrix, "Null matrix returned")
	TestAssert(matrix.GetCellValue(3, 0) == 0, "Invalid matrix")

}


function ConstructInvalidDim()
{
	local fail = false
	local matrix = null
	try
	{
		matrix = MathUtils.Matrix([ [1,2,3], [4,5,6] ,[7,8,9] ], 3, 0)
		fail = true		
	}
	catch(exp){}	
	if(fail)
	{
		TestAssert(matrix, "Null matrix returned")
		TestAssert(null, "Matrix created with invalid columns")
	}
	
	local matrix = null
	fail = false
	try
	{
		matrix = MathUtils.Matrix([ [1,2,3], [4,5,6] ,[7,8,9] ], 0, 3)
	}
	catch(exp){}
	if(fail)
	{
		TestAssert(matrix, "Null matrix returned")
		TestAssert(null, "Matrix created with invalid columns")
	}
}



function TestGetCell()
{
	try
	{
		TestAssert(matrix1.GetCellValue(0,0) == 1, "Invalid value 1")
		TestAssert(matrix1.GetCellValue(2,2) == 9, "Invalid value 2")
	}
	catch(exp)
	{
		TestAssert(null, "Call failed: " + exp)
	}

	local pass = true
	try
	{
		matrix1.GetCellValue(0, -1)
		pass = false
	}
	catch(exp){}
	TestAssert(pass, "Returned from invalid call")
	
	try
	{
		matrix1.GetCellValue(-1, 0)
		pass = false
	}
	catch(exp){}
	TestAssert(pass, "Returned from invalid call")
}


function TestGetRowArray()
{
	local row = null
	try
	{
		matrix1.GetRowArray(0)
		row = matrix1.GetRowArray(2)
	}
	catch(exp)
	{
		TestAssert(null, "Call failed: " + exp)
	}

	TestAssert(row[0] == 7, "Wrong value returned 1")
	TestAssert(row[1] == 8, "Wrong value returned 2")
	TestAssert(row[2] == 9, "Wrong value returned 3")
}


function TestGetColArray()
{
	local col = null
	try
	{
		matrix1.GetColArray(0)
		col = matrix1.GetColArray(2)
	}
	catch(exp)
	{
		TestAssert(null, "Call failed: " + exp)
	}

	TestAssert(col[0] == 3, "Wrong value returned 1")
	TestAssert(col[1] == 6, "Wrong value returned 2")
	TestAssert(col[2] == 9, "Wrong value returned 3")
}


function TestGetCofactor()
{
	local cf = null
	try
	{
		matrix1.GetCofactor(0, 0)
		cf = matrix1.GetCofactor(2, 2)
	}
	catch(exp)
	{
		TestAssert(null, "Call failed: " + exp)
	}

	TestAssert(cf.GetCellValue(0, 0) == 1, "Wrong value returned 1")
	TestAssert(cf.GetCellValue(0, 1) == 2, "Wrong value returned 2")
	TestAssert(cf.GetCellValue(1, 0) == 4, "Wrong value returned 3")
	TestAssert(cf.GetCellValue(1, 1) == 5, "Wrong value returned 4")
}


function TestGetDeterminantNonInv()
{
	local det = null
	try
	{
		det = matrix1.GetDeterminant()
	}
	catch(exp)
	{
		TestAssert(null, "Call failed: " + exp)
	}

	TestAssert(det == 0, "Wrong value returned")

}

function TestGetDeterminantInv()
{
	local det = null
	try
	{
		det = invMat.GetDeterminant()
	}
	catch(exp)
	{
		TestAssert(null, "Call failed: " + exp)
	}

	TestAssert(det == 1, "Wrong value returned")

}

function TestGetTranspose()
{
	local tra = null
	try
	{
		tra = matrix1.GetTranspose()
	}
	catch(exp)
	{
		TestAssert(null, "Call failed: " + exp)
	}
	TestAssert(tra.GetCellValue(0, 0) == 1, "Wrong value returned 1")
	TestAssert(tra.GetCellValue(0, 2) == 7, "Wrong value returned 2")
	TestAssert(tra.GetCellValue(2, 0) == 3, "Wrong value returned 3")
	TestAssert(tra.GetCellValue(2, 2) == 9, "Wrong value returned 4")
}

function TestGetAdjunct()
{
	local adj = null
	try
	{
		matrix1.GetAdjunct()
		adj = adjMat.GetAdjunct()
	}
	catch(exp)
	{
		TestAssert(null, "Call failed: " + exp)
	}
	TestAssert(adj.GetCellValue(0, 0) == 7, "Wrong value returned 1")
	TestAssert(adj.GetCellValue(0, 2) == -4, "Wrong value returned 2")
	TestAssert(adj.GetCellValue(2, 0) == -2, "Wrong value returned 3")
	TestAssert(adj.GetCellValue(2, 2) == 8, "Wrong value returned 4")
}

function TestGetAdjunctNonSqr()
{
	local adj = null
	try
	{
		adj = nonSqr.GetAdjunct()
	}
	catch(exp){ return }
	
	TestAssert(null, "Returned from invalid call")

}

function TestGetInverse()
{
	local inv = null
	try
	{
		inv = invMat.GetInverse()
	}
	catch(exp)
	{
		TestAssert(null, "Call failed: " + exp)
	}
	TestAssert(inv.GetCellValue(0, 0) == 1, "Wrong value returned 1")
	TestAssert(inv.GetCellValue(0, 2) == 0, "Wrong value returned 2")
	TestAssert(inv.GetCellValue(2, 0) == -7, "Wrong value returned 3")
	TestAssert(inv.GetCellValue(2, 2) == 1, "Wrong value returned 4")
	TestAssert(inv.GetCellValue(1, 0) == -4, "Wrong value returned 5")
}


function TestGetInverseNonInvertible()
{
	local inv = null
	try
	{
		inv = matrix1.GetInverse()
		TestAssert(null, "Non-invertible matrix inverted")
	}
	catch(exp){}
}


function TestMutliplyScalar()
{
	local result = null
	try
	{
		result = matrix1 * 2
	}
	catch(exp)
	{
		TestAssert(null, "Call failed: " + exp)
	}
	TestAssert(result.GetCellValue(0, 0) == 2, "Wrong value returned 1")
	TestAssert(result.GetCellValue(0, 2) == 6, "Wrong value returned 2")
	TestAssert(result.GetCellValue(2, 0) == 14, "Wrong value returned 3")
	TestAssert(result.GetCellValue(2, 2) == 18, "Wrong value returned 4")
}


function TestMutliplyMatrices()
{
	local result = null
	try
	{
		result = MathUtils.Matrix([11, 3, 7, 11], 2, 2) * MathUtils.Matrix([ [8, 0, 1], [0, 3, 5]], 2, 3)
	}
	catch(exp)
	{
		TestAssert(null, "Call failed: " + exp)
	}
	TestAssert(result.GetCellValue(0, 0) == 88, "Wrong value returned 1")
	TestAssert(result.GetCellValue(0, 2) == 26, "Wrong value returned 2")
	TestAssert(result.GetCellValue(1, 0) == 56, "Wrong value returned 3")
	TestAssert(result.GetCellValue(1, 2) == 62, "Wrong value returned 4")
}


function TestMutliplyArrayVec()
{
	local result = null
	try
	{
		result = matrix1 * [1, 0, -1]
	}
	catch(exp)
	{
		TestAssert(null, "Call failed: " + exp)
	}
	TestAssert(result[0] == -2, "Wrong value returned 1")
	TestAssert(result[1] == -2, "Wrong value returned 2")
	TestAssert(result[2] == -2, "Wrong value returned 3")
}

function TestMutliplyVector()
{
	local result = null
	try
	{
		result = matrix1 * Vector(1, 0, -1)
	}
	catch(exp)
	{
		TestAssert(null, "Call failed: " + exp)
	}
	TestAssert(result.x == -2, "Wrong value returned 1")
	TestAssert(result.y == -2, "Wrong value returned 2")
	TestAssert(result.z == -2, "Wrong value returned 3")
}


function ConstructTransformArray()
{
	local matrix = null
	try
	{
		matrix = MathUtils.TransformMatrix([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16])	
	}
	catch(exp)
	{
		TestAssert(null, "Matrix creation failed: " + exp)
	}
	TestAssert(matrix, "Null matrix returned")
	TestAssert(matrix.GetCellValue(1, 0) == 5, "Invalid matrix")
}


function ConstructTransformEnt()
{
	local ent = Entities.FindByClassname(null, "worldspawn") // Should have a 0 transform

	local matrix = null
	try
	{
		matrix = MathUtils.TransformMatrix(ent)	
	}
	catch(exp)
	{
		TestAssert(null, "Matrix creation failed: " + exp)
	}
	TestAssert(matrix, "Null matrix returned")
	TestAssert(matrix.GetCellValue(0, 0) == 1, "Wrong value returned 1")
	TestAssert(matrix.GetCellValue(1, 1) == 1, "Wrong value returned 2")
	TestAssert(matrix.GetCellValue(2, 2) == 1, "Wrong value returned 3")
	TestAssert(matrix.GetCellValue(3, 3) == 1, "Wrong value returned 3")
}


function ConstructTransformParams()
{
	local matrix = null
	try
	{
		matrix = MathUtils.TransformMatrix(Vector(10,-8,400), QAngle(6, 60, -30), Vector(1, 0.5, 10.5))	
	}
	catch(exp)
	{
		TestAssert(null, "Matrix creation failed: " + exp)
	}
	TestAssert(matrix, "Null matrix returned")
	TestAssert((matrix * Vector(1,0,0) - Vector(10.497261, -7.138719, 399.895477)).Length() < 0.01, "Invalid transform")
}


function TestEntTransform()
{
	local ent = g_ModeScript.CreateSingleSimpleEntityFromTable({
		classname = "prop_dynamic"
		model = "models/weapons/melee/sentry/sentry_top.mdl"
		origin = Vector(-600, 345.678, -1111.2222)
		angles = Vector(68, -69, 0.66)
	})

	local matrix = null
	try
	{
		matrix = MathUtils.TransformMatrix(ent)	
	}
	catch(exp)
	{
		TestAssert(null, "Matrix creation failed: " + exp)
	}
	TestAssert(matrix, "Null matrix returned")
	local orientationDot = matrix.GetOrientation().ToQuat().Dot(QAngle(68, -69, 0.66).ToQuat())
	TestAssert(orientationDot > 0.999, "Error too high on returned orientation")
}
