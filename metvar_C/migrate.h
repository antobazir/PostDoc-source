/* file containing the migration functions*/
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <math.h>
#include "matx.h"
#include "divide.h"
#include "perim_centroid.h"

#include <unistd.h>        
#include <sys/stat.h>  

int migrate_sphere();

void migrate_chip();

void migrate_chip2(int cell_idx);
