// GPU kernel function for multiplication of input signal with cosine and sine function .... 

__global__ void multi_sine_cosine(float *dev_sine, float *dev_cosine,  float *dev_op_sine, float *dev_op_cosine, float *dev_input_host){
  int idx = threadIdx.x + blockIdx.x * blockDim.x;
  
  float temp1, temp2;
  temp1 =  dev_input_host[idx] * dev_cosine[idx];
	temp2 = dev_input_host[idx] * dev_sine[idx];
		
  dev_op_cosine[idx] = temp1;
  dev_op_sine[idx] = temp2;
}


// GPU kernel function for assigning LPF values as real(sine multiplication) and complex(cosine multiplication) .... 

__global__ void comp(cufftComplex *dev_comp, float *dev_op_sine_conv, float *dev_op_cosine_conv, int c){
  int i;
  
  int idx = threadIdx.x + blockIdx.x * blockDim.x;
  int stride = blockDim.x * gridDim.x;
  
  for(i = idx; i < c; i+=stride){
    dev_comp[i].x = dev_op_cosine_conv[i];
    dev_comp[i].y = -1*dev_op_sine_conv[i];
  }
}
