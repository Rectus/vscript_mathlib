
/*
 * Unit test framework.
 */



function RunTests(scriptname)
{
	IncludeScript(scriptname, testScope)
	printl("Testing " + scriptname + "\n")
	
	local numTests = 0
	local failedTests = 0
	
	foreach(key, val in testScope)
	{
		if(key == "TestAssert") {continue}
	
		if(typeof val == "function")
		{
			print("Running test - " + key + ": ")
			numTests++
			
			local failed = false
			try
			{
				testScope[key]()
			}
			catch(exp)
			{
				failed = true
				failedTests++
				printl("FAIL - " + exp)
			}
			
			if(!failed)
			{
				printl("PASS")
			}
		
		}
	
	}
	
	printl("\n" + (numTests - failedTests) + "/" + numTests + " Tests passed.\n")
	ResetScope()
}


function ResetScope()
{
	testScope <- {}

	testScope.TestAssert <- function(exp, message)
	{
		if(exp == null || !exp) {throw message}
	}
}

ResetScope()