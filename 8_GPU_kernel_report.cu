// defining grid and block dimensions

dim3 block(512);
dim3 grid(((NX/512)+1)*(BATCH));

// doing multiplication with sine and cosine wave ....

cudaEvent_t start, stop; // defining the event variables
        
HANDLE_ERROR(cudaEventCreate(&start)); // creating events
HANDLE_ERROR(cudaEventCreate(&stop));

HANDLE_ERROR( cudaEventRecord( start, 0 )); // starting event
        
multi_sine_cosine<<<grid,block>>>(dev_sine, dev_cosine, dev_op_sine, dev_op_cosine, dev_input_host);
        
HANDLE_ERROR( cudaEventRecord( stop, 0 )); // stopping the event
HANDLE_ERROR( cudaEventSynchronize( stop)); // synchronizing the timings
    	
float elapsedtime; // defining elapsed time
HANDLE_ERROR( cudaEventElapsedTime( &elapsedtime, start, stop )); // elapsed time

x += elapsedtime;

HANDLE_ERROR( cudaEventDestroy( start )); // destroying events start and stop
HANDLE_ERROR( cudaEventDestroy( stop ));


// doing LPF by using FIR filter using hamming window ....
      
HANDLE_ERROR(cudaMemcpy(dev_lpf_hamming, lpf_hamming, windowLength * sizeof(float), cudaMemcpyHostToDevice));
        
cudaEvent_t start_conv, stop_conv; // defining the event variables
        
HANDLE_ERROR(cudaEventCreate(&start_conv)); // creating events
HANDLE_ERROR(cudaEventCreate(&stop_conv));
        
HANDLE_ERROR( cudaEventRecord( start_conv, 0 )); // starting event
        
conv<<<grid,block>>>(dev_op_sine, dev_op_cosine, dev_op_sine_conv, dev_op_cosine_conv, dev_lpf_hamming, b, windowLength);
        
HANDLE_ERROR( cudaEventRecord( stop_conv, 0 )); // stopping the event
HANDLE_ERROR( cudaEventSynchronize( stop_conv)); // synchronizing the timings
    	
float elapsedtime_conv; // defining elapsed time
HANDLE_ERROR( cudaEventElapsedTime( &elapsedtime_conv, start_conv, stop_conv )); // elapsed time
    	
y += elapsedtime_conv;
        
HANDLE_ERROR( cudaEventDestroy( start_conv )); // destroying events start and stop
HANDLE_ERROR( cudaEventDestroy( stop_conv ));


// make complex values ....
cudaEvent_t start_comp, stop_comp; // defining the event variables
        
HANDLE_ERROR(cudaEventCreate(&start_comp)); // creating events
HANDLE_ERROR(cudaEventCreate(&stop_comp));
        
HANDLE_ERROR( cudaEventRecord( start_comp, 0 )); // starting event
        
comp<<<grid,block>>>(dev_comp, dev_dec_sine_conv, dev_dec_cosine_conv, (c/DF));
        
HANDLE_ERROR( cudaEventRecord( stop_comp, 0 )); // stopping the event
HANDLE_ERROR( cudaEventSynchronize( stop_comp)); // synchronizing the timings
    	
float elapsedtime_comp; // defining elapsed time
HANDLE_ERROR( cudaEventElapsedTime( &elapsedtime_comp, start_comp, stop_comp )); // elapsed time
    	
z += elapsedtime_comp;
        
HANDLE_ERROR( cudaEventDestroy( start_comp )); // destroying events start and stop
HANDLE_ERROR( cudaEventDestroy( stop_comp ));
