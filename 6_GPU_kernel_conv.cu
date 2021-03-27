// GPU kernel for convoluting sine and cosine multiplication data with filter coefficients with hamming window .... 

__global__ void conv(float *dev_op_sine, float *dev_op_cosine, float *dev_op_sine_conv, float *dev_op_cosine_conv, float *dev_lpf_hamming, int b, int windowLength){
  int i,k,l;
	
	int idx = threadIdx.x + blockIdx.x * blockDim.x;
  int stride = blockDim.x * gridDim.x;
  
  float temp1, temp2;
	for(i = idx; i < b; i+=stride){
    temp1 = 0;
		temp2 = 0;
				
		for(k = 0; k < windowLength; k++){	
			l = windowLength - k;
			temp1 +=  dev_op_sine[i+l] * dev_lpf_hamming[k];
      temp2 +=  dev_op_cosine[i+l] * dev_lpf_hamming[k];
    }
        
    dev_op_sine_conv[i] = temp1;
    dev_op_cosine_conv[i] = temp2;
  }
}
