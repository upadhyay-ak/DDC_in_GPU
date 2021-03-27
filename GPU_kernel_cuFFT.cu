// plan and memory for input FFT ....
cufftHandle planip;
cufftComplex *ip_fft;
cudaMalloc((void**)&ip_fft, sizeof(cufftComplex)*(NX/2+1)*BATCH);
	
//Create a 1D FFT plan
cufftPlan1d(&planip, NX, CUFFT_R2C, BATCH);
	
//allocating memory on host to store the copy of fft values calculated in device
Complex *ip_fft_result = (Complex *)malloc((BATCH)*(NX/2+1)*sizeof(Complex));
    

// plan and memory for output FFT ....
cufftHandle plan;
cufftComplex *data;
cudaMalloc((void**)&data, sizeof(cufftComplex)*(NX+1)*(BATCH/DF));
    	
//Create a 1D FFT plan
cufftPlan1d(&plan, NX, CUFFT_C2C, (BATCH/DF));
    
//allocating memory on host to store the copy of fft values calculated in device
Complex *result = (Complex *)malloc((BATCH/DF)*(NX)*sizeof(Complex)); 


// calculating R2C FFT in GPU using CUDA-C for plotting input FFT
cufftExecR2C(planip, (cufftReal*)dev_input_host, ip_fft);

// calculating C2C FFT in GPU using CUDA-C for plotting output FFT
cufftExecC2C(plan, (cufftComplex*)dev_comp, data,CUFFT_FORWARD);


//Destroy the CUFFT plan
cufftDestroy(plan);
cudaFree(data);
cufftDestroy(planip);
cudaFree(ip_fft);
