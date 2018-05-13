import ddf.minim.analysis.*;
import ddf.minim.*;
 
Minim       minim;
AudioInput  in;
FFT         fft;

int bandWidth;

int specSize;
int maxSteps;

float[] savedData, currentData;

void prepareBandLib(int presetBandWidth) {
  bandWidth = presetBandWidth;

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  specSize = fft.specSize();

  savedData = new float[specSize/bandWidth];
  currentData = new float[specSize/bandWidth];
  maxSteps = (int)(specSize / bandWidth);
}

/**
 * bandLibLogic
 *
 * Prepares data more or less modular.
 */
void bandLibLogic() {
  // transfer data of last frame
  savedData = currentData;

  // get input data
  fft.forward(in.left);

  // walk through band and save data for each frequency (normalized)
  for(int i = 0; i < maxSteps; i++) {
    float mediumBand;
    mediumBand = 0;

    for (int j = i; j <= i+bandWidth; j++) {
      mediumBand += fft.getBand(i);
    }
    mediumBand = mediumBand / bandWidth;

    currentData[i] = mediumBand;
  }
}