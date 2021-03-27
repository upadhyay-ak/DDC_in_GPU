// taking command line inputs and assigning them ....
if(argc != 9){
  fprintf(stderr, "USAGE: <windowLength> <sampFreq> <DF in int> <FFT_Size> <int> <sin/cos Freq> <file_name> <loops>\n");
  exit(1);
}
    
int windowLength = atoi(argv[1]);
float sampFreq = atof(argv[2]);
int DF = atoi(argv[3]);
float transFreq = (sampFreq/(2 * DF));
int NX = atoi(argv[4]);
int BATCH = atoi(argv[5]);
float f  = atof(argv[6]);
float s = atof(argv[8]);
int b = ((NX * BATCH) + windowLength);
int c = (NX * BATCH);
    
FILE *file = fopen((argv[7]), "r");

if (file == NULL){
  fprintf(stderr, "Can't open input file ! \n");
  exit(1);
}
