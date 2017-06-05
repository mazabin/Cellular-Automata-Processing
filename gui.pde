import g4p_controls.*;
public void startM_clicked(GButton source, GEvent event) {  
  println("Simulation started with parameters:\nNumber of seeds:");
  println((seedNumberInPercent * (width/cellSize) * (height/cellSize))/100+"\n");
  println("Seeds in percent: " + seedNumberInPercent);
  println("\nNumber of iterations: " + maxIterations);
  println("\nSeed draw method: " + seedDrawMethod);
  if(withRadium)
    println("\nRadium of seed: " + radium);
  println("\nChosen simulation: " + simulationType);

  startSimulation();
  println("\n");
}

public void stopM_clicked(GButton source, GEvent event) {
  println("Simulation stopped after " + iterationCnt + " iterations.");
  stopSimulation();
}

public void pauseM_clicked(GButton source, GEvent event) { 
  println("Pause active\n");
  pauseSimulation();
}

public void options_clicked(GButton source, GEvent event) {
  option_window.setVisible(true);
}

public void clear_clicked(GButton source, GEvent event) {
  clearBoard();
}

synchronized public void win_draw1(PApplet appc, GWinData data) {
  appc.background(225,231,238);
}

public void slider_seed_changed(GSlider source, GEvent event) {
  seedNumberInPercent = slider_seed.getValueI();
  txt_seeds.setText(Integer.toString(seedNumberInPercent));
  initializeSeeds();
}

public void rbtn_VN_clicked(GOption source, GEvent event) { 
  neighborhood = "vn";
}

public void rbtn_moore_clicked(GOption source, GEvent event) { 
  neighborhood = "moore";
}
public void rbtn_hex_left_clicked(GOption source, GEvent event) {
  neighborhood = "hexl";
}

public void rbtn_hex_right_clicked(GOption source, GEvent event) {
  neighborhood = "hexr";
}

public void rbtn_hex_random_clicked(GOption source, GEvent event) {
  neighborhood = "hexra";
}

public void rbtn_penta_random_clicked(GOption source, GEvent event) {
  neighborhood = "penta";
}

public void rbtn_non_periodical_clicked(GOption source, GEvent event) { 
  bc = 2;
} 

public void rbtn_periodical_clicked(GOption source, GEvent event) { 
  bc = 1;
} 

public void rbtn_random_clicked(GOption source, GEvent event) {
  seedDrawMethod = "random";
  if(rbtn_random.isSelected()){
    chkbx_radium.setEnabled(true);
    chkbx_radium.setSelected(true);
  }
  else{
    chkbx_radium.setEnabled(false);
  }
  txt_radium.setEnabled(chkbx_radium.isSelected());
  initializeSeeds();
}

public void rbtn_evenly_clicked(GOption source, GEvent event) { 
  seedDrawMethod = "evenly";
  chkbx_radium.setEnabled(rbtn_random.isSelected());
  chkbx_radium.setSelected(rbtn_random.isSelected());
  txt_radium.setEnabled(chkbx_radium.isSelected());
  initializeSeeds();
}

public void rbtn_mouse_clicked(GOption source, GEvent event) { 
  seedDrawMethod = "mouse";
  chkbx_radium.setEnabled(rbtn_random.isSelected());
  chkbx_radium.setSelected(rbtn_random.isSelected());
  txt_radium.setEnabled(chkbx_radium.isSelected());
} 

public void chkbx_mouse_changed(GCheckbox source, GEvent event) { 
  mouseEnabled = !mouseEnabled;
} 

public void txt_radium_changed(GTextField source, GEvent event) { 
  try{
    int r = int(txt_radium.getText());
    if(r<25)
      radium = r;
    else
    println("Promień musi być mniejszy niż 25!");
  }
  catch(Exception e){
    println("Not a number!");
  }
} 

public void slider_height_changed(GSlider source, GEvent event) {
  newHeight = slider_height.getValueI();
  txt_height.setText(Integer.toString(newHeight));
} 

public void slider_width_changed(GSlider source, GEvent event) {
  newWidth = slider_width.getValueI();
  txt_width.setText(Integer.toString(newWidth));
} 

public void rbtn_cell5_clicked(GOption source, GEvent event) { 
  cellSize = 5;
} 

public void rbtn_cell10_clicked(GOption source, GEvent event) {
  cellSize = 10;
}

public void rbtn_cell15_clicked(GOption source, GEvent event) { 
  cellSize = 15;
}

public void rbtn_cell20_clicked(GOption source, GEvent event) { 
  cellSize = 20;
}

public void rbtn_cell25_clicked(GOption source, GEvent event) {
  cellSize = 25;
}

public void slider_iteration_changed(GSlider source, GEvent event) { 
  maxIterations = slider_iteration.getValueI();
  txt_iteration.setText(Integer.toString(maxIterations));
} 

public void txt_height_changed(GTextField source, GEvent event) { 
  try{
    int h = int(txt_height.getText());
    if(h >= 100 && h <= 1200){
      newHeight = h;
      slider_height.setValue(h);
    }
    else
      println("Wysokość okna musi zawierać się między 100 a 1200!");

  }
  catch(Exception e){
    println("Wpisana wartość nie jest liczbą.");
  }
}

public void txt_width_changed(GTextField source, GEvent event) {
  try{
    int w = int(txt_width.getText()); 
    if(w <= 1200 && w >= 100){
      newWidth = w;
      slider_width.setValue(w);
    }
    else
      println("Szerokość okna musi zawierać się między 100 a 1200!");
  }
  catch(Exception e){
    println("Wpisana wartość nie jest liczbą.");
  }
} 
public void chkbx_radium_changed(GCheckbox source, GEvent event) {  
  txt_radium.setTextEditEnabled(chkbx_radium.isSelected());
  withRadium = !withRadium;
  chkbx_radium.setSelected(withRadium);
}

public void txt_iteration_changed(GTextField source, GEvent event) { 
  try{
    int iteration = int(txt_iteration.getText());
    if(iteration <= 1000 && iteration >= 20)
      {
        slider_iteration.setValue(iteration);
        if(maxIterations!=iteration)
          maxIterations = iteration;      
      }
      else if(iteration > 1000) {
        slider_iteration.setValue(1000);
        txt_iteration.setText(Integer.toString(1000));
        maxIterations = 1000;
      }
      else if(iteration < 20){
        slider_iteration.setValue(20);
        txt_iteration.setText(Integer.toString(20));
        maxIterations = 20;
      }
  }
  catch(Exception e){
    println("Not a number!");
  }
} 

public void txt_seeds_changed(GTextField source, GEvent event) {  
  int seeds;
  try{
    seeds = int(txt_seeds.getText());
    if(seeds <=100 && seeds >=0)
      {
        if(seeds == 0)
          println("Symulacja nie zostanie wykonana dla zerowej ilości ziaren. Upewnij się, że na planszy znajdują się ziarna.");
        slider_seed.setValue(seeds);
        if(seedNumberInPercent!=seeds)
        {
          seedNumberInPercent = seeds;
          initializeSeeds();
         }
     }
     else{
       if(seeds > 100){
           slider_seed.setValue(100);
           txt_seeds.setText(Integer.toString(100));
           seedNumberInPercent = 100;
           initializeSeeds();
         }
         else if(seeds < 0){
           slider_seed.setValue(0); 
           txt_seeds.setText(Integer.toString(0));
           seedNumberInPercent = 0;
           initializeSeeds();
         }
      println("Procentowa ilość ziaren musi być z przedziału 0-100");
     }
  }
  catch(Exception e){
  println("Not a number!");
  }
} 

public void help_clicked(GButton source, GEvent event) { 
  help_window.setVisible(true);
}

public void resize_clicked(GButton source, GEvent event) { 
  resized = true;
}

public void dl_simulation_chosen(GDropList source, GEvent event) {
  int sim = dl_simulation.getSelectedIndex();
  String s = simulationType;
  if(sim == 0){
    simulationType = "wolfram";
    simulationName = " - Reguły Wolframa 1D";
  }
  if(sim == 1){
    simulationType = "conway";
    simulationName = " - Gra w życie Conwaya";
  }
  if(sim == 2){
    simulationType = "naive";
    simulationName = " - Naiwny rozrost ziaren";
  }
  if(sim == 3){
    simulationType = "monte";
    simulationName = " - Rozrost ziaren metodą Monte Carlo";
  }
  if(sim == 4){
    simulationType = "drx";
    simulationName = " - Reksrystalizacja dynamiczna";
  }
  if(!s.equals(simulationType)){
    initializeSeeds();
    surface.setTitle(windowName + simulationName); 
  }
}

public void tickIteration(){
  iterationIndicatorN.setText(Integer.toString(iterationCnt) + "/" + txt_iteration.getText());
  simulationInformation.setText(information);
  //simulationInformation.resizeToFit(true, false);
}


//Okno pomocy
synchronized public void win_draw2(PApplet appc, GWinData data) { //_CODE_:help_window:934744:
  appc.background(80);

}



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle(windowName + simulationName);
  
  option_window = GWindow.getWindow(this, "Ustawienia symulacji", 0, 0, 700, 800, JAVA2D);
  option_window.noLoop();
  option_window.addDrawHandler(this, "win_draw1");
  option_window.setVisible(true);
  
  help_window = GWindow.getWindow(this, "Pomoc", 0, 0, 1220, 800, JAVA2D);
  help_window.noLoop();
  help_window.setActionOnClose(G4P.CLOSE_WINDOW);
  help_window.addDrawHandler(this, "win_draw2");
  help_window.setVisible(false);
  
  //SYM_CONTROL
  lbl_simulation_controls = new GLabel(option_window, 370, 430, 310, 30);
  lbl_simulation_controls.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_simulation_controls.setText("Kontrola symulacji");
  lbl_simulation_controls.setTextBold();
  lbl_simulation_controls.setOpaque(true);  
    btn_start = new GButton(option_window, 370, 520, 310, 30);
    btn_start.setText("Rozpocznij symulację");
    btn_start.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    btn_start.addEventHandler(this, "startM_clicked");  
      btn_pause = new GButton(option_window, 370, 560, 310, 30);
      btn_pause.setText("Zatrzymaj symulację");
      btn_pause.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
      btn_pause.addEventHandler(this, "pauseM_clicked");
    btn_clear = new GButton(option_window, 370, 480, 310, 30);
    btn_clear.setText("Wyczyść planszę");
    btn_clear.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
    btn_clear.addEventHandler(this, "clear_clicked");
      btn_end = new GButton(option_window, 370, 600, 310, 30);
      btn_end.setText("Zakończ symulację");
      btn_end.setLocalColorScheme(GCScheme.RED_SCHEME);
      btn_end.addEventHandler(this, "stopM_clicked");
        btn_help = new GButton(option_window, 370, 640, 310, 30);
        btn_help.setText("Otwórz pomoc");
        btn_help.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
        btn_help.addEventHandler(this, "help_clicked");
      btn_startM = new GButton(this, 700, 20, 80, 30);
      btn_startM.setText("Start");
      btn_startM.setTextBold();
      btn_startM.setLocalColorScheme(GCScheme.GREEN_SCHEME);
      btn_startM.addEventHandler(this, "startM_clicked");
        btn_stopM = new GButton(this, 700, 120, 80, 30);
        btn_stopM.setText("Stop");
        btn_stopM.setTextBold();
        btn_stopM.setLocalColorScheme(GCScheme.RED_SCHEME);
        btn_stopM.addEventHandler(this, "stopM_clicked");
      btn_pauseM = new GButton(this, 700, 70, 80, 30);
      btn_pauseM.setText("Pauza");
      btn_pauseM.setTextBold();
      btn_pauseM.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
      btn_pauseM.addEventHandler(this, "pauseM_clicked");
        btn_options = new GButton(this, 700, 170, 80, 30);
        btn_options.setText("Opcje");
        btn_options.setTextBold();
        btn_options.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
        btn_options.addEventHandler(this, "options_clicked");  

  //SIMULATION INFORMATION
  //Glabel( this, x_position, y_position, width, height)  
  iterationIndicator = new GLabel(this, 650, 560, 70, 20);
  iterationIndicator.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  iterationIndicator.setText("Iteracja:");
  iterationIndicator.setOpaque(true);
  iterationIndicator.setTextBold();

  iterationIndicatorN = new GLabel(this, 720, 560, 70, 20);
  iterationIndicatorN.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  iterationIndicatorN.setText(Integer.toString(iterationCnt));
  iterationIndicatorN.setOpaque(true);
  iterationIndicatorN.setTextBold();  

  simulationInformation = new GLabel(this, 20, 560, 630, 20);
  simulationInformation.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  simulationInformation.setText(information);
  simulationInformation.setTextBold();
  simulationInformation.setOpaque(true);
  
  //NEIGHBOURHOODS
  lbl_neighborhood = new GLabel(option_window, 20, 120, 140, 20);
  lbl_neighborhood.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_neighborhood.setText("Sąsiedztwo");
  lbl_neighborhood.setTextBold();
  lbl_neighborhood.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  lbl_neighborhood.setOpaque(false);
    tog_group_neighborhood = new GToggleGroup();  
        rbtn_VN = new GOption(option_window, 20, 180, 140, 30);
        rbtn_VN.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
        rbtn_VN.setText("Von Neumanna");
        rbtn_VN.setLocalColorScheme(GCScheme.CYAN_SCHEME);
        rbtn_VN.setOpaque(false);
        rbtn_VN.addEventHandler(this, "rbtn_VN_clicked");
          rbtn_moore = new GOption(option_window, 20, 150, 140, 30);
          rbtn_moore.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
          rbtn_moore.setText("Moore'a");
          rbtn_moore.setLocalColorScheme(GCScheme.CYAN_SCHEME);
          rbtn_moore.setOpaque(false);
          rbtn_moore.addEventHandler(this, "rbtn_moore_clicked");
        rbtn_hex_left = new GOption(option_window, 20, 210, 140, 30);
        rbtn_hex_left.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
        rbtn_hex_left.setText("Sześciokątne (lewe)");
        rbtn_hex_left.setLocalColorScheme(GCScheme.CYAN_SCHEME);
        rbtn_hex_left.setOpaque(false);
        rbtn_hex_left.addEventHandler(this, "rbtn_hex_left_clicked");
          rbtn_hex_right = new GOption(option_window, 20, 240, 140, 30);
          rbtn_hex_right.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
          rbtn_hex_right.setText("Sześciokątne (prawe)");
          rbtn_hex_right.setLocalColorScheme(GCScheme.CYAN_SCHEME);
          rbtn_hex_right.setOpaque(false);
          rbtn_hex_right.addEventHandler(this, "rbtn_hex_right_clicked");    
        rbtn_hex_random = new GOption(option_window, 20, 270, 140, 30);
        rbtn_hex_random.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
        rbtn_hex_random.setText("Sześciokątne (losowe)");
        rbtn_hex_random.setLocalColorScheme(GCScheme.CYAN_SCHEME);
        rbtn_hex_random.setOpaque(false);
        rbtn_hex_random.addEventHandler(this, "rbtn_hex_random_clicked");
          rbtn_penta_random = new GOption(option_window, 20, 300, 140, 30);
          rbtn_penta_random.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
          rbtn_penta_random.setText("Pięciokątne (losowe)");
          rbtn_penta_random.setLocalColorScheme(GCScheme.CYAN_SCHEME);
          rbtn_penta_random.setOpaque(false);
          rbtn_penta_random.addEventHandler(this, "rbtn_penta_random_clicked");   
    tog_group_neighborhood.addControl(rbtn_VN);
    tog_group_neighborhood.addControl(rbtn_moore);
    rbtn_moore.setSelected(true);    
    tog_group_neighborhood.addControl(rbtn_hex_left);
    tog_group_neighborhood.addControl(rbtn_hex_right);
    tog_group_neighborhood.addControl(rbtn_hex_random);
    tog_group_neighborhood.addControl(rbtn_penta_random);

  //BC_CHOICE
  lbl_bc = new GLabel(option_window, 370, 320, 310, 20);
  lbl_bc.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_bc.setText("Warunki brzegowe");
  lbl_bc.setTextBold();
  lbl_bc.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  lbl_bc.setOpaque(true);
    tog_group_bc = new GToggleGroup();
      rbtn_non_periodical = new GOption(option_window, 370, 350, 310, 20);
      rbtn_non_periodical.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
      rbtn_non_periodical.setText("nieperiodczyne - odbijające");
      rbtn_non_periodical.setLocalColorScheme(GCScheme.CYAN_SCHEME);
      rbtn_non_periodical.setOpaque(true);
      rbtn_non_periodical.addEventHandler(this, "rbtn_non_periodical_clicked");
        rbtn_periodical = new GOption(option_window, 370, 370, 310, 20);
        rbtn_periodical.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
        rbtn_periodical.setText("periodyczne - zawijające");
        rbtn_periodical.setLocalColorScheme(GCScheme.CYAN_SCHEME);
        rbtn_periodical.setOpaque(true);
        rbtn_periodical.addEventHandler(this, "rbtn_periodical_clicked");
    tog_group_bc.addControl(rbtn_non_periodical);
    rbtn_non_periodical.setSelected(true);
    tog_group_bc.addControl(rbtn_periodical);

  //SEED_DRAW
  lbl_seeder = new GLabel(option_window, 180, 120, 150, 20);
  lbl_seeder.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_seeder.setText("Zarodkowanie");
  lbl_seeder.setTextBold();
  lbl_seeder.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  lbl_seeder.setOpaque(false);
    tog_group_seeds = new GToggleGroup();
      rbtn_random = new GOption(option_window, 180, 210, 150, 30);
      rbtn_random.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
      rbtn_random.setText("Losowe");
      rbtn_random.setLocalColorScheme(GCScheme.CYAN_SCHEME);
      rbtn_random.setOpaque(false);
      rbtn_random.addEventHandler(this, "rbtn_random_clicked");
        chkbx_radium = new GCheckbox(option_window, 200, 240, 130, 30);
        chkbx_radium.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
        chkbx_radium.setText("z promieniem");
        chkbx_radium.setLocalColorScheme(GCScheme.CYAN_SCHEME);
        chkbx_radium.setOpaque(false);
        chkbx_radium.addEventHandler(this, "chkbx_radium_changed");
        chkbx_radium.setEnabled(false);
          lbl_radium = new GLabel(option_window, 220, 270, 60, 30);
          lbl_radium.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
          lbl_radium.setText("promień:");
          lbl_radium.setOpaque(false);  
            txt_radium = new GTextField(option_window, 280, 270, 50, 30, G4P.SCROLLBARS_NONE);
            txt_radium.setText("10");
            txt_radium.setLocalColorScheme(GCScheme.CYAN_SCHEME);
            txt_radium.setOpaque(true);
            txt_radium.setTextEditEnabled(enabled);
            txt_radium.addEventHandler(this, "txt_radium_changed");
      rbtn_evenly = new GOption(option_window, 180, 150, 150, 30);
      rbtn_evenly.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
      rbtn_evenly.setText("Równomierne");
      rbtn_evenly.setLocalColorScheme(GCScheme.CYAN_SCHEME);
      rbtn_evenly.setOpaque(false);
      rbtn_evenly.addEventHandler(this, "rbtn_evenly_clicked");      
        rbtn_mouse = new GOption(option_window, 180, 180, 150, 30);
        rbtn_mouse.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
        rbtn_mouse.setText("Przez kliknięcie");
        rbtn_mouse.setLocalColorScheme(GCScheme.CYAN_SCHEME);
        rbtn_mouse.setOpaque(false);
        rbtn_mouse.addEventHandler(this, "rbtn_mouse_clicked");
      chkbx_mouse = new GCheckbox(option_window, 180, 300, 150, 30);
      chkbx_mouse.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
      chkbx_mouse.setText("Obsługa kliknięć myszy");
      chkbx_mouse.setLocalColorScheme(GCScheme.SCHEME_10);
      chkbx_mouse.setOpaque(false);
      chkbx_mouse.addEventHandler(this, "chkbx_mouse_changed");
      chkbx_mouse.setSelected(true);
    tog_group_seeds.addControl(rbtn_random);
    tog_group_seeds.addControl(rbtn_evenly);
    rbtn_evenly.setSelected(true);
    tog_group_seeds.addControl(rbtn_mouse);  
  
  //BOARD_PROP
  lbl_board_properties = new GLabel(option_window, 370, 70, 310, 30);
  lbl_board_properties.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_board_properties.setText("Właściwości planszy");
  lbl_board_properties.setTextBold();
  lbl_board_properties.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  lbl_board_properties.setOpaque(true);  
  //CELL_SIZE
    lbl_cell_properties = new GLabel(option_window, 20, 70, 310, 30);
    lbl_cell_properties.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    lbl_cell_properties.setText("Właściwości komórek");
    lbl_cell_properties.setTextBold();
    lbl_cell_properties.setLocalColorScheme(GCScheme.CYAN_SCHEME);
    lbl_cell_properties.setOpaque(true);
      lbl_cell_size = new GLabel(option_window, 370, 120, 120, 20);
      lbl_cell_size.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
      lbl_cell_size.setText("Rozmiar komórki");
      lbl_cell_size.setTextBold();
      lbl_cell_size.setLocalColorScheme(GCScheme.CYAN_SCHEME);
      lbl_cell_size.setOpaque(true);
        tog_group_cell = new GToggleGroup();
          rbtn_cell5 = new GOption(option_window, 370, 150, 120, 30);
          rbtn_cell5.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
          rbtn_cell5.setText("5x5");
          rbtn_cell5.setLocalColorScheme(GCScheme.CYAN_SCHEME);
          rbtn_cell5.setOpaque(true);
          rbtn_cell5.addEventHandler(this, "rbtn_cell5_clicked");
            rbtn_cell10 = new GOption(option_window, 370, 180, 120, 30);
            rbtn_cell10.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
            rbtn_cell10.setText("10x10");
            rbtn_cell10.setLocalColorScheme(GCScheme.CYAN_SCHEME);
            rbtn_cell10.setOpaque(true);
            rbtn_cell10.addEventHandler(this, "rbtn_cell10_clicked");      
          rbtn_cell15 = new GOption(option_window, 370, 210, 120, 30);
          rbtn_cell15.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
          rbtn_cell15.setText("15x15");
          rbtn_cell15.setLocalColorScheme(GCScheme.CYAN_SCHEME);
          rbtn_cell15.setOpaque(true);
          rbtn_cell15.addEventHandler(this, "rbtn_cell15_clicked");
            rbtn_cell20 = new GOption(option_window, 370, 240, 120, 30);
            rbtn_cell20.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
            rbtn_cell20.setText("20x20");
            rbtn_cell20.setLocalColorScheme(GCScheme.CYAN_SCHEME);
            rbtn_cell20.setOpaque(true);
            rbtn_cell20.addEventHandler(this, "rbtn_cell20_clicked");      
          rbtn_cell25 = new GOption(option_window, 370, 270, 120, 30);
          rbtn_cell25.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
          rbtn_cell25.setText("25x25");
          rbtn_cell25.setLocalColorScheme(GCScheme.CYAN_SCHEME);
          rbtn_cell25.setOpaque(true);  
          rbtn_cell25.addEventHandler(this, "rbtn_cell25_clicked");
        tog_group_cell.addControl(rbtn_cell5);
        rbtn_cell5.setSelected(true);
        tog_group_cell.addControl(rbtn_cell10);
        tog_group_cell.addControl(rbtn_cell15);
        tog_group_cell.addControl(rbtn_cell20);
        tog_group_cell.addControl(rbtn_cell25);        
    //BOARD_SIZE
    lbl_board_size = new GLabel(option_window, 510, 120, 170, 20);
    lbl_board_size.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    lbl_board_size.setText("Wymiary planszy");
    lbl_board_size.setTextBold();
    lbl_board_size.setLocalColorScheme(GCScheme.CYAN_SCHEME);
    lbl_board_size.setOpaque(true); 
      btn_resize = new GButton(option_window, 510, 270, 170, 30);
      btn_resize.setText("Zmień rozmiar planszy");
      btn_resize.setLocalColorScheme(GCScheme.CYAN_SCHEME);
      btn_resize.addEventHandler(this, "resize_clicked");
      btn_resize.setEnabled(false);
        lbl_width = new GLabel(option_window, 510, 230, 80, 30);
        lbl_width.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
        lbl_width.setText("Szerokość");
        lbl_width.setLocalColorScheme(GCScheme.CYAN_SCHEME);
        lbl_width.setOpaque(true);           
          slider_width = new GSlider(option_window, 510, 210, 170, 20, 10.0);
          slider_width.setLimits(800, 100, 1200);
          slider_width.setNumberFormat(G4P.INTEGER, 0);
          slider_width.setLocalColorScheme(GCScheme.CYAN_SCHEME);
          slider_width.setOpaque(false);
          slider_width.addEventHandler(this, "slider_width_changed");
          slider_width.setEnabled(false);
            txt_width = new GTextField(option_window, 600, 230, 80, 30, G4P.SCROLLBARS_NONE);
            txt_width.setText("800");
            txt_width.setLocalColorScheme(GCScheme.CYAN_SCHEME);
            txt_width.setOpaque(true);
            txt_width.addEventHandler(this, "txt_width_changed");
            txt_width.setEnabled(false);
        lbl_height = new GLabel(option_window, 510, 170, 80, 30);
        lbl_height.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
        lbl_height.setText("Wysokość");
        lbl_height.setLocalColorScheme(GCScheme.CYAN_SCHEME);
        lbl_height.setOpaque(true);            
          slider_height = new GSlider(option_window, 510, 150, 170, 20, 10.0);
          slider_height.setLimits(600, 100, 1200);
          slider_height.setNumberFormat(G4P.INTEGER, 0);
          slider_height.setLocalColorScheme(GCScheme.CYAN_SCHEME);
          slider_height.setOpaque(false);
          slider_height.addEventHandler(this, "slider_height_changed");
          slider_height.setEnabled(false);
            txt_height = new GTextField(option_window, 600, 170, 80, 30, G4P.SCROLLBARS_NONE);
            txt_height.setText("600");
            txt_height.setLocalColorScheme(GCScheme.CYAN_SCHEME);
            txt_height.setOpaque(true);
            txt_height.addEventHandler(this, "txt_height_changed");
            txt_height.setEnabled(false);
  
  //SYM_PROP
  lbl_simulation_properties = new GLabel(option_window, 20, 360, 310, 30);
  lbl_simulation_properties.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_simulation_properties.setText("Właściwości symulacji");
  lbl_simulation_properties.setTextBold();
  lbl_simulation_properties.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  lbl_simulation_properties.setOpaque(true);    
    //SEED_LIM
    lbl_seed_limits = new GLabel(option_window, 180, 410, 150, 20);
    lbl_seed_limits.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    lbl_seed_limits.setText("Ilość ziaren (%)");
    lbl_seed_limits.setTextBold();
    lbl_seed_limits.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
    lbl_seed_limits.setOpaque(true);    
      slider_seed = new GSlider(option_window, 180, 440, 150, 40, 10.0);
      slider_seed.setLimits(1, 0, 100);
      slider_seed.setValue(45);
      slider_seed.setNbrTicks(100);
      slider_seed.setNumberFormat(G4P.INTEGER, 0);
      slider_seed.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
      slider_seed.setOpaque(false);
      slider_seed.addEventHandler(this, "slider_seed_changed");          
        txt_seeds = new GTextField(option_window, 180, 480, 150, 30, G4P.SCROLLBARS_NONE);
        txt_seeds.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
        txt_seeds.setOpaque(true);
        txt_seeds.addEventHandler(this, "txt_seeds_changed");
        txt_seeds.setText("45");      
    //ITER_LIM
    lbl_iteration_limits = new GLabel(option_window, 20, 410, 150, 20);
    lbl_iteration_limits.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    lbl_iteration_limits.setText("Ilość iteracji (20-1000)");
    lbl_iteration_limits.setTextBold();
    lbl_iteration_limits.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
    lbl_iteration_limits.setOpaque(true);    
      slider_iteration = new GSlider(option_window, 20, 440, 150, 40, 10.0);
      slider_iteration.setLimits(20, 20, 1000);
      slider_iteration.setValue(400);
      slider_iteration.setNbrTicks(980);
      slider_iteration.setNumberFormat(G4P.INTEGER, 0);
      slider_iteration.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
      slider_iteration.setOpaque(false);
      slider_iteration.addEventHandler(this, "slider_iteration_changed");      
        txt_iteration = new GTextField(option_window, 20, 480, 150, 30, G4P.SCROLLBARS_NONE);
        txt_iteration.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
        txt_iteration.setOpaque(true);
        txt_iteration.setText("500");
        txt_iteration.addEventHandler(this, "txt_iteration_changed"); 
        
  //SYM_CHOICE
  lbl_simulation_choice = new GLabel(option_window, 20, 540, 310, 30);
  lbl_simulation_choice.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_simulation_choice.setText("Wybór symulacji");
  lbl_simulation_choice.setTextBold();
  lbl_simulation_choice.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  lbl_simulation_choice.setOpaque(true);
    dl_simulation = new GDropList(option_window, 20, 590, 310, 120, 5);
    dl_simulation.setItems(loadStrings("list_409834"), 1);
    dl_simulation.addEventHandler(this, "dl_simulation_chosen");

  //META
  lbl_footer = new GLabel(option_window, 20, 740, 660, 50);
  lbl_footer.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_footer.setText("Akademia Górniczo-Hutnicza, WIMiIP. Przedmiot 'Modelowanie Wieloskalowe', III rok.\n Wykonanie: Magdalena Żabińska, 2017");
  lbl_footer.setTextBold();
  lbl_footer.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  lbl_footer.setOpaque(false);
  
  lbl_title = new GLabel(option_window, 20, 20, 660, 30);
  lbl_title.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_title.setText("Program symulacji automatów komórkowych");
  lbl_title.setTextBold();
  lbl_title.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  lbl_title.setOpaque(true);
    //GUI help window
    lbl_help = new GLabel(help_window, 20, 20, 280, 30);
    lbl_help.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    lbl_help.setText("Pomoc");
    lbl_help.setTextBold();
    lbl_help.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
    lbl_help.setOpaque(true);
    textarea1 = new GTextArea(help_window, 20, 70, 280, 700, G4P.SCROLLBARS_NONE);
    textarea1.setOpaque(true);
    textarea1.setTextEditEnabled(false);
    textarea2 = new GTextArea(help_window, 320, 70, 280, 700, G4P.SCROLLBARS_NONE);
    textarea2.setOpaque(true);
    textarea2.setTextEditEnabled(false);
    textarea3 = new GTextArea(help_window, 620, 70, 280, 700, G4P.SCROLLBARS_NONE);
    textarea3.setOpaque(true);
    textarea3.setTextEditEnabled(false);
    textarea4 = new GTextArea(help_window, 920, 70, 280, 700, G4P.SCROLLBARS_NONE);
    textarea4.setOpaque(true);
    textarea4.setTextEditEnabled(false);
    option_window.loop();
    help_window.loop();
}

//Okno główne
String windowName = "Cellular Automata Simulator 2017";
GButton btn_startM; 
GButton btn_stopM; 
GButton btn_pauseM; 
GButton btn_options; 
boolean enabled = false;
GLabel iterationIndicator;
GLabel iterationIndicatorN;
GLabel simulationInformation;

//Okno ustawień
GWindow option_window;
  GLabel lbl_simulation_controls; 
    GButton btn_start; 
    GButton btn_pause; 
    GButton btn_clear; 
    GButton btn_end; 
    GButton btn_help; 

  GLabel lbl_simulation_properties; 
    GLabel lbl_seed_limits; 
      GSlider slider_seed; 
      GTextField txt_seeds; 
    GLabel lbl_iteration_limits; 
      GSlider slider_iteration; 
      GTextField txt_iteration; 

  GLabel lbl_board_size; 
    GLabel lbl_width; 
      GTextField txt_width; 
    GLabel lbl_height; 
      GTextField txt_height;

  GLabel lbl_cell_properties; 
    GLabel lbl_cell_size; 
    GToggleGroup tog_group_cell; 
      GOption rbtn_cell5; 
      GOption rbtn_cell10; 
      GOption rbtn_cell15; 
      GOption rbtn_cell20; 
      GOption rbtn_cell25;  

  GLabel lbl_neighborhood; 
    GToggleGroup tog_group_neighborhood; 
      GOption rbtn_VN; 
      GOption rbtn_moore; 
      GOption rbtn_hex_left; 
      GOption rbtn_hex_right; 
      GOption rbtn_hex_random; 
      GOption rbtn_penta_random; 

  GLabel lbl_bc; 
    GToggleGroup tog_group_bc; 
      GOption rbtn_non_periodical; 
      GOption rbtn_periodical; 

  GLabel lbl_seeder; 
    GToggleGroup tog_group_seeds; 
      GOption rbtn_random; 
      GOption rbtn_evenly; 
      GOption rbtn_mouse; 
      GCheckbox chkbx_radium; 
        GTextField txt_radium; 
      GCheckbox chkbx_mouse; 

  GLabel lbl_board_properties; 
    GSlider slider_height; 
    GSlider slider_width; 
    GButton btn_resize; 

  GLabel lbl_simulation_choice; 
    GDropList dl_simulation; 

  GLabel lbl_footer; 
  GLabel lbl_title; 

GLabel lbl_radium; 
GWindow help_window;
GLabel lbl_help; 
GTextArea textarea1; 
GTextArea textarea2; 
GTextArea textarea3; 
GTextArea textarea4; 