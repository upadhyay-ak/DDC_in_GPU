// GPU kernel for convoluting sine and cosine multiplication data with filter coefficients with hamming window .... 

#define BLOCK_SIZE 512
#define WINDOW 500

__global__ void conv(float *dev_op_sine, float *dev_op_cosine, float *dev_op_sine_conv, float *dev_op_cosine_conv, float *dev_lpf_hamming, int b, int windowLength){
	int i,l;
       
	__shared__ float dats[BLOCK_SIZE];
	__shared__ float datc[BLOCK_SIZE];
  __shared__ float coeff[WINDOW];

  int threadid = threadIdx.x;	
	int idx = threadIdx.x + blockIdx.x * 256;
        
  float temp1, temp2;
        
	dats[threadid] = dev_op_sine[idx]; 
	datc[threadid] = dev_op_cosine[idx];
       
  if(threadid < windowLength){
    coeff[threadid] = dev_lpf_hamming[threadid];
  }
  
  __syncthreads();
       
  if(threadid < 256){
    temp1 = 0;
    temp2 = 0;
    
    for( i = 0; i < windowLength ; ++i){
      l = windowLength - i;
      
      temp1 += dats[threadid+l] * coeff[i];
      temp2 += datc[threadid+l] * coeff[i];
    }
    
    dev_op_sine_conv[idx] = temp1;
    dev_op_cosine_conv[idx] = temp2;
  }
}
