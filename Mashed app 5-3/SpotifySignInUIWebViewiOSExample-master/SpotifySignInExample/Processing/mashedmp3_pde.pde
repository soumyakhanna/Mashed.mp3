import ddf.minim.*;
import ddf.minim.analysis.*;
import java.util.ArrayList;

Minim minim;
AudioPlayer player;
FFT fft;
ArrayList<JSONObject> playlist = new ArrayList<JSONObject>();
JSONObject mash;

void setup() {
  //app window size
  size(1080, 1920);
  minim = new Minim(this);
  
  // json stuff
  JSONObject obj = new JSONObject();
  obj.setFloat("danceability", 0.735);
  obj.setFloat("energy", 0.578);
  obj.setFloat("key", 5);
  obj.setFloat("loudness", -11.84);
  obj.setFloat("mode", 0); 
  obj.setFloat("speechiness", 0.0461);
  obj.setFloat("acousticness", 0.514);
  obj.setFloat("instrumentalness", 0.0902);
  obj.setFloat("liveness", 0.159);
  obj.setFloat("valence", 0.632);
  obj.setFloat("tempo", 94);
  obj.setString("type", "audio_features");
  obj.setString("id", "06AKEBrKUckW0KREUWRnvT");
  obj.setString("uri", "spotify:track:06AKEBrKUckW0KREUWRnvT");
  obj.setString("track_href", "https://api.spotify.com/v1/tracks/06AKEBrKUckW0KREUWRnvT");
  obj.setString("analysis_url", "https://api.spotify.com/v1/audio-analysis/06AKEBrKUckW0KREUWRnvT");
  obj.setFloat("duration_ms", 255349);
  obj.setFloat("time_signature", 4);

  playlist.add(obj);
  playlist.add(obj);
  playlist.add(obj);
  
  makeSongMashup();
}



//for storing the real and imaginary components of a frequency band
float[] real;
float[] img;

void makeSongMashup() {
    JSONObject mash = playlist.get(0);
    if(playlist.size() > 1) {
       for(int i = 1; i < playlist.size(); i++) {
           mash.setFloat("danceability", mash.getFloat("danceability") + playlist.get(i).getFloat("danceability")/2);
           mash.setFloat("loudness", mash.getFloat("loudness") + playlist.get(i).getFloat("loudness")/2);
           mash.setFloat("acousticness", mash.getFloat("acousticness") + playlist.get(i).getFloat("acousticness")/2);
           mash.setFloat("tempo", mash.getFloat("tempo") + playlist.get(i).getFloat("tempo")/2);
           mash.setFloat("energy", mash.getFloat("energy") + playlist.get(i).getFloat("energy")/2);
           mash.setFloat("instrumentalness", mash.getFloat("instrumentalness") + playlist.get(i).getFloat("instrumentalness")/2);
           mash.setFloat("time_signature", mash.getFloat("time_signature") + playlist.get(i).getFloat("time_signature")/2);
       }
         
    }
    this.mash = mash;
}

void draw() {
  background(#cccccc); // reset the display window
  stroke(200, 100, 0, 70);
  strokeWeight(3); // Thicker
 
  
  
  float constant = 100;
  float danceability = mash.getFloat("danceability")*constant;
  float loudness = abs(mash.getFloat("loudness")*constant);
  float acousticness = mash.getFloat("acousticness")*constant;
  float tempo = mash.getFloat("tempo");
  float energy = mash.getFloat("energy")*constant;
  float instrumentalness = mash.getFloat("instrumentalness")*constant;
  float timesig = mash.getFloat("time_signature"); //<>//
  
  //visualization options
  for (int i = 0; i < 1000; i++) {
    // speed based on time signature
    frameRate(10*timesig);
    
    // color based on tempo
    if(tempo > 96) {
      stroke(0, random(tempo, 255), 0);
      fill(0, random(tempo, 255), 0);
    } else if(tempo > 90) {
      stroke(random(tempo, 255), 0, 0);
      fill(random(tempo, 255), 0, 0);
    } else {
      stroke(0, 0, random(tempo, 255));
      fill(0, 0, random(tempo, 255));
    }
    
    // style based on genre (instrumentals)
    if(instrumentalness < 10) {
      // funky circles
      circle(i * random(10, tempo), //x
      i * danceability, //y
      random(min(acousticness,loudness)/5, max(acousticness,loudness)/3)); //size
      
    } else if(instrumentalness < 30) {
       // trippy math waves
       
       float t = 0;
       beginShape();
       for (float theta = 0; theta <= 2 * PI; theta += 0.001) {
          float rad = r(theta,
            sin(t) * danceability + energy, // a
            cos(t) * energy + acousticness, // b
            sin(t) * 4.0 +loudness, // m
            cos(t) * acousticness + danceability, // n1
            sin(t) * energy + 0.5, // n2
            cos(t) * danceability + 0.5 // n3
          );
          
          float x = rad * cos(theta) * tempo * 4;
          float y = rad * sin(theta) * tempo * 4;
          vertex(x, y);
        }
        
        endShape();
        t += 0.1;
        
    } else if(instrumentalness < 50) {
        // radio static
        line (i*timesig, acousticness+4*i, random(tempo*-1,i + tempo*20), energy * 20);
    } else {
       // tesselations 
       
      float angle = TWO_PI / random(0, timesig);
      beginShape();
      for (float j = 0; j < TWO_PI; j=j += angle) {
        float x = i + cos(j) * tempo;
        float y = i + sin(j) * tempo;
        vertex(random(0,x*2), random(0,y*2));
      }
      endShape(); 
    }
 //<>//
  }
}

float r(float theta, float a, float b, float m, float n1, float n2, float n3) {
  return pow(pow(abs(cos(m * theta / 4.0) / a), n2) + pow(abs(sin(m * theta / 4.0) / b), n3), -1.0 / n1);
}
