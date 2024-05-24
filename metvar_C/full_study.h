#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include "metvar_f.h"

#include <unistd.h>        
#include <sys/stat.h>      

int full_study(char* folder, float kS, float kO, float behav_code);

int full_study_chip(char* folder, float kS, float kO, float behav_code);
