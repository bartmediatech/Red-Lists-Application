
public class Species {
  String name;
  String scientificName;
  String taxonomy;
  String status;
  String trend;
  boolean mouseOver;

  Species(String name_, String taxonomy_, String scientificName_, String status_, String trend_) {
    //positionX = positionX_;
    //positionY = positionY_;
    name = name_;
    scientificName = scientificName_;
    taxonomy = taxonomy_;
    status = status_;
    trend = trend_;
  }

  String getName() {
    return name;
  }

  String getTaxonomy() {
    return taxonomy;
  }

  String getScientificName() {
    return scientificName;
  }

  String getStatus() {
    return status;
  }
  
  String getTrend() {
    return trend;
  }
  
  void mousePressed() {
  }

  void drawTarget(int positionX, int positionY) {
    stroke(0);
    strokeWeight(2);

    //Kies kleur/icoontje
    if (taxonomy.equals("Bijen")) {
      fill(255, 0, 0);
    } else if ( taxonomy.equals("Amfibieën")) {
      fill(0, 255, 0);
    } else if (taxonomy.equals("Kokerjuffers")) {
      fill (15, 150, 250);
    } else if (taxonomy.equals("Vogels")) {
      fill (0, 0, 255);
    } else if (taxonomy.equals("Zoogdieren")) {
      fill (255, 0, 255);
    } else if (taxonomy.equals("Vissen")) {
      fill (255, 255, 0);
    } else if (taxonomy.equals("Dagvlinders")) {
      fill (0, 255, 255);
    } else if (taxonomy.equals("Sprinkhanen en krekels")) {
      fill (255, 255, 255);
    } else if (taxonomy.equals("Haften")) {
      fill (120, 120, 0);
    } else if (taxonomy.equals("Platwormen")) {
      fill (0, 120, 120);
    } else if (taxonomy.equals("Steenvliegen")) {
      fill (120, 0, 120);
    } else if (taxonomy.equals("Libellen")) {
      fill (120, 0, 0);
    } else if (taxonomy.equals("Reptielen")) {
      fill (0, 120, 0);
    } else if (taxonomy.equals("Weekdieren")) {
      fill (0, 0, 120);
    }



    //Plaats icoontje
    stroke(0);
    strokeWeight(1);
    ellipse(positionX, positionY, diameter, diameter);

    mouseOver=positionX-diameter/2<=mouseX&&mouseX<=positionX+diameter/2 &&
      positionY-diameter/2<=mouseY&&mouseY<=positionY+diameter/2;

    if (mouseOver) {
      table = loadTable("aantallen_aangepast_geordend.csv", "header");

      for (int i = 0; i < table.getRowCount(); i++) {
        if (table.getRow(i).getString("Nederlandse naam").equals(taxonomy)) {
          row = table.getRow(i);
          verdwenen = row.getInt("Verdwenen");
          ernstigBedreigd = row.getInt("Ernstig bedreigd");
          bedreigd = row.getInt("Bedreigd");
          kwetsbaar = row.getInt("Kwetsbaar");
          gevoelig = row.getInt("Gevoelig");
          nietBedreigd = row.getInt("Niet bedreigd");
          totaal = row.getInt("Totaal");
          totBedreigd = row.getInt("Totaal bedreigd");
          float tot = 360.0000000/(verdwenen + ernstigBedreigd + bedreigd + kwetsbaar + gevoelig + nietBedreigd);

          angles[0] = verdwenen*tot;
          angles[1] = ernstigBedreigd*tot;
          angles[2] = bedreigd*tot;
          angles[3] = kwetsbaar*tot;
          angles[4] = gevoelig*tot;
          angles[5] = nietBedreigd*tot;
        }
      }

      //legenda voor chart
      fill(#FFFFFF);
      text("Verdwenen: " + (double) Math.ceil(angles[0]/3.6*10)/10 + "%\nErnstig bedreigd: " + 
        (double) Math.ceil(angles[1]/3.6*10)/10 + "%\nBedreigd: " + (double) Math.ceil(angles[2]/3.6*10)/10 + "%\nKwetsbaar: " + 
        (double) Math.ceil(angles[3]/3.6*10)/10 + "%\nGevoelig: " + (double) Math.ceil(angles[4]/3.6*10)/10 + "%\nNiet bedreigd: " + 
        (double) Math.ceil(angles[5]/3.6*10)/10 + "%", width-150, 300);

      noStroke();
      fill (#761901);
      rect(width-170, 300, 15, 15);

      fill (#B82601);
      rect(width-170, 320, 15, 15);

      fill (#C44D2F);
      rect(width-170, 340, 15, 15);

      fill (#D1745D);
      rect(width-170, 360, 15, 15);

      fill (#E5B0A2);
      rect(width-170, 380, 15, 15);

      fill (#74F927);
      rect(width-170, 400, 15, 15);

      //PieChart
      textSize(34);
      fill(#FFFFFF);
      text(taxonomy + " (" + totBedreigd+ ")", width-450, 220, 300, 500);

      float lastAngle = 0;
      for (int i = 0; i < angles.length; i++) {
        switch(i) {
        case 0:
          fill (#761901);
          break;
        case 1:
          fill (#B82601);
          break;
        case 2:
          fill (#C44D2F);
          break;
        case 3:
          fill (#D1745D);
          break;
        case 4:
          fill (#E5B0A2);
          break;
        case 5:
          fill (#74F927);
          break;
        }

        arc(width/4*3, height/2, 250, 250, lastAngle, lastAngle+radians(angles[i]));  
        lastAngle += radians(angles[i]);
      }



      //NAAM , STATUS & TREND
      fill(#FFFFFF);
      textSize(20);
      text(name+ "\n(" + scientificName + ")" + "\nStatus: " +status+"\nTrend: "+trend, width-450, height-200, 400, 200);


      //TOOLTIP
      fill(0, 100, 100);
      textSize(15);
      textAlign(LEFT, TOP);
      if (textWidth(name)>textWidth(scientificName)) {
        rect(positionX-textWidth(name)-diameter-5, positionY-diameter*3, textWidth(name)+diameter/2+3, diameter*2+5, 3);     
        fill(255, 255, 255);
        text(name+"\n"+scientificName+"", positionX-textWidth(name)-diameter, positionY-diameter*3);
      } else {
        rect(positionX-textWidth(scientificName)-diameter-5, positionY-diameter*3, textWidth(scientificName)+diameter/2+5, diameter*2+5, 3); 
        fill(255, 255, 255);
        text(name+"\n"+scientificName, positionX-textWidth(scientificName)-diameter, positionY-diameter*3);
      }
    }
  }
}
