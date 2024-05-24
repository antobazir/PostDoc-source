
#if GEOM==0 
	#define SZ 70
#elif GEOM==1 
	#define SZ 400
#else 
	#define SZ 70
#endif

	typedef struct Nutrs
	{

		/*nutrient*/
		float S[SZ][SZ];
		float O[SZ][SZ];

		/*Diffusion*/
		float DSm[SZ][SZ];
		float DOm[SZ][SZ];
		float DS_med;
		float DS_tiss;
		float DO_tiss;
		float DO_mat;
		float DS_mat;
		
		/*consommation*/
		float kS[SZ][SZ];
		float kO[SZ][SZ];

		/* model parameters*/
		float dx;
		float dt;
		float d0;
		float tau;
		int sz;
		
	}Nutr;   

	typedef struct Cells
	{
		/* Cell & State Grids*/
		int Grid[SZ][SZ];
		int LD[SZ][SZ];
		unsigned char state_mat[SZ][SZ];
		float state[SZ*SZ][11];
		/*|1 d_time| 2 cycl dur | 3 chg_timer |4 kS 
		|5 dkS |6 kO |7 dkO|8 row| 9 col| 10 prt|11 bhvr */

		/*limits*/
		float S_prol;
		float S_maint;
		float O_norm;

		/*other variables*/
		int N_Cell; /*all cells (dead or alive) in the model*/
		int N_Dead;
		int N_Live;
		int reac_time; /*time for consumption changes*/
		int n_min; /*cell cycle reaction*/
		int n_pts;
		int max_rad_sq;
	}Cell;

	typedef struct Models
	{
		Cell M_Cell;
		Nutr M_Nutr;
	}Model;


