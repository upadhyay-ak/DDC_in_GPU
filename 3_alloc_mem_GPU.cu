// on GPU ....
float *dev_input_host;
HANDLE_ERROR( cudaMalloc((float **)&dev_input_host, b * sizeof(float)));
    
float *dev_sine;
float *dev_cosine;
float *dev_op_cosine;
float *dev_op_sine;
        
HANDLE_ERROR( cudaMalloc((float **)&dev_sine, b * sizeof(float)));
HANDLE_ERROR( cudaMalloc((float **)&dev_cosine, b * sizeof(float)));
HANDLE_ERROR( cudaMalloc((float **)&dev_op_sine, b * sizeof(float)));
HANDLE_ERROR( cudaMalloc((float **)&dev_op_cosine, b * sizeof(float)));
    
float *dev_op_cosine_conv;
float *dev_op_sine_conv;
float *dev_lpf_hamming;
        
HANDLE_ERROR( cudaMalloc((float **)&dev_op_sine_conv, b * sizeof(float)));
HANDLE_ERROR( cudaMalloc((float **)&dev_op_cosine_conv, b * sizeof(float)));
HANDLE_ERROR( cudaMalloc((float **)&dev_lpf_hamming, windowLength * sizeof(float)));	
    
float *dev_dec_sine_conv;
float *dev_dec_cosine_conv;
        
HANDLE_ERROR( cudaMalloc((float **)&dev_dec_sine_conv, (c/DF) * sizeof(float)));
HANDLE_ERROR( cudaMalloc((float **)&dev_dec_cosine_conv, (c/DF) * sizeof(float)));
    
Complex *dev_comp;
        
HANDLE_ERROR(cudaMalloc ((Complex **)&dev_comp, (c/DF) * sizeof(Complex)));

// freeing all memory on device (GPU) ....
cudaFree(dev_input_host);
cudaFree(dev_cosine);
cudaFree(dev_sine);
cudaFree(dev_op_sine);
cudaFree(dev_op_cosine);
cudaFree(dev_op_sine_conv);
cudaFree(dev_op_cosine_conv);
cudaFree(dev_comp);
cudaFree(dev_lpf_hamming);
cudaFree(dev_dec_sine_conv);
cudaFree(dev_dec_cosine_conv);
