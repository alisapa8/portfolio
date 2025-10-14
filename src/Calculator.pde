// Alisa Pavlova | 25.09.2025 | Calculator
Button[] buttons = new Button[12];
Button[] numButtons = new Button [10];
int num = 0;
float l, r, result;
String dVal;
String op;
boolean left;

void setup() {
  size(440, 320);
  l = 0.0;
  r = 0.0;
  result = 0.0;
  dVal = "0.0";
  op = " ";
  left = true;
  //functions
  buttons[0] = new Button(40, 120, 40, 40, "^", #ff69eb, #ff86c8);
  buttons[1] = new Button(100, 120, 40, 40, "%", #ff69eb, #ff86c8);
  buttons[2] = new Button(160, 120, 40, 40, "±", #ff69eb, #ff86c8);
  buttons[3] = new Button(220, 120, 40, 40, "÷", #ff69eb, #ff86c8);
  buttons[4] = new Button(280, 120, 40, 40, "*", #ff69eb, #ff86c8);
  buttons[5] = new Button(340, 120, 40, 40, "-", #ff69eb, #ff86c8);
  buttons[6] = new Button(400, 120, 40, 40, "+", #ff69eb, #ff86c8);
  buttons[7] = new Button(400, 180, 40, 40, ".", #ff69eb, #ff86c8);
  buttons[8] = new Button(400, 240, 40, 40, "=", #ff69eb, #ff86c8);
  buttons[9] = new Button(280, 240, 40, 40, "√", #ffa3a5, #ffbf81);
  buttons[10] = new Button(340, 240, 40, 40, "x²", #ffa3a5, #ffbf81);
  buttons[11] = new Button(217, 290, 250, 40, "CLEAR", #ffa3a5, #ffbf81);
  //numbers
  numButtons[9] = new Button(40, 180, 40, 40, "9", #ffa3a5, #ffbf81);
  numButtons[8] = new Button(100, 180, 40, 40, "8", #ffa3a5, #ffbf81);
  numButtons[7] = new Button(160, 180, 40, 40, "7", #ffa3a5, #ffbf81);
  numButtons[6] = new Button(220, 180, 40, 40, "6", #ffa3a5, #ffbf81);
  numButtons[5] = new Button(280, 180, 40, 40, "5", #ffa3a5, #ffbf81);
  numButtons[4] = new Button(340, 180, 40, 40, "4", #ffa3a5, #ffbf81);
  numButtons[3] = new Button(40, 240, 40, 40, "3", #ffa3a5, #ffbf81);
  numButtons[2] = new Button(100, 240, 40, 40, "2", #ffa3a5, #ffbf81);
  numButtons[1] = new Button(160, 240, 40, 40, "1", #ffa3a5, #ffbf81);
  numButtons[0] = new Button(220, 240, 40, 40, "0", #ffa3a5, #ffbf81);
}

void draw() {
  background(#61C9A8);
  for (int i = 0; i<buttons.length; i++) {
    buttons[i].display();
    buttons[i].hover(mouseX, mouseY);
  }
  for (int i = 0; i<numButtons.length; i++) {
    numButtons[i].display();
    numButtons[i].hover(mouseX, mouseY);
  }
  updateDisplay();
}

void mousePressed() {
  for (int i =0; i<buttons.length; i++) {
    if (buttons[i].over && buttons[i].val.equals("+")) {
      dVal = "0.0";
      left = false;
      op = "+";
    } else if (buttons[i].over && buttons[i].val.equals("CLEAR")) {
      l = 0.0;
      r = 0.0;
      result = 0.0;
      dVal = "0.0";
      op = "";
      left = true;
    } else if (buttons[i].over && buttons[i].val.equals("=")) {
      performCalculation();
    } else if (buttons[i].over && buttons[i].val.equals("*")) {
      dVal = "0.0";
      left = false;
      op = "*";
    } else if (buttons[i].over && buttons[i].val.equals("÷")) {
      dVal = "0.0";
      left = false;
      op = "÷";
    } else if (buttons[i].over && buttons[i].val.equals("-")) {
      dVal = "0.0";
      left = false;
      op = "-";
    } else if (buttons[i].over && buttons[i].val.equals("±")) {
      if (left) {
        l = l * -1;
        dVal = str(l);
      } else {
        r = r * -1;
        dVal = str(r);
      }
    } else if (buttons[i].over && buttons[i].val.equals("^")) {
      dVal = "0.0";
      left = false;
      op = "^";
    } else if (buttons[i].over && buttons[i].val.equals("x²")) {
      if (left) {
        l = sq(l);
        dVal = str(l);
      } else {
        r = sq(r);
        dVal = str(l);
      }
    } else if (buttons[i].over && buttons[i].val.equals("√")) {
      dVal = "0.0";
      left = false;
      op = "√";
    } else if (buttons[i].over && buttons[i].val.equals("%")) {
      if (left) {
        l = l*0.01;
        dVal = str(l);
      } else {
        r = r % (l);
      }
    } else if (buttons[i].over && buttons[i].val.equals(".")) {
      if (dVal.contains(".") == false) {
        dVal += ".";
      }
    }
  }



  for (int i = 0; i<numButtons.length; i++) {
    if (dVal.length()<26)
      if (numButtons[i].over && left == true) {
        if (dVal.equals("0.0")) {
          dVal = numButtons[i].val;
          l = float(dVal);
        } else {
          dVal += numButtons[i].val;
          l = float(dVal);
        }
      } else if (numButtons[i].over && left == false) {
        if (dVal.equals("0.0")) {
          dVal = numButtons[i].val;
          r = float(dVal);
        } else {
          dVal += numButtons[i].val;
          r = float(dVal);
        }
      }
  }

  println("l:" + l);
  println("r:" + r);
  println("result:" + result);
  println("left:" + left);
  println("op:" + op);
}

void updateDisplay () {
  rectMode(CORNER);
  fill(#BAD9A2);
  rect(20, 20, 400, 60, 5);
  fill(0);
  if (dVal.length()<=22) {
    textSize(35);
  }
  if (dVal.length()==23) {
    textSize(32);
  }
  if (dVal.length()==24) {
    textSize(29);
  }
  if (dVal.length()==26) {
    textSize(26);
  }
  textAlign(RIGHT);
  text(dVal, width-25, 65);
}

void performCalculation() {
  if (op.equals("+")) {
    result = l + r;
    dVal = str(result);
  } else if (op.equals("-")) {
    result = l - r;
    dVal = str(result);
  } else if (op.equals("*")) {
    result = l * r;
    dVal = str(result);
  } else if (op.equals("÷")) {
    result = l / r;
    dVal = str(result);
  } else if (op.equals("^")) {
    result = pow(l, r) ;
  } else if (op.equals("x²")) {
    result = sq(l) ;
  } else if (op.equals("√")) {
    result = sqrt(l) ;
  } else if (op.equals("%")) {
    result = l / r ;
  }
  dVal = str(result);
  l = result;
  left = true;
}

//void keyPressed() {
//  println("key:" + key);
//  println("keycode:" + keyCode);
//  if (key == 0|| keyCode == 96|| keyCode ==48) {
//    handleEvent ("0",true);
//  } else if (key == 1 || keyCode == 97 || keyCode == 49) {
//     handleEvent ("1",true);
//  } else if (key == '+' || keyCode == 17) {
//     handleEvent ("+",false);
//  }
//  printVals();
//}
//void handleEvent (String keyVal, boolean isNum) {
//  if (left && dVal.length()<12 && isNum) {
//    dVal = keyVal; {
//  } else {
//    dVal += keyVal;
//  }
//  l = float(dVal); 
//}
