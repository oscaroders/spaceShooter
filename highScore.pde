int[] getHighScore(){
  int[] temp = new int[3];
  String[] highScore = loadStrings("score.txt");
  temp[0] = Integer.valueOf(highScore[0]);
  temp[1] = Integer.valueOf(highScore[1]);
  temp[2] = Integer.valueOf(highScore[2]);
  return temp;
}

void saveHighScore(){

  int[] temp = new int[3];
  temp = getHighScore();
  if(score >= temp[0]){
    temp[2] = temp[1];
    temp[1] = temp[0];
    temp[0] = score;
  } else if(score >= temp[1]){
    temp[2] = temp[1];
    temp[1] = score;
  } else if (score >= temp[2]){
    temp[2] = score;
  }

  String[] highScore = new String[3];
  highScore[0] = Integer.toString(temp[0]);
  highScore[1] = Integer.toString(temp[1]);
  highScore[2] = Integer.toString(temp[2]);
  saveStrings("score.txt", highScore);
}
