// Create sinc function for filter - Low and High pass filters

enum filterType {LOW_PASS, HIGH_PASS};

float *create1TransSinc(int windowLength, float transFreq, float sampFreq, enum filterType type){
  int n;
  
  // Allocate memory for the window
  float *window = (float *) malloc(windowLength * sizeof(float));
	
  if (window == NULL){
    fprintf(stderr, "create1TransSinc: Could not allocate memory for window\n");
		return NULL;
	}

	if (type != LOW_PASS && type != HIGH_PASS) {
		fprintf(stderr, "create1TransSinc: Bad filter type, should be either LOW_PASS of HIGH_PASS\n");
		return NULL;
	}

	// Calculate the normalised transistion frequency. As transFreq should be
	// less than or equal to sampFreq / 2, ft should be less than 0.5
	float ft = transFreq / sampFreq;

	float m_2 = 0.5 * (windowLength-1);
	int halfLength = windowLength / 2;

	// Set centre tap, if present
	// This avoids a divide by zero
	if (2*halfLength != windowLength){
    float val = 2.0 * ft;

    // If we want a high pass filter, subtract sinc function from a dirac pulse
		if (type == HIGH_PASS) val = 1.0 - val;
    
    window[halfLength] = val;
  }
	
  else if (type == HIGH_PASS){
		fprintf(stderr, "create1TransSinc: For high pass filter, window length must be odd\n");
		return NULL;
	}

	// This has the effect of inverting all weight values
	if (type == HIGH_PASS) ft = -ft;

	// Calculate taps
	// Due to symmetry, only need to calculate half the window
	for (n=0 ; n<halfLength ; n++){
		float val = sin(2.0 * M_PI * ft * (n-m_2)) / (M_PI * (n-m_2));

		window[n] = val;
		window[windowLength-n-1] = val;
	}

	return window;
}


// create window function ....

enum windowType {HAMMING};

float *createWindow(float *in, float *out, int windowLength, enum windowType type){
  // If output buffer has not been allocated, allocate memory now
  if (out == NULL){
    out = (float *) malloc(windowLength * sizeof(float));
    if (out == NULL){
      fprintf(stderr, "Could not allocate memory for window\n");
      return NULL;
    }
  }

  int n;
  int m = windowLength - 1;
  int halfLength = windowLength / 2;

  // Calculate taps
  // Due to symmetry, only need to calculate half the window
  switch (type){
    case HAMMING:
      for (n=0 ; n<=halfLength ; n++){
        float val = 0.54 - 0.46 * cos(2.0 * M_PI * n / m);
        out[n] = val;
        out[windowLength-n-1] = val;
      }
      break;
  }

  // If input has been given, multiply with out
  if (in != NULL){
    for (n = 0 ; n < windowLength ; n++){
      out[n] *= in[n];
    }
  }
  
  return out;
}


// getting filter coefficients for a low pass filter using a sinc function and windowing using hamming window ....
lpf = create1TransSinc(windowLength, transFreq, sampFreq, LOW_PASS);
lpf_hamming = createWindow(lpf, NULL, windowLength, HAMMING);


// generating sine and cosine wave ....
float a = 1, wl;
float w = 2 * M_PI * f;
    
for(int n = 0; n < b; n++){
  wl = w * n;
  cosine[n] = a * cosf(wl/sampFreq);
  sine[n] = a * sinf(wl/sampFreq);
}
