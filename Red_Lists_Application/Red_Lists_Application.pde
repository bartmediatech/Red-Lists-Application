/*
Authors: Koen Hagen & Bart van Son
Description: This application provides an alternative for the Rode Lijsten website of the Ministerie van Landbouw
(https://minez.nederlandsesoorten.nl/content/rode-lijsten). All data comes from that website, and from 
https://www.clo.nl/indicatoren/nl1052-aantal-bedreigde-planten--en-diersoorten. We are not responsible for potential errors in the data.
Anyone may use this application for educational purposes. 

This application was made as part of the course Human Computer Interaction at the Leiden Univeristy.

Date: 08-01-2020

*/



int x;
int y;
int diameter = 20;
Table table;
String searchEntry = "";
PImage search_icon;

TableRow row;
int verdwenen;
int ernstigBedreigd ;
int bedreigd;
int kwetsbaar;
int gevoelig;
int totaal;
int nietBedreigd;
int totBedreigd;
int filterSelected = 0;
int filterStatusSelected = 0;

float[] angles = new float[6];

String filter = "";
String filterStatus = "";

Species[] icons;

void setup() {
  fullScreen();
  smooth();

  table = loadTable("Test3.csv", "header");
  noStroke();
  icons = new Species[table.getRowCount()];   

  search_icon = loadImage("search_icon.png");

  for (int i = 0; i < table.getRowCount(); i++) {
    TableRow soortTable = table.getRow(i);
    icons[i] = new Species(soortTable.getString("Nederlandse naam"), soortTable.getString("Klasse"), soortTable.getString("Wetenschappelijke naam"), table.getRow(i).getString("Status"), soortTable.getString("Trend"));
  }
}

void draw() {

  background(60);
  x = width/8;
  y = height/10*9;

  stroke(0);
  strokeWeight(2);
  //status picker
  fill(255, 255, 255); 
  textSize(24);
  text("Filter status:", 10, 300);

  stroke(51); 
  if (mouseX >= 10 && mouseX <= 10+15 && 
    mouseY >= 360 && mouseY <= 360+15) {
    if (mousePressed ) {
      filterStatus = "";
      filterStatusSelected = 0;
    }
    stroke(153);
  }
  if (filterStatusSelected == 0)
    fill(0);
  rect(10, 360, 15, 15);
  fill(255);
  textSize(12);
  text("Alles zien", 30, 360);

  stroke(51); 
  if (mouseX >= 10 && mouseX <= 10+15 && 
    mouseY >= 380 && mouseY <= 380+15) {
    if (mousePressed ) {
      filterStatus = "gevoelig";
      filterStatusSelected = 2;
    }
    stroke(153);
  }
  if (filterStatusSelected == 2)
    fill(0);
  rect(10, 380, 15, 15);
  fill(255);
  textSize(12);
  text("Gevoelig", 30, 380);

  stroke(51); 
  if (mouseX >= 10 && mouseX <= 10+15 && 
    mouseY >= 400 && mouseY <= 400+15) {
    if (mousePressed ) {
      filterStatus = "kwetsbaar";
      filterStatusSelected = 3;
    }
    stroke(153);
  }
  if (filterStatusSelected == 3)
    fill(0);
  rect(10, 400, 15, 15);
  fill(255);
  textSize(12);
  text("Kwetsbaar", 30, 400);

  stroke(51); 
  if (mouseX >= 10 && mouseX <= 10+15 && 
    mouseY >= 420 && mouseY <= 420+15) {
    if (mousePressed ) {
      filterStatus = "bedreigd";
      filterStatusSelected = 4;
    }
    stroke(153);
  }
  if (filterStatusSelected == 4)
    fill(0);
  rect(10, 420, 15, 15);
  fill(255);
  textSize(12);
  text("Bedreigd", 30, 420);

  stroke(51); 
  if (mouseX >= 10 && mouseX <= 10+15 && 
    mouseY >= 440 && mouseY <= 440+15) {
    if (mousePressed ) {
      filterStatus = "ernstig bedreigd";
      filterStatusSelected = 5;
    }
    stroke(153);
  }
  if (filterStatusSelected == 5)
    fill(0);
  rect(10, 440, 15, 15);
  fill(255);
  textSize(12);
  text("Ernstig bedreigd", 30, 440);

  stroke(51); 
  if (mouseX >= 10 && mouseX <= 10+15 && 
    mouseY >= 460 && mouseY <= 460+15) {
    if (mousePressed ) {
      filterStatus = "verdwenen uit nederland";
      filterStatusSelected = 6;
    }
    stroke(153);
  }
  if (filterStatusSelected == 6)
    fill(0);
  rect(10, 460, 15, 15);
  fill(255);
  textSize(12);
  text("Verdwenen", 30, 460);

  //Trend picker
  fill(255, 255, 255); 
  textSize(24);
  text("Filter trend:", 10, 490);
  stroke(51); 
  if (mouseX >= 10 && mouseX <= 10+15 && 
    mouseY >= 530 && mouseY <= 530+15) {
    if (mousePressed ) {
      filter = "";
      filterSelected = 0;
    }
    stroke(153);
  }
  if (filterSelected == 0)
    fill(0);
  rect(10, 530, 15, 15);
  fill(255);
  textSize(12);
  text("Alles zien", 30, 530);

  stroke(51); 
  if (mouseX >= 10 && mouseX <= 10+15 && 
    mouseY >= 550 && mouseY <= 550+15) {
    if (mousePressed ) {
      filter = "onbekend";
      filterSelected = 1;
    }
    stroke(153);
  }
  if (filterSelected == 1)
    fill(0);
  rect(10, 550, 15, 15);
  fill(255);
  text("Trend onbekend", 30, 550);
  stroke(51); 

  if (mouseX >= 10 && mouseX <= 10+15 && 
    mouseY >= 570 && mouseY <= 570+15) {
    if (mousePressed ) {
      filter = "maximaal afgenomen";
      filterSelected = 2;
    }
    stroke(153);
  }
  if (filterSelected == 2)
    fill(0);
  rect(10, 570, 15, 15);
  fill(255);
  text("Maximaal afgenomen", 30, 570);
  stroke(51);

  if (mouseX >= 10 && mouseX <= 10+15 && 
    mouseY >= 590 && mouseY <= 590+15) {
    if (mousePressed ) {
      filter = "zeer sterk afgenomen";
      filterSelected = 3;
    }
    stroke(153);
  }
  if (filterSelected == 3)
    fill(0);
  rect(10, 590, 15, 15);
  fill(255);
  text("Zeer sterk afgenomen", 30, 590);
  stroke(51);

  if (mouseX >= 10 && mouseX <= 10+15 && 
    mouseY >= 610 && mouseY <= 610+15) {
    if (mousePressed ) {
      filter = "sterk afgenomen";
      filterSelected = 4;
    }
    stroke(153);
  }
  if (filterSelected == 4)
    fill(0);
  rect(10, 610, 15, 15);
  fill(255);
  text("Sterk afgenomen", 30, 610);
  stroke(51);

  if (mouseX >= 10 && mouseX <= 10+15 && 
    mouseY >= 630 && mouseY <= 630+15) {
    if (mousePressed ) {
      filter = "matig afgenomen";
      filterSelected = 5;
    }
    stroke(153);
  }
  if (filterSelected == 5)
    fill(0);
  rect(10, 630, 15, 15);
  fill(255);
  text("Matig afgenomen", 30, 630);
  stroke(51);

  if (mouseX >= 10 && mouseX <= 10+15 && 
    mouseY >= 650 && mouseY <= 650+15) {
    if (mousePressed) {
      filter = "niet afgenomen";
      filterSelected = 6;
    }
    stroke(153);
  }
  if (filterSelected == 6)
    fill(0);
  rect(10, 650, 15, 15);
  fill(255);
  text("Niet afgenomen", 30, 650);
  stroke(51);

  if (mouseX >= 10 && mouseX <= 10+15 && 
    mouseY >= 670 && mouseY <= 670+15) {
    if (mousePressed ) {
      filter = "stabiel of toegenomen";
      filterSelected = 7;
    }
    stroke(153);
  }
  if (filterSelected == 7)
    fill(0);
  rect(10, 670, 15, 15);
  fill(255);
  text("Stabiel of toegenomen", 30, 670);
  stroke(51);



  //Search bar
  textAlign(LEFT, TOP);
  textSize(32);
  image(search_icon, 70, 15, 40, 40);
  if (mousePressed && mouseX >= 70 && mouseX <= 140+width-248 && 
    mouseY >= 15 && mouseY <= 15+40) {
    stroke(153);
  }
  fill(100, 100, 100, 100);
  rect(140, 15, width-248, 40);
  fill(#FFFFFF);
  text(searchEntry, 150, 15); 
  textSize(12);

  println(searchEntry);

  //De namen van de dieren onder de kolommen
  if (searchEntry.equals("") && filter.equals("") && filterStatus.equals("")) {
    noStroke();
    pushMatrix();
    translate(130, 870);
    rotate(PI/-4);
    fill(0, 255, 0, 150);
    rect(-5, 0, 70, 20);
    fill(255, 255, 255);
    text("Amfibieen", 0, 0);
    popMatrix();

    pushMatrix();
    translate(190, 860);
    rotate(PI/-4);
    fill(0, 0, 255, 150);
    rect(-5, 0, 50, 20);
    fill(255, 255, 255);
    text("Vogels", 0, 0);
    popMatrix();

    pushMatrix();
    translate(265, 860);
    rotate(PI/-4);
    fill(255, 255, 0, 150);
    rect(-5, 0, 50, 20);
    fill(255, 255, 255);
    text("Vissen", 0, 0);
    popMatrix();

    pushMatrix();
    translate(375, 850);
    rotate(PI/-4);
    fill(255, 0, 0, 150);
    rect(-5, 0, 40, 20);
    fill(255, 255, 255);
    text("Bijen", 0, 0);
    popMatrix();

    pushMatrix();
    translate(445, 870);
    rotate(PI/-4);
    fill(255, 0, 255, 150);
    rect(-5, 0, 73, 17);
    fill(255, 255, 255);
    text("Zoogdieren", 0, 0);
    popMatrix();

    pushMatrix();
    translate(475, 875);
    rotate(PI/-4);
    fill(255, 255, 255, 200);
    rect(-5, 0, 80, 17);
    fill(0, 0, 0);
    text("Sprinkhanen", 0, 0);
    popMatrix();

    pushMatrix();
    translate(525, 855);
    rotate(PI/-4);
    fill(120, 0, 0, 150);
    rect(-5, 0, 50, 17);
    fill(255, 255, 255);
    text("Libellen", 0, 0);
    popMatrix();

    pushMatrix();
    translate(540, 875);
    rotate(PI/-4);
    fill(0, 120, 120, 150);
    rect(-5, 0, 75, 17);
    fill(255, 255, 255);
    text("Platwormen", 0, 0);
    popMatrix();

    pushMatrix();
    translate(580, 875);
    rotate(PI/-4);
    fill(0, 0, 120, 150);
    rect(-5, 0, 75, 17);
    fill(255, 255, 255);
    text("Weekdieren", 0, 0);
    popMatrix();

    pushMatrix();
    translate(640, 875);
    rotate(PI/-4);
    fill(15, 150, 250, 150);
    rect(-5, 0, 80, 17);
    fill(255, 255, 255);
    text("Kokerjuffers", 0, 0);
    popMatrix();

    pushMatrix();
    translate(720, 855);
    rotate(PI/-4);
    fill(120, 120, 0, 150);
    rect(-5, 0, 50, 17);
    fill(255, 255, 255);
    text("Haften", 0, 0);
    popMatrix();

    pushMatrix();
    translate(750, 875);
    rotate(PI/-4);
    fill(0, 255, 255, 150);
    rect(-5, 0, 80, 17);
    fill(255, 255, 255);
    text("Dagvlinders", 0, 0);
    popMatrix();

    pushMatrix();
    translate(795, 875);
    rotate(PI/-4);
    fill(120, 0, 120, 150);
    rect(-5, 0, 80, 17);
    fill(255, 255, 255);
    text("Steenvliegen", 0, 0);
    popMatrix();

    pushMatrix();
    translate(840, 865);
    rotate(PI/-4);
    fill(0, 120, 0, 150);
    rect(-5, 0, 60, 17);
    fill(255, 255, 255);
    text("Reptielen", 0, 0);
    popMatrix();
  }

  //Icons
  for (int i=0; i < icons.length; i++) {
    print(filterStatus);
    if ( ( icons[i].getTrend().toLowerCase().equals(filter) || filter.equals("")) && ( icons[i].getStatus().toLowerCase().equals(filterStatus) || filterStatus.equals("")) ) {
      if (icons[i].getName().toLowerCase().contains(searchEntry.toLowerCase()) || icons[i].getScientificName().toLowerCase().contains(searchEntry.toLowerCase()) || icons[i].getTaxonomy().toLowerCase().contains(searchEntry.toLowerCase()) ) {
        icons[i].drawTarget(x, y);

        //Locatie volgende icoontje
        y = y-diameter-2;
        if (y<80 && icons[i].getTaxonomy().equals(icons[i+1].getTaxonomy())) {
          x= x+diameter+2;
          y = height/10*9;
        }
      }
    }
    if (i+1 < icons.length && !icons[i].getTaxonomy().equals(icons[i+1].getTaxonomy())) {

      x= x+diameter+10;
      y = height/10*9;
    }
  }

  // bronvermelding
  textSize(8);
  fill(255);
  text("Data van: Staatscourant, Ministerie van Landbouw, Natuur en Voedselkwaliteit", width - 350, height - 20);
}


void keyPressed() {
  if (key >= 'A' && key <= 'Z' || key >= 'a' && key <= 'z' || key == ' ') {
    searchEntry = searchEntry+key;
  } else if (key == BACKSPACE && searchEntry != "") {
    if (!searchEntry.equals("") ) {
      searchEntry = searchEntry.substring(0, searchEntry.length() - 1);
    }
  }
}
