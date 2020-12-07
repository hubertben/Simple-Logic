class Link{
  
  public Pin source;
  public Pin destination;
  
  Link(Pin source, Pin destination){
    
    
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
     destination.state = source.state;
  }
  
  public void display(){
    //if(destination != null && source != null){
      if(source.state){
        stroke(255, 0 ,0);
      }else{
        stroke(0, 0 ,0);
      }
      strokeWeight(5);
      line(source.x, source.y, destination.x, destination.y);
    //}
  }

}
