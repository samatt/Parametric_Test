import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import ec.util.*;

PImage[] hands;
UVertexList vl, vl2;
ArrayList<UVertexList> masterList;
UGeo model;
UNav3D nav;
ArrayList<PVector> positions;
ArrayList<PVector> positions2;


void setup() {
  size(1024, 768, OPENGL);
  colorMode(HSB, 255);
  UMB.setPApplet(this);
  nav = new UNav3D();
  vl = new UVertexList();
  vl2 = new UVertexList();
  masterList = new ArrayList<UVertexList>();


  model = new UGeo();

  hands = new PImage[11];
  positions = new ArrayList<PVector>();
  positions2 = new ArrayList<PVector>();

  for (int i=0;i<hands.length;i++) {
    hands[i] = loadImage(i+".png");
  }


  for (int j = 0; j<hands.length;j++) {
    vl.clear();
    vl2.clear();
    positions.clear();
    positions2.clear();
    ArrayList<PVector> tmp = new ArrayList<PVector>();
    for (int x = 0;x<hands[j].width;x++) {
      boolean doit = false;
      boolean isEdge = false;
      for (int y=0;y<hands[j].height;y++) {
        int index = x+y*hands[j].width;
        float r = hue(hands[j].pixels[index]);
        if (r > 10) {
          for (int i=-2;i<2;i++) {
            if (i!=0) {
              if (hue(hands[j].pixels[(x+i)+(y+i)*hands[j].width]) <= 0 || hue(hands[j].pixels[x+(y+i)*hands[j].width]) <= 0 || hue(hands[j].pixels[x+i+y*hands[j].width]) <= 0) {
                isEdge = true;
              }
            }
          }

          if (isEdge) {
            tmp.add(new PVector(x, y, map(r, 0, 255, 0, 1200)));
            isEdge = false;
          }
          doit = true;
        }
      }
    }
      
      vl.add(new UVertex(tmp.get(0)));
      float smallestDistance = 50000;
      int smallestDistanceIndex = 0;
      for (int i=0;i<tmp.size();i++) {
        for (int p=0;p<tmp.size();p++) {
          if (p!=i) {
            if(tmp.get(i).dist(tmp.get(p)) < smallestDistance){
              smallestDistance = tmp.get(i).dist(tmp.get(p));
              smallestDistanceIndex = p;
            }
          }
        }
        PVector newVec = tmp.get(smallestDistanceIndex);
        vl.add(new UVertex(tmp.get(smallestDistanceIndex)));
       // tmp.remove(smallestDistanceIndex);
      }
    
    
    
    //      PVector lowest = new PVector(0, height*2, 0);
    //      PVector highest = new PVector(0, 0, 0);
    //      for (int i=0;i<tmp.size();i++) {
    //        if (tmp.get(i).y < lowest.y)lowest = tmp.get(i);
    //        if (tmp.get(i).y > highest.y)highest = tmp.get(i);
    //      }
    //      if (doit) {
    //        positions.add(lowest);
    //        positions2.add(highest);
    //        doit = false;
    //      }
    //    }
    //
    //    for (int i=0;i<positions.size();i++) {
    //      vl.add(new UVertex(positions.get(i)));
    //    }
    //    for (int i=0;i<positions2.size();i++) {
    //      vl2.add(new UVertex(positions2.get(i)));
    //    }
    //
    //    // vl.get(0).set(tmp);
    //    // vl2.get(vl2.size()-1).set(tmp);
    //    // vl.add(vl2);
    //
    //    for (int i = vl2.size()-1;i>0;i--) {
    //      vl.add(vl2.get(i));
    //    }
        vl.close();
    vl.center(); 
    masterList.add(vl.copy());
  }
  println(masterList.size());
  //vl.close();
//  int biggestListIndex =0;
//  int prevSize = 5000;
//
//  for (int i = 0;i<masterList.size()-1;i++) {
//    int test = max(masterList.get(i).size(), masterList.get(biggestListIndex).size());
//    if (test > prevSize) biggestListIndex = i;
//  }
//
//  println("Biggest index is at: "+ biggestListIndex+ " with size: "+masterList.get(biggestListIndex).size());
//  for (int i = 0;i<masterList.size()-1;i++) {
//    if (masterList.get(i).size() < masterList.get(biggestListIndex).size()) {
//      int diff = abs(masterList.get(biggestListIndex).size() - masterList.get(i).size());
//      for (int j=0;j<diff;j++) {
//        masterList.get(i).add(new UVertex(masterList.get(i).get(masterList.get(i).size()-1)));
//      }
//    }
//    //masterList.get(i).close();
//    println(masterList.get(i).size());
//  }
  // 


  //for (int i = 0;i<masterList.size()-2;i++) {
  //    masterList.get(0).close();
  //    masterList.get(1).close();
  //int x = abs(masterList.get(1).size() - masterList.get(0).size());
  //
  //for( int i =0; i<x; i++){
  //  masterList.get(0).remove(masterList.get(0).size()-1);
  //}
 // model.quadstrip( masterList.get(0), masterList.get(1) );
 // model.quadstrip( masterList.get(1), masterList.get(2) );
 // model.quadstrip( masterList.get(2), masterList.get(3) );
 // model.quadstrip( masterList.get(3), masterList.get(4) );
 // model.quadstrip( masterList.get(4), masterList.get(5) );
 // model.quadstrip( masterList.get(5), masterList.get(6) );
 // model.quadstrip( masterList.get(6), masterList.get(7) );
  //  model.quadstrip( masterList.get(7),masterList.get(8) );
  //  model.quadstrip( masterList.get(8),masterList.get(9) );
  // model.quadstrip( masterList.get(9),masterList.get(10) );


 // model.center();


  //}
}

void draw() {
  background(255);
  colorMode(RGB);
  //translate(width/2,height/2);
  noFill();
  //fill(255, 0, 0, 75);
  //noFill();
  stroke(0, 0, 0, 100);
  translate(width/2, height/2);
  nav.doTransforms();
  // for(UVertexList vv : masterList) vv.draw();
 masterList.get(0).draw();
 // model.draw();
  // masterList.get(0).draw();
}

