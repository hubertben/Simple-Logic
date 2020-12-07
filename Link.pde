class Link{
  
  public Pin source;
  public Pin destination;
  
  public ArrayList<LineSegment> line = new ArrayList<LineSegment>();
  
  Link(Pin source, Pin destination, ArrayList<LineSegment> line){
    
    this.line = line;
    
    if(source.condition){      // Source Either In or Out
      if(source.type && destination.type){  // Source: In, Dest: C_in
        this.source = source;
        this.destination = destination;
        if(!collect_inputs(source)){
          inputs_inUse.add(source);
        }
      }else if(!source.type && !destination.type){  // Source: Out, Dest: C_out
        this.source = destination;
        this.destination = source;
        if(!collect_outputs(source)){
          outputs_inUse.add(source);
        }
      }
      
      
    }else if(destination.condition){     // Destination Either In or Out 
      if(source.type && destination.type){ // Source: C_in, Dest: In
        this.source = destination;
        this.destination = source;
        if(!collect_inputs(destination)){
          inputs_inUse.add(destination);
        }
      }else if(!source.type && !destination.type){  // Source: C_out, Dest: Out
        this.source = source;
        this.destination = destination;
        if(!collect_outputs(destination)){
          outputs_inUse.add(destination);
        }
      }
      
      
      
      
    }else{
    
      if(!source.type && destination.type){
        this.source = source;
        this.destination = destination;
      }else if(source.type && !destination.type){
        this.source = destination;
        this.destination = source;
      }
    
    }
    
    
    if(inputs_inUse.size() > 8){
      println("PROBLEM");
    }
    

  }
  
  
 
  
  
  public void update(){
    if(source != null && destination != null){
     destination.state = source.state;
    }
  }
  
  public void display(){
    for(int i = 0; i < line.size(); i++){
      line.get(i).display(source);
    }
    
    
  }

}




class LineSegment{

  public int start_x;
  public int start_y;
  public int end_x;
  public int end_y;  
  
  LineSegment(int start_x, int start_y, int end_x, int end_y){
    this.start_x = start_x;
    this.start_y = start_y;
    this.end_x = end_x;
    this.end_y = end_y;
  
  }
  
  public void display(Pin source){
    //if(destination != null && source != null){
      if(source.state){
        stroke(255, 0 ,0);
      }else{
        stroke(0, 0 ,0);
      }
      strokeWeight(5);
      line(start_x, start_y, end_x, end_y);
    //}
  }
  

}
