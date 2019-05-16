
/*
 * Unit tests for libraries/misc_utils.nut
 */


IncludeScript("libraries/mathutils", this)


function TestQuaternionMultiply()
{
	local quat = null
	local rot1 = QAngle(-45, 0, 0).ToQuat()
	local rot2 = QAngle(0, 90, 0).ToQuat()
	try
	{
		
		quat = MathUtils.QuaternionMultiply(rot1, rot2)	
	}
	catch(exp)
	{
		TestAssert(null, "Quaternion multiplication failed: " + exp)
	}
	TestAssert(quat, "Null variable returned")
	TestAssert(MathUtils.AreQAnglesEqual(quat.ToQAngle(), QAngle(0,90,-45), 0.00001), "Error on result too big")
}


function TestQuaternionMultiplyInv()
{
	local quat = null
	local rot1 = QAngle(-89.9, -5001, 180).ToQuat()
	try
	{
		
		quat = MathUtils.QuaternionMultiply(rot1, rot1.Invert())	
	}
	catch(exp)
	{
		TestAssert(null, "Quaternion multiplication failed: " + exp)
	}
	TestAssert(quat, "Null variable returned")
	TestAssert(abs(quat.ToQAngle().x + quat.ToQAngle().y + quat.ToQAngle().z) < 0.001, "Error on result too big")
}
