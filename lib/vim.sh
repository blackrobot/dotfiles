# Allow use of <C-q> in terminal vim sessions
function vim() {
  stty -ixon;
  command vim $* && stty ixon;
}
