// on CPU ....
signed char *input = (signed char *)malloc(b * sizeof(signed char));	
	
if (input == NULL){
  fprintf(stderr,"Could not allocate memory to input \n");
  exit(1);
}
    
// memory allocation for saving the input array in float ..... 
float *input_host = (float *)malloc(b * sizeof(float));	
    
if (input_host == NULL){
  fprintf(stderr,"Could not allocate memory to input_host \n");
  exit(1);
}
    
//allocating memory on host to store the real part of input FFT
float *real_ip_fft = (float *)malloc((NX/2 +1) * sizeof(float));
    
if (real_ip_fft == NULL){
  fprintf(stderr,"Could not allocate memory to real_ip_fft \n");
  exit (1);
}
    	
//allocating memory on host to store the img part of input FFT
float *img_ip_fft = (float *)malloc((NX/2 +1) * sizeof(float));
    
if (img_ip_fft == NULL){
  fprintf(stderr,"Could not allocate memory to img_ip_fft \n");
  exit (1);
}
    
//allocating memory on host to store the mag of input FFT
float *mag_ip_fft = (float *)malloc((NX/2+1) * sizeof(float));
    
if (mag_ip_fft == NULL){
  fprintf(stderr,"Could not allocate memory to mag_ip_fft \n");
  exit (1);
}
    	
//allocating memory on host to store the phase
float *phase_ip_fft = (float *)malloc((NX/2+1) * sizeof(float));
    
if (phase_ip_fft == NULL){
  fprintf(stderr,"Could not allocate memory to phase_ip_fft \n");
  exit (1);
}
    
float *cosine = (float *)malloc(b * sizeof(float));
    
if (cosine == NULL){
  fprintf(stderr,"Could not allocate memory to cosine \n");
  exit(1);
}
    	
float *sine = (float *)malloc(b * sizeof(float));
    
if (sine == NULL){
  fprintf(stderr,"Could not allocate memory to sine \n");
  exit(1);
}
    	
float *lpf = (float *)malloc(windowLength * sizeof(float));
    
if (lpf == NULL){
  fprintf(stderr,"Could not allocate memory to lpf \n");
  exit (1);
}
    	
float *lpf_hamming = (float *)malloc(windowLength * sizeof(float));

if (lpf_hamming == NULL){
  fprintf(stderr,"Could not allocate memory to lpf_hamming \n");
  exit (1);
}
        
float *sine_conv = (float *)malloc(c * sizeof(float));
    
if (sine_conv == NULL){
  fprintf(stderr,"Could not allocate memory to sine_conv \n");
  exit (1);
}

float *cosine_conv = (float *)malloc(c * sizeof(float));
    
if (cosine_conv == NULL){
  fprintf(stderr,"Could not allocate memory to cosine_conv \n");
  exit (1);
}
    	
float *dec_sine_conv = (float *)malloc((c/DF) * sizeof(float));
    
if (dec_sine_conv == NULL){
  fprintf(stderr,"Could not allocate memory to dec_sine_conv \n");
  exit (1);
}

float *dec_cosine_conv = (float *)malloc((c/DF) * sizeof(float));
    
if (dec_cosine_conv == NULL){
  fprintf(stderr,"Could not allocate memory to dec_cosine_conv \n");
  exit (1);
}
      
//allocating memory on host to store the real
float *real = (float *)malloc((NX/2) * sizeof(float));

if (real == NULL){
  fprintf(stderr,"Could not allocate memory to real \n");
  exit (1);
}
    	
//allocating memory on host to store the img
float *img = (float *)malloc((NX/2) * sizeof(float));
    
if (img == NULL){
  fprintf(stderr,"Could not allocate memory to img \n");
  exit (1);
}
    
//allocating memory on host to store the mag
float *mag = (float *)malloc((NX/2) * sizeof(float));
    
if (mag == NULL){
  fprintf(stderr,"Could not allocate memory to mag \n");
  exit (1);
}
    
//allocating memory on host to store the phase
float *phase = (float *)malloc((NX/2) * sizeof(float));
    
if (phase == NULL){
  fprintf(stderr,"Could not allocate memory to phase \n");
  exit (1);
}

// freeing all memory on host (CPU) ....
free(input);
free(input_host);
free(sine);
free(cosine);
free(lpf);
free(lpf_hamming);
free(real);
free(img);
free(mag);
free(phase);
free(result);
free(ip_fft_result);
free(real_ip_fft);
free(img_ip_fft);
free(mag_ip_fft);
free(phase_ip_fft);
free(sine_conv);
free(cosine_conv);
free(dec_cosine_conv);
free(dec_sine_conv);
