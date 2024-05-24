#include <string.h>
#include <math.h>
#include "structdef.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char*argv[])
{
	if(GEOM==1)
	{
		analysis("ref");
		analysis("starv");
		analysis("savy");
		analysis("OS_fragile");
		analysis("OS_hypox_tol");
		analysis("OS_hypos_tol");
		analysis("OS_hypox_boost");
	}
	
	if(GEOM==0)
	{
		analysis("c_starv");
		analysis("c_ref");
		analysis("c_savy");
		analysis("c_OS_fragile");
		analysis("c_OS_hypox_tol");
		analysis("c_OS_hypos_tol");
		analysis("c_OS_hypox_boost");
	}
}  
