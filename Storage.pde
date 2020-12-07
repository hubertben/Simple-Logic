

class Storage{

  public ArrayList<Circuit_Display> storage = new ArrayList<Circuit_Display>();
  
  Storage(){
      int[] not_board = {1, 0};
      int[] and_board = {0, 0, 0, 1};
      storage.add(new Circuit_Display("NOT", 0, 0, 1, 1, not_board));
      storage.add(new Circuit_Display("AND", 0, 0, 2, 1, and_board));
      
      update_location();
      
  }
  
  
  public void update_location(){
    float last_w = 15;
    for(int b = 0; b < storage.size(); b++){
      storage.get(b).x = last_w;
      storage.get(b).y = 775 - (storage.get(b).h / 2);
      last_w = storage.get(b).x + storage.get(b).w + 25;
    }
  }


  public void display(){
    update_location();
    for(int b = 0; b < storage.size(); b++){
      storage.get(b).display();
    }
  }
  
  public void checkAdd(){
    for(int b = 0; b < storage.size(); b++){
      if(storage.get(b).mouseOn()){
        Circuit_Display c = storage.get(b);
        board.add(new Circuit(c.name, (int)c.x, (int)c.y, c.inputs.length, c.outputs.length, c.bitboard));
      }
    }
  }
  
}
